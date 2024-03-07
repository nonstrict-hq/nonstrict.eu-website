#!/bin/bash -x
rm -rf dist

pushd root
. ./build.sh
mv Output ../dist
popd

pushd recordkit
. ./build.sh
mv .vitepress/dist ../dist/recordkit
popd
