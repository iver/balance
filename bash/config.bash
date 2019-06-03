#!/usr/bin/env bash

ACTUAL=$(pwd)

export ACTUAL
export NAME=balance
export PKGNAME=${NAME}.tar.gz
export PROJECT_PATH=${ACTUAL}/../
export PKG_FULLNAME=${PROJECT_PATH}/${PKGNAME}

