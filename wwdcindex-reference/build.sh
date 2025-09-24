#!/bin/bash -x -e
rm -rf wwdcindex.zip dist

gh release download -R nonstrict-hq/WWDCIndex.Internal -p "wwdcindex-*" -O ./wwdcindex.zip --clobber

unzip -o ./wwdcindex.zip -d ./dist
rm wwdcindex.zip
