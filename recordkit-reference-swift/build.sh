#!/bin/bash -x
rm -rf recordkit-docs.zip dist
gh release download -R nonstrict-hq/RecordKit -p "recordkit-docs-*" -O ./recordkit-docs.zip --clobber
unzip -o ./recordkit-docs.zip -d ./dist
