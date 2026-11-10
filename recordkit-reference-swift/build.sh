#!/bin/bash -x -e
rm -rf recordkit-docs-swift.zip dist
RELEASE=$(gh release view -R nonstrict-hq/RecordKit.Internal --json tagName,publishedAt \
    --jq '"\(.tagName) (published \(.publishedAt))"')
RELEASE_TAG="${RELEASE%% *}"
echo "Using RecordKit.Internal release $RELEASE for recordkit-docs-swift-*"
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
    echo "- RecordKit.Internal \`recordkit-docs-swift-*\`: $RELEASE" >> "$GITHUB_STEP_SUMMARY"
fi
gh release download "$RELEASE_TAG" -R nonstrict-hq/RecordKit.Internal -p "recordkit-docs-swift-*" -O ./recordkit-docs-swift.zip --clobber
unzip -o ./recordkit-docs-swift.zip -d ./dist
