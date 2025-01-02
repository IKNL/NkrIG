#!/bin/bash

TRUE=1
FALSE=0

sushi_build_output_path=$PWD/fsh-generated/resources
echo "pad: "$sushi_build_output_path

PrepareOutputDirectories ()
{
  ERROR=$FALSE

  if [[ -d "${sushi_build_output_path}/package" ]]
  then
    removed=`rm -f -v "\"${sushi_build_output_path}/package\"" 2>&1` || ERROR=$TRUE
    if [[ ${ERROR} -eq ${TRUE} ]]; then
      echo "ERROR: Cannot remove files in output package directory"
      echo -e "---------------------------\n${removed}\n------------------------------"
      exit 1
    fi
    removed=`rmdir "${sushi_build_output_path}/package" 2>&1`|| ERROR=$TRUE
    if [[ ${ERROR} -eq ${TRUE} ]]; then
      echo "ERROR: Could not remove package directory"
      echo -e "---------------------------\n${removed}\n--------------------------------"
      exit 1
    fi
    echo "Package directory removed"
  fi

  created=`mkdir "${sushi_build_output_path}/package" 2>&1`|| ERROR=$TRUE
  if [[ ${ERROR} -eq ${TRUE} ]]; then
    echo "ERROR: Package directory could not be recreated"
    echo -e "--------------------------- \n${created}\n---------------------------------"
    exit 1
  fi
  echo "Package directory was recreated"

}

CreateTarFile ()
{

  FILES=`ls "${sushi_build_output_path}" | grep \StructureDefinition`

  for name in ${FILES[@]}
  do
    source="${sushi_build_output_path}/${name}"
    destination="${sushi_build_output_path}/package/${name}"
    echo "source:" $source
    echo "destination:" $destination
    succes=`cp "${source}" "${destination}" 2>&1` || ERROR=$TRUE
    if [[ ${ERROR} -eq ${TRUE} ]]; then
      echo "ERROR: Unable to copy one or more files to target archive directory"
      echo -e "--------------------------- \n${succes}\n---------------------------------"
      exit 1
    fi
  done
  package_with_version="${PACKAGE_NAME}-v${VERSION_NUMBER}"
  tar_filename="${sushi_build_output_path}/${package_with_version}.tgz"
  echo "Compressing profile files to package ${package_with_version}.tgz"
  result=`tar -cvzf "${tar_filename}" "${sushi_build_output_path}/package" 2>&1` || ERROR=$TRUE
  [[ ${ERROR} -eq ${TRUE} ]] && "Unable to compress files, check error output" && exit 1
  echo "files were compressed at ${sushi_build_output_path} to '${package_with_version}.tgz'"
}

for arg in "$@";
do
  name="${arg/=*/}"
  value="${arg/${name}=/}"
  case "${name}" in
    --package-name)
      [[ "${value}" == "${name}" ]] && echo "No package name provided"
      PACKAGE_NAME="${value}"
      ;;
    --version-number)
      [[ "${value}" == "${name}" ]] && echo "no version provided." && exit 1
      VERSION_NUMBER="${value}"
      ;;
 esac
done

[[ "${VERSION_NUMBER}" == "" ]] && echo "no version number was provided, use '--version-number' as an argument to specify the name of the version number" && exit 1
[[ "${PACKAGE_NAME}" == "" ]] && echo "No package name was provided, use '--package-name' as an argument to specify a package name" && exit 1
[[ ! -d "${sushi_build_output_path}" ]] && echo "output path ${sushi_build_output_path} does not exist" && exit 1
[[ ! $(ls -A ${sushi_build_output_path}) ]] && echo "Output directory is empty" && exit 1

PrepareOutputDirectories
CreateTarFile
echo "Done."