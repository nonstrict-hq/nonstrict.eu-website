#!/bin/bash -x
rm -rf recordkit-docs-electron.zip dist
gh release download -R nonstrict-hq/RecordKit.Internal -p "recordkit-docs-electron-*" -O ./recordkit-docs-electron.zip --clobber
unzip -o ./recordkit-docs-electron.zip -d ./dist
