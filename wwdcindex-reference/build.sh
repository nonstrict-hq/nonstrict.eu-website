#!/bin/bash -x -e
rm -rf wwdcindex.zip dist

RELEASE=$(gh release view -R nonstrict-hq/WWDCIndex.Internal --json tagName,publishedAt \
    --jq '"\(.tagName) (published \(.publishedAt))"')
RELEASE_TAG="${RELEASE%% *}"
echo "Using WWDCIndex.Internal release $RELEASE for wwdcindex-*"
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    echo "- WWDCIndex.Internal \`wwdcindex-*\`: $RELEASE" >> "$GITHUB_STEP_SUMMARY"
fi
gh release download "$RELEASE_TAG" -R nonstrict-hq/WWDCIndex.Internal -p "wwdcindex-*" -O ./wwdcindex.zip --clobber

unzip -o ./wwdcindex.zip -d ./dist
rm wwdcindex.zip
