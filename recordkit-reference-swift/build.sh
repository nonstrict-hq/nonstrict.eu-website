#!/bin/bash -x
rm -rf dist
gh release download -R nonstrict-hq/RecordKit -p "recordkit-docs-*" -O ./recordkit-docs.zip
unzip -o ./recordkit-docs.zip -d ./dist
