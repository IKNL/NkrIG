#!/bin/bash

TRUE=1
FALSE=0

sushi_build_output_path=$PWD/fsh-generated/resources
echo "Working path: $sushi_build_output_path"

PrepareOutputDirectories ()
{
  local ERROR=$FALSE
  echo "Recreating package output location"

  if [[ -d "${sushi_build_output_path}/package" ]]
  then
    removed=`rm -f -v -r "${sushi_build_output_path}/package" 2>&1` || ERROR=$TRUE
    if [[ ${ERROR} -eq ${TRUE} ]]; then
      echo "ERROR: Cannot remove files in output package directory"
      echo -e "---------------------------\n${removed}\n------------------------------"
      exit 1
    fi
  fi

  created=`mkdir "${sushi_build_output_path}/package" 2>&1`|| ERROR=$TRUE
  if [[ ${ERROR} -eq ${TRUE} ]]; then
    echo "ERROR: Package directory '${sushi_build_output_path}/package' could not be recreated"
    echo -e "--------------------------- \n${created}\n---------------------------------"
    exit 1
  fi

  created=`mkdir "${sushi_build_output_path}/package/examples" 2>&1`|| ERROR=$TRUE
  if [[ ${ERROR} -eq ${TRUE} ]]; then
    echo "ERROR: Directory '${sushi_build_output_path}/package/examples' could not be recreated"
    echo -e "--------------------------- \n${created}\n---------------------------------"
    exit 1
  fi
}

CopyProfileFiles ()
{
  echo "Copying profile files"

  local ERROR=$FALSE
  FILES=`ls "${sushi_build_output_path}" | grep \StructureDefinition`

  for name in ${FILES[@]}
  do
    source="${sushi_build_output_path}/${name}"
    destination="${sushi_build_output_path}/package/${name}"
    echo "source:" $source
    echo "destination:" $destination
    succes=`cp "${source}" "${destination}" 2>&1` || ERROR=$TRUE
    if [[ ${ERROR} -eq ${TRUE} ]]; then
      echo "ERROR: Unable to copy profile files to target archive directory, exiting"
      echo -e "--------------------------- \n${succes}\n---------------------------------"
      exit 1
    fi
  done
}

CopyExampleFiles ()
{
  echo "Copying example files"

  local ERROR=$FALSE
  FILES=`ls "${sushi_build_output_path}" | grep -v '\StructureDefinition\|package\|Parameters\|Implementation'`

  for name in ${FILES[@]}
  do
    source="${sushi_build_output_path}/${name}"
    destination="${sushi_build_output_path}/package/examples/${name}"
    echo "source:" $source
    echo "destination:" $destination
    succes=`cp "${source}" "${destination}" 2>&1` || ERROR=$TRUE
    if [[ ${ERROR} -eq ${TRUE} ]]; then
      echo "ERROR: Unable to copy example files to target archive directory, exiting"
      echo -e "--------------------------- \n${succes}\n---------------------------------"
      exit 1
    fi
  done
}

CreateTarFile ()
{
  local ERROR=$FALSE

  package_with_version="${PACKAGE_NAME}-v${VERSION_NUMBER}"
  tar_filename="${package_with_version}.tgz"
  echo "Compressing profile files to package ${package_with_version}.tgz"
  cd "${sushi_build_output_path}"

  if [[ -f ${tar_filename} ]]; then
    echo "Found existing package from previous run, removing it now"
    result=`rm -f ${tar_filename} 2>&1` || ERROR=$TRUE
    [[ $ERROR -eq $TRUE ]] && echo "Unable to remove existing package file, exiting" && exit 1
  fi

  result=`tar -cvzf "${tar_filename}" "package" 2>&1` || ERROR=$TRUE
  if [[ ${ERROR} -eq ${TRUE} ]]
  then
    echo "ERROR: Unable to compress files."
    echo -e "--------------------------- \n${result}\n---------------------------------"
    exit 1
  fi
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
CopyProfileFiles
CopyExampleFiles
CreateTarFile

echo "Done."