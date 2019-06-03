#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

under_linux(){
  # TODO: Create logic
}
under_osx(){
  # TODO: Create logic
}

install(){
  unamestr=$(uname)
  if [[ "$unamestr" == 'Darwin' ]]; then
    under_osx
  else
    under_linux
  fi
}

main(){
  # shellcheck source=bash/config.sh
  source "${ACTUAL}/bash/config.sh"
  install
}

main "$@"
