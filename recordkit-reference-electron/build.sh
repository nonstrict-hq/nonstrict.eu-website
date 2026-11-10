#!/bin/bash -x -e
rm -rf recordkit-docs-electron.zip dist
RELEASE=$(gh release view -R nonstrict-hq/RecordKit.Internal --json tagName,publishedAt \
    --jq '"\(.tagName) (published \(.publishedAt))"')
RELEASE_TAG="${RELEASE%% *}"
echo "Using RecordKit.Internal release $RELEASE for recordkit-docs-electron-*"
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    echo "- RecordKit.Internal \`recordkit-docs-electron-*\`: $RELEASE" >> "$GITHUB_STEP_SUMMARY"
fi
gh release download "$RELEASE_TAG" -R nonstrict-hq/RecordKit.Internal -p "recordkit-docs-electron-*" -O ./recordkit-docs-electron.zip --clobber
unzip -o ./recordkit-docs-electron.zip -d ./dist
