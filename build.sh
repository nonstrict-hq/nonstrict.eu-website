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

pushd wwdcindex-reference
. ./build.sh
mv dist ../dist/wwdcindex
popd

pushd keepgoing
. ./build.sh
mv out ../dist/keepgoing
popd

# pushd _template_app
# . ./build.sh
# mv out ../dist/_template_app
# popd

# Install the sitemap index
mv dist/sitemap.xml dist/sitemap-root.xml
cp sitemap-index.xml dist/sitemap.xml

# Install merchantid-domain-association for improved Paddle Apple Pay checkout
mkdir dist/.well-known
cp apple-developer-merchantid-domain-association.txt dist/.well-known/apple-developer-merchantid-domain-association.txt
