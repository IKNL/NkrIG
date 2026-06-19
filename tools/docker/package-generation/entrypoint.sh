#!/bin/bash
set -euo pipefail

FILENAME="${1:-}"

if [[ -z "${FILENAME}" ]]; then
  echo "Usage: create-package-file <filename>"
  echo "  filename  Name of the output package file (e.g. ncr-ehr-package.tgz)"
  exit 1
fi

PACKAGE_NAME="${FILENAME%.tgz}"

exec /app/create-package.sh --package-name="${PACKAGE_NAME}" --filename="${FILENAME}"
