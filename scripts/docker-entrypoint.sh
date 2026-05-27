#!/usr/bin/env bash
set -euo pipefail

# Package versions must match sushi-config.yaml dependencies
NL_CORE_VER="0.12.0-beta.4"
ZIB_VER="0.12.0-beta.4"
MED_VER="2.0.0-rc.7"

FHIR_PACKAGES="${HOME}/.fhir/packages"

ensure_executable_scripts() {
  local f
  for f in _genonce.sh _gencontinuous.sh _updatePublisher.sh scripts/sushi-package.sh; do
    if [[ -f "${f}" ]]; then
      sed -i 's/\r$//' "${f}"
      chmod +x "${f}"
    fi
  done
}

ensure_publisher_jar() {
  mkdir -p input-cache
  if [[ ! -f input-cache/publisher.jar ]]; then
    echo "Placing IG Publisher in input-cache/publisher.jar"
    cp /opt/ig-publisher/publisher.jar input-cache/publisher.jar
  fi
}

install_vendor_tgz() {
  local package_id="$1"
  local version="$2"
  local tgz_file="$3"
  local target="${FHIR_PACKAGES}/${package_id}#${version}"

  if [[ ! -f "${tgz_file}" ]]; then
    return 0
  fi

  echo "Installing ${package_id}#${version} from ${tgz_file}"
  mkdir -p "${target}"
  tar xzf "${tgz_file}" -C "${target}"
}

install_vendor_packages() {
  if [[ ! -d vendor ]]; then
    echo "No vendor/ directory — SUSHI will download dependencies (snapshots may require manual packages; see README)."
    return 0
  fi

  # Preferred filenames (same as CI); fall back to glob patterns if names differ slightly.
  local nl_core_tgz=""
  local zib_tgz=""
  local med_tgz=""

  shopt -s nullglob
  for candidate in \
    "vendor/nictiz.fhir.nl.r4.nl-core-${NL_CORE_VER}-snapshots.tgz" \
    vendor/nictiz.fhir.nl.r4.nl-core-*-snapshots.tgz; do
    if [[ -f "${candidate}" ]]; then nl_core_tgz="${candidate}"; break; fi
  done
  for candidate in \
    "vendor/nictiz.fhir.nl.r4.zib2020-${ZIB_VER}-snapshots.tgz" \
    vendor/nictiz.fhir.nl.r4.zib2020-*-snapshots.tgz; do
    if [[ -f "${candidate}" ]]; then zib_tgz="${candidate}"; break; fi
  done
  for candidate in \
    "vendor/nictiz.fhir.nl.r4.medicationprocess9-${MED_VER}-snapshots.tgz" \
    vendor/nictiz.fhir.nl.r4.medicationprocess9-*-snapshots.tgz; do
    if [[ -f "${candidate}" ]]; then med_tgz="${candidate}"; break; fi
  done
  shopt -u nullglob

  install_vendor_tgz "nictiz.fhir.nl.r4.nl-core" "${NL_CORE_VER}" "${nl_core_tgz}"
  install_vendor_tgz "nictiz.fhir.nl.r4.zib2020" "${ZIB_VER}" "${zib_tgz}"
  install_vendor_tgz "nictiz.fhir.nl.r4.medicationprocess9" "${MED_VER}" "${med_tgz}"

  local med_pkg="${FHIR_PACKAGES}/nictiz.fhir.nl.r4.medicationprocess9#${MED_VER}"
  if [[ -d "${med_pkg}" ]]; then
    # Same sed fix as .github/workflows/main.yaml (duplicate meta.source in ValueSets)
    find "${med_pkg}" -type f -print0 \
      | xargs -0 sed -i \
        's/\("meta":{\("lastUpdated":"[^"]*",\)\?\)"source":"http:\/\/decor\.nictiz\.nl\/fhir\/4.0\/mp-",/\1/' \
      2>/dev/null || true
  fi
}

cd /work
ensure_executable_scripts
ensure_publisher_jar
install_vendor_packages

exec "$@"
