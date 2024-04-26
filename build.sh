#!/bin/bash -x -e
rm -rf dist

pushd root
. ./build.sh
mv Output ../dist
popd

pushd bezel
. ./build.sh
mv Output ../dist/bezel
popd

pushd cleanpresenter
. ./build.sh
mv Output ../dist/cleanpresenter
popd

pushd recordkit
. ./build.sh
mv .vitepress/dist ../dist/recordkit
popd

pushd recordkit-reference-swift
. ./build.sh
mkdir -p ../dist/recordkit/api
mv dist ../dist/recordkit/api/swift
popd

pushd recordkit-reference-electron
. ./build.sh
mkdir -p ../dist/recordkit/api
mv dist ../dist/recordkit/api/electron
popd

pushd wwdcindex
. ./build.sh
mv dist ../dist/wwdcindex
popd
