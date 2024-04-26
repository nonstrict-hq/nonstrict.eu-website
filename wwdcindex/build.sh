#!/bin/bash -x -e

releasename=WWDCIndex.Internal-$(gh release view --repo nonstrict-hq/WWDCIndex.Internal --json name --jq .name)
rm -rf dist
rm -rf $releasename
rm -rf $releasename.zip

gh release download --archive zip -R nonstrict-hq/WWDCIndex.Internal
unzip $releasename.zip
cd $releasename

swift run wwdcindex-generator --data-dir data --output ../dist

cd ..
rm -rf $releasename
rm -rf $releasename.zip
