#!/bin/bash -x -e
pushd root
. ./setup.sh
popd

pushd bezel
. ./setup.sh
popd

pushd cleanpresenter
. ./setup.sh
popd

pushd recordkit
. ./setup.sh
popd

# pushd _template_app
# . ./setup.sh
# popd
