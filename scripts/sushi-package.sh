#!/usr/bin/env bash
set -euo pipefail

# Runs SUSHI and assembles a FHIR package with:
#   - StructureDefinition resources (profiles/extensions)
#   - ImplementationGuide resource
#   - example/ folder with Bundle instances
#   - .index.json (package index; no .index.db)
#
# Output:
#   sushi-generated-packages/<packageId>#<version>/package/...
#   sushi-generated-packages/<packageId>#<version>/<packageId>-<version>.tgz

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

CONFIG_FILE="sushi-config.yaml"
OUT_ROOT="sushi-generated-packages"

if [[ ! -f "${CONFIG_FILE}" ]]; then
  echo "ERROR: ${CONFIG_FILE} not found in ${ROOT_DIR}"
  exit 1
fi

yaml_get_scalar() {
  local key="$1"
  sed -n "s/^[[:space:]]*${key}:[[:space:]]*\\([^#]*\\)\\(#.*\\)\?$/\\1/p" "${CONFIG_FILE}" \
    | head -n 1 \
    | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//'
}

PACKAGE_ID="$(yaml_get_scalar id)"
PACKAGE_VERSION="$(yaml_get_scalar version)"
FHIR_VERSION="$(yaml_get_scalar fhirVersion)"
CANONICAL="$(yaml_get_scalar canonical)"
TITLE="$(yaml_get_scalar title)"

if [[ -z "${PACKAGE_ID}" || -z "${PACKAGE_VERSION}" ]]; then
  echo "ERROR: Could not read id/version from ${CONFIG_FILE}"
  exit 1
fi

PACKAGE_DIR="${OUT_ROOT}/${PACKAGE_ID}#${PACKAGE_VERSION}"
PACKAGE_CONTENT_DIR="${PACKAGE_DIR}/package"
EXAMPLE_DIR="${PACKAGE_CONTENT_DIR}/example"
TGZ_NAME="${PACKAGE_ID}-${PACKAGE_VERSION}.tgz"

mkdir -p "${PACKAGE_CONTENT_DIR}"

echo "Running SUSHI to generate resources..."
sushi .

GEN_RES_DIR="fsh-generated/resources"
if [[ ! -d "${GEN_RES_DIR}" ]]; then
  echo "ERROR: Expected SUSHI output folder not found: ${GEN_RES_DIR}"
  exit 1
fi

echo "Creating package folder at ${PACKAGE_CONTENT_DIR}"
rm -rf "${PACKAGE_CONTENT_DIR:?}/"*
mkdir -p "${PACKAGE_CONTENT_DIR}" "${EXAMPLE_DIR}"

shopt -s nullglob
STRUCTURE_DEFS=( "${GEN_RES_DIR}"/StructureDefinition-*.json )
BUNDLES=( "${GEN_RES_DIR}"/Bundle-*.json )
shopt -u nullglob

if [[ ${#STRUCTURE_DEFS[@]} -eq 0 ]]; then
  echo "ERROR: No StructureDefinition-*.json found in ${GEN_RES_DIR}"
  exit 1
fi

cp -f "${STRUCTURE_DEFS[@]}" "${PACKAGE_CONTENT_DIR}/"

if [[ -f "${GEN_RES_DIR}/ImplementationGuide-${PACKAGE_ID}.json" ]]; then
  cp -f "${GEN_RES_DIR}/ImplementationGuide-${PACKAGE_ID}.json" "${PACKAGE_CONTENT_DIR}/"
fi

if [[ ${#BUNDLES[@]} -gt 0 ]]; then
  echo "Copying ${#BUNDLES[@]} example Bundle(s) to ${EXAMPLE_DIR}"
  cp -f "${BUNDLES[@]}" "${EXAMPLE_DIR}/"
else
  echo "WARNING: No Bundle-*.json found in ${GEN_RES_DIR}; example/ folder will be empty"
fi

write_package_json() {
  local out_file="${PACKAGE_CONTENT_DIR}/package.json"
  local deps_json="{}"

  if command -v python3 >/dev/null 2>&1; then
    deps_json="$(python3 - <<'PY'
import re, json
cfg="sushi-config.yaml"
deps={}
in_deps=False
with open(cfg, "r", encoding="utf-8") as f:
    for line in f:
        if re.match(r"^\s*dependencies:\s*$", line):
            in_deps=True
            continue
        if in_deps:
            if re.match(r"^\S", line):
                break
            m=re.match(r"^\s{2}([^:#]+):\s*([^\s#]+)\s*$", line)
            if m:
                deps[m.group(1).strip()]={"version": m.group(2).strip()}
print(json.dumps(deps, ensure_ascii=False))
PY
)"
  fi

  cat > "${out_file}" <<EOF
{
  "name": "${PACKAGE_ID}",
  "version": "${PACKAGE_VERSION}",
  "canonical": "${CANONICAL}",
  "title": "${TITLE}",
  "description": "SUSHI-generated FHIR package for ${PACKAGE_ID}",
  "fhirVersions": [
    "${FHIR_VERSION}"
  ],
  "dependencies": ${deps_json},
  "directories": {
    "lib": "package",
    "example": "example"
  }
}
EOF
}

write_index_json() {
  if ! command -v python3 >/dev/null 2>&1; then
    echo "ERROR: python3 is required to generate .index.json"
    exit 1
  fi

  python3 - <<'PY'
import json
import os
from pathlib import Path

package_dir = Path(os.environ["PACKAGE_CONTENT_DIR"])
entries = []

for path in sorted(package_dir.glob("*.json")):
    if path.name == "package.json":
        continue
    with path.open(encoding="utf-8") as f:
        resource = json.load(f)

    entry = {
        "filename": path.name,
        "resourceType": resource["resourceType"],
        "id": resource["id"],
    }
    if resource.get("url"):
        entry["url"] = resource["url"]
    if resource.get("version"):
        entry["version"] = resource["version"]

    if resource["resourceType"] == "StructureDefinition":
        if resource.get("kind"):
            entry["kind"] = resource["kind"]
        if resource.get("type"):
            entry["type"] = resource["type"]
        if resource.get("derivation"):
            entry["derivation"] = resource["derivation"]

    entries.append(entry)

index = {"index-version": 2, "files": entries}
index_path = package_dir / ".index.json"
with index_path.open("w", encoding="utf-8") as f:
    json.dump(index, f, indent=2)
    f.write("\n")

print(f"Wrote {index_path} with {len(entries)} indexed resource(s)")
PY
}

write_package_json
export PACKAGE_CONTENT_DIR
write_index_json

# Ensure no .index.db is produced
rm -f "${PACKAGE_CONTENT_DIR}/.index.db"

echo "Creating .tgz package ${PACKAGE_DIR}/${TGZ_NAME}"
(
  cd "${PACKAGE_DIR}"
  rm -f "${TGZ_NAME}"
  tar -czf "${TGZ_NAME}" package
)

echo "Done."
echo "Unpacked package: ${PACKAGE_CONTENT_DIR}"
echo "Examples: ${EXAMPLE_DIR}"
echo "Index: ${PACKAGE_CONTENT_DIR}/.index.json"
echo "Packaged tgz: ${PACKAGE_DIR}/${TGZ_NAME}"
