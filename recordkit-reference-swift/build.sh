#!/bin/bash -x -e
rm -rf recordkit-docs-swift.zip dist
gh release download -R nonstrict-hq/RecordKit.Internal -p "recordkit-docs-swift-*" -O ./recordkit-docs-swift.zip --clobber
unzip -o ./recordkit-docs-swift.zip -d ./dist
