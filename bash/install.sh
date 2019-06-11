#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

under_linux(){
  apt-get update
  apt-get -y install postgresql-client
  wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \
    && sudo dpkg -i erlang-solutions_1.0_all.deb
  apt-get update
  apt-get install esl-erlang
  apt-get install elixir
}
under_osx(){
  brew update
  brew install elixir
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
