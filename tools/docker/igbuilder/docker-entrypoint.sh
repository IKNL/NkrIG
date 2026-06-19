#!/usr/bin/env bash
set -euo pipefail

FHIR_PACKAGES="${HOME}/.fhir/packages"
SIMPLIFIER_REGISTRY="${SIMPLIFIER_REGISTRY:-https://packages.simplifier.net}"
SIMPLIFIER_API="${SIMPLIFIER_API:-https://api.simplifier.net}"

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

read_nictiz_dependencies() {
  if [[ ! -f sushi-config.yaml ]]; then
    echo "ERROR: sushi-config.yaml not found in /work" >&2
    exit 1
  fi

  ruby -ryaml -e '
    deps = YAML.load_file("sushi-config.yaml")["dependencies"] || {}
    deps.each do |package_id, version|
      next unless package_id.start_with?("nictiz.")
      version = version["version"] if version.is_a?(Hash)
      puts "#{package_id}\t#{version}"
    end
  '
}

vendor_archive_path() {
  local package_id="$1"
  local version="$2"
  echo "vendor/${package_id}-${version}-snapshots.tgz"
}

vendor_has_package() {
  local package_id="$1"
  local version="$2"
  local preferred
  preferred="$(vendor_archive_path "${package_id}" "${version}")"

  if [[ -f "${preferred}" ]]; then
    return 0
  fi

  shopt -s nullglob
  local candidate
  for candidate in \
    "vendor/${package_id}-${version}.tgz" \
    "vendor/${package_id}"-*"${version}"*.tgz; do
    if [[ -f "${candidate}" ]]; then
      shopt -u nullglob
      return 0
    fi
  done
  shopt -u nullglob

  return 1
}

