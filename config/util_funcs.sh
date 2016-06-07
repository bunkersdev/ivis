#!/bin/bash
. cluster.profile
. env.profile
. app.profile

# Function Name: replaceAllEnvParamsInFile
# Purpose:       Does in-place variable substitution in a file. Variables in the file should be marked with double brackets. ex:
# Arguments:
#                $1 - File to perform replacement on
function replaceAllEnvParamsInFile {
  local _filename=$1
  local _variableName

  #Get a list of all the variable names we found in the file
  for _variableName in $(getListOfEnvParams "${_filename}");do
    #Don't replace it if it's not set (this will still replace if it's set to an empty string)
    if [[ -z ${!_variableName+x} ]];then
      continue
    fi

    sed -i -e "s#\[\[${_variableName}]\]#${!_variableName}#g" ${_filename}
  done
}

# Function Name: getListOfEnvParams
# Purpose:       Helper function for envParams functions. Gets a list of variables from a file or stdin if no file is specified.
#                Variables should be marked with double brackets. ex:
# Arguments:
#                $1 - (Optional) Name of file to get variables from
function getListOfEnvParams
{
  # Regex purpose: Find all matches for strings in variable replacement syntax (). Only capture valid variable names.
  # \[\[     Find preceeding double brackets
  # ([[:alpha:]_][[:alnum:]_]*)   Capture group for variable name. Allows alpha or underscore for the first character and
  #                               0 or more alpha/numeric/underscores for the rest of the name
  # \]\]     Find the brackets that mark the end of the variable name
  # /g       Global operation
  cat "${1:-/dev/stdin}" |  perl -nle 'print "$1" while(/\[\[([[:alpha:]_][[:alnum:]_]*)\]\]/g)' | sort -u
}
