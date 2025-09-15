#!/bin/bash -x -e
rm -rf wwdcindex.zip dist

# Workaround GitHub release download outage
#gh release download -R nonstrict-hq/WWDCIndex.Internal -p "wwdcindex-*" -O ./wwdcindex.zip --clobber
curl -L -o ./wwdcindex.zip https://static.nonstrict.eu/wwdcindex-2.77.zip

unzip -o ./wwdcindex.zip -d ./dist
rm wwdcindex.zip