vendor_is_empty_or_missing() {
  if [[ ! -d vendor ]]; then
    return 0
  fi

  shopt -s nullglob
  local archives=(vendor/*.tgz)
  shopt -u nullglob

  [[ "${#archives[@]}" -eq 0 ]]
}

vendor_needs_download() {
  local package_id version
  local missing=0

  if vendor_is_empty_or_missing; then
    return 0
  fi

  while IFS=$'\t' read -r package_id version; do
    [[ -z "${package_id}" ]] && continue
    if ! vendor_has_package "${package_id}" "${version}"; then
      missing=1
      break
    fi
  done < <(read_nictiz_dependencies)

  [[ "${missing}" -eq 1 ]]
}

simplifier_auth_header() {
  if [[ -n "${SIMPLIFIER_TOKEN:-}" ]]; then
    printf 'Authorization: Bearer %s' "${SIMPLIFIER_TOKEN}"
    return 0
  fi

  if [[ -n "${SIMPLIFIER_EMAIL:-}" && -n "${SIMPLIFIER_PASSWORD:-}" ]]; then
    local token_response token
    token_response="$(
      curl -fsS -X POST "${SIMPLIFIER_API}/token" \
        -H "Content-Type: application/json" \
        -d "{\"Email\":\"${SIMPLIFIER_EMAIL}\",\"Password\":\"${SIMPLIFIER_PASSWORD}\"}" \
        2>&1
    )" || {
      echo "ERROR: Simplifier authentication failed: ${token_response}" >&2
      return 1
    }

    token="$(
      printf '%s' "${token_response}" | ruby -rjson -e '
        data = JSON.parse(STDIN.read)
        token = data["token"] || data["Token"]
        abort "missing token field" if token.nil? || token.empty?
        print token
      ' 2>&1
    )" || {
      echo "ERROR: Could not parse Simplifier token response: ${token}" >&2
      return 1
    }

    printf 'Authorization: Bearer %s' "${token}"
    return 0
  fi

  return 1
}

registry_tarball_url() {
  local package_id="$1"
  local version="$2"
  local auth_header="${3:-}"

  local metadata curl_args=(-fsS)
  if [[ -n "${auth_header}" ]]; then
    curl_args+=(-H "${auth_header}")
  fi

  metadata="$(
    curl "${curl_args[@]}" "${SIMPLIFIER_REGISTRY}/${package_id}" 2>&1
  )" || return 1

  printf '%s' "${metadata}" | ruby -rjson -e '
    package_id, version = ARGV
    data = JSON.parse(STDIN.read)
    url = data.dig("versions", version, "dist", "tarball")
    abort unless url
    print url
  ' "${package_id}" "${version}" 2>/dev/null
}

download_candidate_urls() {
  local package_id="$1"
  local version="$2"
  local registry_url="$3"

  cat <<EOF
${registry_url}
${SIMPLIFIER_REGISTRY}/${package_id}/${version}
${SIMPLIFIER_REGISTRY}/${package_id}/-/${package_id}-${version}.tgz
EOF
}

download_vendor_package() {
  local package_id="$1"
  local version="$2"
  local auth_header="${3:-}"
  local target archive_path curl_args=(-fL --retry 2 --retry-delay 1)
  local registry_url="" url

  archive_path="$(vendor_archive_path "${package_id}" "${version}")"
  mkdir -p vendor

  if [[ -n "${auth_header}" ]]; then
    curl_args+=(-H "${auth_header}")
    registry_url="$(registry_tarball_url "${package_id}" "${version}" "${auth_header}" || true)"
  else
    registry_url="$(registry_tarball_url "${package_id}" "${version}" || true)"
  fi

  while IFS= read -r url; do
    [[ -z "${url}" ]] && continue
    echo "Trying download: ${url}"
    if curl "${curl_args[@]}" -o "${archive_path}.partial" "${url}"; then
      if tar -tzf "${archive_path}.partial" >/dev/null 2>&1; then
        mv "${archive_path}.partial" "${archive_path}"
        echo "Downloaded ${package_id}#${version} to ${archive_path}"
        return 0
      fi
      echo "Download from ${url} was not a valid .tgz archive" >&2
      rm -f "${archive_path}.partial"
    fi
  done < <(download_candidate_urls "${package_id}" "${version}" "${registry_url}")

  return 1
}

ensure_vendor_packages_from_simplifier() {
  local package_id version auth_header="" auth_available=0
  local failures=()

  if ! vendor_needs_download; then
    echo "vendor/ already contains packages matching sushi-config.yaml dependencies"
    return 0
  fi

  echo "vendor/ is empty or missing required Nictiz packages from sushi-config.yaml"
  echo "Attempting to download packages from Simplifier (${SIMPLIFIER_REGISTRY})"

  if auth_header="$(simplifier_auth_header 2>/dev/null)"; then
    auth_available=1
    echo "Using Simplifier authentication"
  else
    echo "No Simplifier credentials supplied; trying public package registry only"
  fi

  mkdir -p vendor

  while IFS=$'\t' read -r package_id version; do
    [[ -z "${package_id}" ]] && continue
    if vendor_has_package "${package_id}" "${version}"; then
      echo "Already present in vendor/: ${package_id}#${version}"
      continue
    fi

    if download_vendor_package "${package_id}" "${version}" "${auth_header}"; then
      continue
    fi

    if [[ "${auth_available}" -eq 0 ]]; then
      failures+=("${package_id}#${version} (no public download; Simplifier credentials may be required)")
    else
      failures+=("${package_id}#${version}")
    fi
  done < <(read_nictiz_dependencies)

  if [[ "${#failures[@]}" -gt 0 ]]; then
    echo "ERROR: Failed to download required Nictiz packages from Simplifier:" >&2
    printf '  - %s\n' "${failures[@]}" >&2
    echo >&2
    echo "Manual recovery:" >&2
    echo "  1. Download the packages with snapshots from https://simplifier.net/" >&2
    echo "  2. Place them in vendor/ using names like:" >&2
    while IFS=$'\t' read -r package_id version; do
      [[ -z "${package_id}" ]] && continue
      echo "       vendor/${package_id}-${version}-snapshots.tgz" >&2
    done < <(read_nictiz_dependencies)
    echo "  3. Or set SIMPLIFIER_EMAIL and SIMPLIFIER_PASSWORD (or SIMPLIFIER_TOKEN) and retry" >&2
    exit 1
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

resolve_vendor_tgz() {
  local package_id="$1"
  local version="$2"
  local preferred candidate

  preferred="$(vendor_archive_path "${package_id}" "${version}")"
  if [[ -f "${preferred}" ]]; then
    echo "${preferred}"
    return 0
  fi

  shopt -s nullglob
  for candidate in \
    "vendor/${package_id}-${version}.tgz" \
    "vendor/${package_id}"-*"${version}"*-snapshots.tgz \
    "vendor/${package_id}"-*"${version}"*.tgz; do
    if [[ -f "${candidate}" ]]; then
      shopt -u nullglob
      echo "${candidate}"
      return 0
    fi
  done
  shopt -u nullglob

  return 1
}

install_vendor_packages() {
  local package_id version tgz_file

  if [[ ! -d vendor ]]; then
    echo "No vendor/ directory after dependency resolution"
    return 0
  fi

  while IFS=$'\t' read -r package_id version; do
    [[ -z "${package_id}" ]] && continue
    tgz_file="$(resolve_vendor_tgz "${package_id}" "${version}" || true)"
    install_vendor_tgz "${package_id}" "${version}" "${tgz_file}"
  done < <(read_nictiz_dependencies)

  local med_ver
  med_ver="$(read_nictiz_dependencies | awk -F '\t' '$1=="nictiz.fhir.nl.r4.medicationprocess9"{print $2; exit}')"
  if [[ -n "${med_ver}" ]]; then
    local med_pkg="${FHIR_PACKAGES}/nictiz.fhir.nl.r4.medicationprocess9#${med_ver}"
    if [[ -d "${med_pkg}" ]]; then
      find "${med_pkg}" -type f -print0 \
        | xargs -0 sed -i \
          's/\("meta":{\("lastUpdated":"[^"]*",\)\?\)"source":"http:\/\/decor\.nictiz\.nl\/fhir\/4.0\/mp-",/\1/' \
        2>/dev/null || true
    fi
  fi
}

cd /work
ensure_executable_scripts
ensure_publisher_jar
ensure_vendor_packages_from_simplifier
install_vendor_packages

exec "$@"
