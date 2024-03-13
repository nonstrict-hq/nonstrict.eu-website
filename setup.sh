#!/bin/bash -x
pushd root
. ./setup.sh
popd

pushd bezel
. ./setup.sh
popd

pushd recordkit
. ./setup.sh
popd
