#!/usr/bin/env bash

set -o errexit
set -o nounset

usage() {
  echo "Usage: version.sh -s [git|empty]"
  echo -n "   -s  source default is empty"
  exit 1
}

check_params() {
  while getopts ":s:" o; do
    case "${o}" in
      s) source=${OPTARG}
        [ "$source" = "git" ] || [ "$source" = "empty" ] || usage
        ;;
      *) usage
        ;;
    esac
  done
  shift $((OPTIND -1))
  if [ $# -gt 1 ]; then
    usage
  fi
}

fetch_data(){
  tags=$(git fetch --tags)
  hash=$(git rev-parse --short HEAD)
  version=$(git describe --abbrev=0 --tags)
  version_name="${version:-0.0.0}-${hash:-0}"
  echo "Version:$version_name"
}
# TARGET=${ACTUAL}/${OUTPUT}/version.html;

# head ${TARGET};

main() {
  source=""
  check_params "$@"
  fetch_data
}

main "$@"
