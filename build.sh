#!/bin/bash -x -e
rm -rf dist

pushd root
. ./build.sh
mv Output ../dist
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
