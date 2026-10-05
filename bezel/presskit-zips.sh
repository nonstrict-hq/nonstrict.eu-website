#!/bin/bash -e
KIT=Content/presskit
OUT=static/presskit
mkdir -p "$OUT" && rm -f "$OUT"/*.zip
TEXT=$(mktemp -d)
hugo --quiet --noBuildLock --config hugo.toml,presskit-md.toml -d "$TEXT"
for release in "$KIT"/*/index.md; do
  dir=$(dirname "$release")
  slug=$(basename "$dir")
  [ "$slug" = "assets" ] && continue
  STAGE=$(mktemp -d)
  root="$STAGE/bezel-press-kit-$slug"
  mkdir -p "$root"
  cp "$TEXT/presskit/presskit.md" "$root/Readme.txt"
  rsync -a --exclude='.*' --exclude='index.md' --exclude='og.*' --exclude='*/' "$dir/" "$root/press-release/"
  cp "$TEXT/presskit/$slug/presskit.md" "$root/press-release/press-release.md"
  printf 'Everything from the press release "%s": the text (press-release.md) and the images and video shown on the website.\n' "$(sed -n '1s/^# //p' "$root/press-release/press-release.md")" > "$root/press-release/Readme.txt"
  rsync -a --exclude='.*' --exclude='index.md' --prune-empty-dirs "$KIT/assets/" "$root/"
  (cd "$STAGE" && zip -qrX - "$(basename "$root")") > "$OUT/bezel-press-kit-$slug.zip"
  rm -rf "$STAGE"
done
rm -rf "$TEXT"
