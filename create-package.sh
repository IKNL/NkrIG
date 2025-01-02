#!/bin/bash

sushi_build_output_path=$PWD/fsh-generated/resources
echo $sushi_build_output_path

for arg in "$@";
do
  name="${arg/=*/}"
  value="${arg/${name}=/}"
  case "${name}" in
    --version-number)
      [[ "${value}" == "${name}" ]] && echo "no version provided." && exit 1
      VERSION_NUMBER="${value}"
      ;;
 esac
done

[[ "${VERSION_NUMBER}" == "" ]] && echo "no version number was provided, use '--version-number' as an argument to specify the name of the version number, exiting." && exit 1
echo "$VERSION_NUMBER"
[[ ! -d "./${sushi_build_output_path}" ]] && echo "output path ${sushi_build_output_path} does not exist" && exit 1
[[ ! -e ${sushi_build_output_path}/*.json ]] && echo "no files found in output path '${sushi_build_output_path}'" && exit 1