# Hugo Migration & Redesign Plan

## Overview

Migrate the Nonstrict company website from Swift Publish to Hugo while implementing the new homepage design. This plan prioritizes URL stability, RSS feed compatibility, and verifiable incremental progress.

**Key Principles:**
- All URLs must remain exactly the same (no redirects)
- RSS feed must be stable and backward compatible
- Blog posts stay in Markdown with minimal frontmatter changes
- Tailwind CSS styling preserved (especially for blog content)
- Design consistency across all pages
- Incremental verification at each phase

---

## Current Site Inventory

### URLs to Preserve (31 total)

```
/                                              # Homepage
/blog/                                         # Blog listing
/apps/                                         # Apps listing (currently empty)
/tags/                                         # Tag index
/tags/apps/
/tags/bezel/
/tags/bonnetjes/                               # App-specific tag
/tags/engineering/
/tags/persona-webcam/                          # App-specific tag
/tags/recordkit/
/tags/screen-studio/
/tags/talks/
/bonnetjes/                                    # App page
/persona-webcam/                               # App page (with meta refresh redirect)
/feed.rss                                      # RSS feed
/sitemap.xml                                   # Sitemap
/blog/2023/recording-to-disk-with-avcapturescreeninput/
/blog/2023/using-async-await-in-a-commandline-tool-on-older-macos-versions/
/blog/2023/recording-to-disk-with-screencapturekit/
/blog/2023/mentioning-scstreamerror-crashes-on-older-macos-versions/
/blog/2023/avassetwriter-crash-when-using-CMAF/
/blog/2023/a-look-at-screencapturekit-on-macos-sonoma/
/blog/2023/avassetwriter-leaks-segment-data/
/blog/2023/working-with-c-callback-functions-in-swift/
/blog/2023/display-reconfigurations-on-macos/
/blog/2023/a-mac-tastic-indie-adventure/
/blog/2023/launching-bezel/
/blog/2023/stretching-an-audio-file-using-swift/
/blog/2023/working-with-custom-metadata-in-mp4-files/
/blog/2023/incorrect-output-when-writing-a-single-AVTimedMetadataGroup/
/blog/2023/darwin-notifications-app-extensions/
/blog/2023/transferable-drag-drop-fails-with-only-FileRepresentation/
/blog/2024/launching-bezel-for-vision/
/blog/2024/request-and-check-for-local-network-permission/
/blog/2024/hkworkoutsession-remote-delegate-not-setup-error/
/blog/2024/handling-audio-capture-gaps-on-macos/
/blog/2024/stretching-audio-by-small-amounts-using-swift/
/blog/2025/distorted-audio-avcapturesession/
/blog/2025/studio-display-camera-fails/
/blog/2025/launching-bezel-3.0/
/blog/2025/creating-equatable-tuples-swift-parameter-packs/
```

### RSS Feed Requirements

Current feed structure that must be preserved:
- Location: `/feed.rss`
- Channel title: "Nonstrict"
- Channel description: "Experts on Apple platforms."
- TTL: 250 minutes
- Per-item: guid, title, description, link, pubDate, content:encoded
- Namespaces: atom, content

### Meta Tags Requirements

Every page needs:
- `og:site_name` = "Nonstrict"
- `og:url`, `og:title`, `og:description`, `og:image`
- `twitter:card` (summary or summary_large_image based on image presence)
- `twitter:url`, `twitter:title`, `twitter:description`, `twitter:image`
- `<meta name="description">`
- `<link rel="canonical">`
- Plausible analytics script with custom domain

### Author System

| Author | Gravatar Hash |
|--------|---------------|
| Mathijs Kadijk | `f2d6bffca5e5fe828bc9c55a521a55ec` |
| Tom Lokhorst | `38b1c93cab46acd801e6e0cc99c39939` |

---

## Migration Strategy: Scaffold First

We'll use a **scaffold-first approach**:
1. Set up Hugo with minimal templates
2. Verify all URLs work with placeholder content
3. Migrate actual content
4. Implement new design
5. Polish and verify

This ensures URL stability before investing in design work.

---

## Phase 1: Hugo Project Setup

**Goal:** Working Hugo site with correct configuration

### 1.1 Create Hugo Structure

```
root/
├── hugo.toml              # Main config
├── content/
│   ├── _index.md          # Homepage
│   ├── blog/
│   │   └── _index.md      # Blog listing
│   └── apps/
│       └── _index.md      # Apps listing
├── layouts/
│   ├── _default/
│   │   ├── baseof.html
│   │   ├── list.html
│   │   └── single.html
│   ├── partials/
│   │   ├── head.html
│   │   ├── header.html
│   │   └── footer.html
│   └── index.html
├── static/
│   └── images/
├── assets/
│   └── css/
│       └── input.css
├── data/
│   └── authors.yaml
├── build.sh
├── serve.sh
└── setup.sh
```

### 1.2 Hugo Configuration (hugo.toml)

```toml
baseURL = "https://nonstrict.eu/"
languageCode = "en-us"
title = "Nonstrict"
description = "Experts on Apple platforms."

# Preserve trailing slashes like current site
uglyURLs = false
disablePathToLower = true

# Output formats
[outputs]
  home = ["HTML", "RSS"]
  section = ["HTML", "RSS"]
  taxonomy = ["HTML"]
  term = ["HTML"]

# RSS configuration - CRITICAL: need both baseName AND suffix
[outputFormats]
  [outputFormats.RSS]
    mediaType = "application/rss+xml"
    baseName = "feed"
    suffix = "rss"            # Without this, Hugo creates feed.xml not feed.rss

# Permalinks - CRITICAL for URL preservation
[permalinks]
  blog = "/blog/:year/:slug/"

# Taxonomies
[taxonomies]
  tag = "tags"

# Markup configuration
[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true           # Allow HTML in markdown
  [markup.highlight]
    style = "github"
    lineNos = false
    tabWidth = 4
    noClasses = false         # Use CSS classes for syntax highlighting

# Sitemap
# Note: The parent build script handles sitemap index creation:
# 1. Hugo generates sitemap.xml
# 2. Parent script renames it to sitemap-root.xml
# 3. Parent script installs sitemap-index.xml as the main sitemap.xml
# So we just generate a normal sitemap.xml here.
[sitemap]
  changefreq = "monthly"
  filename = "sitemap.xml"
  priority = 0.5

# Custom params
[params]
  ogImage = "/images/og-logo.png"
  favicon = "/images/favicon.png"

  # Plausible Analytics
  [params.plausible]
    domain = "nonstrict.eu"
    scriptURL = "https://web.nonstrictmetrics.com/js/script.js"
    apiURL = "https://web.nonstrictmetrics.com/api/event"
```

### 1.3 Build Scripts

**setup.sh:**
```bash
#!/bin/bash -e
# Download Tailwind CSS binary
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.17/tailwindcss-macos-arm64
    mv tailwindcss-macos-arm64 tailwindcss
else
    curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/download/v3.4.17/tailwindcss-macos-x64
    mv tailwindcss-macos-x64 tailwindcss
fi
chmod +x tailwindcss
```

**build.sh:**
```bash
#!/bin/bash -e
hugo --minify --destination Output
./tailwindcss -i assets/css/input.css -o Output/styles.css --minify
```

**serve.sh:**
```bash
#!/bin/bash
cleanup() {
    echo "Stopping..."
    kill $HUGO_PID $TW_PID 2>/dev/null
}
trap cleanup INT TERM

hugo server --buildDrafts --destination Output --port 8000 &
HUGO_PID=$!

./tailwindcss -i assets/css/input.css -o Output/styles.css --watch &
TW_PID=$!

wait $HUGO_PID $TW_PID
```

### 1.4 Verification Checklist

- [ ] `hugo version` works
- [ ] `./setup.sh` downloads Tailwind
- [ ] `./serve.sh` starts server on port 8000
- [ ] Site accessible at http://localhost:8000

---

## Phase 2: URL Scaffold

**Goal:** All URLs return 200 with placeholder content

### 2.1 Create Placeholder Content

Create minimal markdown files that produce correct URLs:

**content/_index.md:**
```yaml
---
title: "Nonstrict"
description: "Experts on Apple platforms."
---
Homepage placeholder
```

**content/blog/_index.md:**
```yaml
---
title: "Blog"
description: "Opinions, learnings and thoughts on apps, business and tech."
---
```

**content/apps/_index.md:**
```yaml
---
title: "Apps"
description: "Apps by Nonstrict"
---
```

**content/bonnetjes.md:**
```yaml
---
title: "Receipt Scanner for Moneybird"
description: "Scan receipts with your iPhone."
url: /bonnetjes/
---
Placeholder
```

**content/persona-webcam.md:**
```yaml
---
title: "Persona Webcam"
description: "Virtual camera utility"
url: /persona-webcam/
---
Placeholder
```

### 2.2 Create Blog Post Scaffolds

For each blog post, create a file with correct slug and date:

**content/blog/recording-to-disk-with-avcapturescreeninput.md:**
```yaml
---
title: "Recording to disk using AVCaptureScreenInput"
date: 2023-01-29T12:00:00+01:00
slug: "recording-to-disk-with-avcapturescreeninput"
tags: ["Engineering"]
draft: false
---
Placeholder - content to be migrated
```

### 2.3 Create Minimal Templates

**layouts/_default/baseof.html:**
```html
<!DOCTYPE html>
<html lang="{{ .Site.LanguageCode }}">
<head>
    {{- partial "head.html" . -}}
</head>
<body>
    {{- partial "header.html" . -}}
    <main>
        {{- block "main" . }}{{- end }}
    </main>
    {{- partial "footer.html" . -}}
</body>
</html>
```

**layouts/partials/head.html:**
```html
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{{ if .IsHome }}{{ .Site.Title }}{{ else }}{{ .Title }} | {{ .Site.Title }}{{ end }}</title>

<!-- Description -->
<meta name="description" content="{{ with .Description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">

<!-- Canonical -->
<link rel="canonical" href="{{ .Permalink }}">

<!-- Open Graph -->
<meta property="og:site_name" content="{{ .Site.Title }}">
<meta property="og:url" content="{{ .Permalink }}">
<meta property="og:title" content="{{ .Title }}">
<meta property="og:description" content="{{ with .Description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
{{ with .Params.image }}
<meta property="og:image" content="{{ . | absURL }}">
{{ else }}
<meta property="og:image" content="{{ .Site.Params.ogImage | absURL }}">
{{ end }}

<!-- Twitter Card -->
<meta name="twitter:card" content="{{ if .Params.image }}summary_large_image{{ else }}summary{{ end }}">
<meta name="twitter:url" content="{{ .Permalink }}">
<meta name="twitter:title" content="{{ .Title }}">
<meta name="twitter:description" content="{{ with .Description }}{{ . }}{{ else }}{{ .Site.Params.description }}{{ end }}">
{{ with .Params.image }}
<meta name="twitter:image" content="{{ . | absURL }}">
{{ else }}
<meta name="twitter:image" content="{{ .Site.Params.ogImage | absURL }}">
{{ end }}

<!-- Favicon -->
<link rel="shortcut icon" href="{{ .Site.Params.favicon }}" type="image/png">

<!-- RSS -->
<link rel="alternate" href="/feed.rss" type="application/rss+xml" title="Subscribe to {{ .Site.Title }}">

<!-- Styles -->
<link rel="stylesheet" href="/styles.css" type="text/css">

<!-- Plausible Analytics -->
<script defer
    src="{{ .Site.Params.plausible.scriptURL }}"
    data-domain="{{ .Site.Params.plausible.domain }}"
    data-api="{{ .Site.Params.plausible.apiURL }}"
    add-file-type="dmg"></script>
```

### 2.4 URL Verification Script

Create a script to verify all URLs match:

**verify-urls.sh:**
```bash
#!/bin/bash
echo "Building site..."
hugo --destination Output

echo "Generating URL list from Hugo..."
find Output -name "*.html" -o -name "*.rss" -o -name "*.xml" | \
    sed 's|Output||g' | \
    sed 's|/index.html||g' | \
    sed 's|^$|/|g' | \
    sort > hugo-urls.txt

echo "Expected URLs:"
cat << 'EOF' > expected-urls.txt
/
/apps
/blog
/blog/2023/a-look-at-screencapturekit-on-macos-sonoma
/blog/2023/a-mac-tastic-indie-adventure
/blog/2023/avassetwriter-crash-when-using-CMAF
/blog/2023/avassetwriter-leaks-segment-data
/blog/2023/darwin-notifications-app-extensions
/blog/2023/display-reconfigurations-on-macos
/blog/2023/incorrect-output-when-writing-a-single-AVTimedMetadataGroup
/blog/2023/launching-bezel
/blog/2023/mentioning-scstreamerror-crashes-on-older-macos-versions
/blog/2023/recording-to-disk-with-avcapturescreeninput
/blog/2023/recording-to-disk-with-screencapturekit
/blog/2023/stretching-an-audio-file-using-swift
/blog/2023/transferable-drag-drop-fails-with-only-FileRepresentation
/blog/2023/using-async-await-in-a-commandline-tool-on-older-macos-versions
/blog/2023/working-with-c-callback-functions-in-swift
/blog/2023/working-with-custom-metadata-in-mp4-files
/blog/2024/handling-audio-capture-gaps-on-macos
/blog/2024/hkworkoutsession-remote-delegate-not-setup-error
/blog/2024/launching-bezel-for-vision
/blog/2024/request-and-check-for-local-network-permission
/blog/2024/stretching-audio-by-small-amounts-using-swift
/blog/2025/creating-equatable-tuples-swift-parameter-packs
/blog/2025/distorted-audio-avcapturesession
/blog/2025/launching-bezel-3.0
/blog/2025/studio-display-camera-fails
/bonnetjes
/feed.rss
/persona-webcam
/sitemap.xml
/tags
/tags/apps
/tags/bezel
/tags/bonnetjes
/tags/engineering
/tags/persona-webcam
/tags/recordkit
/tags/screen-studio
/tags/talks
EOF

echo "Comparing URLs..."
diff expected-urls.txt hugo-urls.txt

if [ $? -eq 0 ]; then
    echo "✅ All URLs match!"
else
    echo "❌ URL mismatch detected"
    exit 1
fi
```

### 2.5 Verification Checklist

- [ ] All 28 page URLs return 200
- [ ] `/feed.rss` exists and is valid XML
- [ ] `/sitemap.xml` exists and is valid XML
- [ ] All 6 tag URLs work
- [ ] `verify-urls.sh` passes

---

## Phase 3: Content Migration

**Goal:** All blog posts and pages migrated with correct frontmatter

### 3.1 Frontmatter Conversion

**Current Publish format:**
```yaml
---
date: 2025-06-04 12:00
authors: mathijs, tom
tags: Apps, Bezel
title: Launching Bezel 3.0
description: Today we're launching Bezel 3.0!
path: 2025/launching-bezel-3.0
image: images/blog/2025-06-bezel-3-personalize.jpg
featured: true
hideImageHero: false
---
```

**Target Hugo format:**
```yaml
---
title: "Launching Bezel 3.0"
date: 2025-06-04T12:00:00+01:00
description: "Today we're launching Bezel 3.0!"
slug: "launching-bezel-3.0"
authors: ["mathijs", "tom"]
tags: ["Apps", "Bezel"]
image: "images/blog/2025-06-bezel-3-personalize.jpg"
featured: true
hideImageHero: false
draft: false
---
```

**Key changes:**
- `date`: Add timezone and seconds (`T12:00:00+01:00`)
- `authors`: Convert comma-string to array
- `tags`: Convert comma-string to array
- `path`: Convert to `slug` (just the slug part, year comes from date)
- Add `draft: false`
- Quote all string values

### 3.2 Migration Script

The frontmatter conversion requires careful handling of:
- `authors: tom, mathijs` → `authors: ["tom", "mathijs"]`
- `tags: Apps, Bezel` → `tags: ["Apps", "Bezel"]`
- `date: 2023-01-29 12:00` → `date: 2023-01-29T12:00:00+01:00`
- `path: 2023/slug-name` → `slug: "slug-name"` (year comes from date)

**migrate-content.py:** (Python for robust YAML handling)
```python
#!/usr/bin/env python3
import os
import re
import yaml
from pathlib import Path

SOURCE_DIR = Path("Content/blog")
DEST_DIR = Path("content/blog")

DEST_DIR.mkdir(parents=True, exist_ok=True)

for md_file in SOURCE_DIR.glob("*.md"):
    print(f"Migrating: {md_file.name}")

    content = md_file.read_text()

    # Split frontmatter and body
    parts = content.split("---", 2)
    if len(parts) < 3:
        print(f"  Warning: No frontmatter found, copying as-is")
        (DEST_DIR / md_file.name).write_text(content)
        continue

    frontmatter = yaml.safe_load(parts[1])
    body = parts[2]

    # Convert authors string to array
    if "authors" in frontmatter and isinstance(frontmatter["authors"], str):
        frontmatter["authors"] = [a.strip() for a in frontmatter["authors"].split(",")]

    # Convert tags string to array
    if "tags" in frontmatter and isinstance(frontmatter["tags"], str):
        frontmatter["tags"] = [t.strip() for t in frontmatter["tags"].split(",")]

    # Convert date format (add timezone)
    if "date" in frontmatter:
        date_str = str(frontmatter["date"])
        if "T" not in date_str:
            # Format: "2023-01-29 12:00" → "2023-01-29T12:00:00+01:00"
            frontmatter["date"] = date_str.replace(" ", "T") + ":00+01:00"

    # Convert path to slug
    if "path" in frontmatter:
        path = frontmatter.pop("path")
        # Extract slug from "2023/slug-name"
        slug = path.split("/")[-1] if "/" in path else path
        frontmatter["slug"] = slug

    # Add draft: false
    frontmatter["draft"] = False

    # Write converted file
    new_content = "---\n" + yaml.dump(frontmatter, default_flow_style=False, allow_unicode=True) + "---" + body
    (DEST_DIR / md_file.name).write_text(new_content)

print("Migration complete. Review converted files.")
```

**Alternative:** Use `yq` for simpler transformations if preferred.

### 3.3 Author Data File

**data/authors.yaml:**
```yaml
mathijs:
  name: "Mathijs Kadijk"
  gravatar: "f2d6bffca5e5fe828bc9c55a521a55ec"

tom:
  name: "Tom Lokhorst"
  gravatar: "38b1c93cab46acd801e6e0cc99c39939"
```

### 3.4 Copy Static Assets

```bash
# Copy all images
cp -r Resources/images/* static/images/

# Verify no broken image references
grep -r "images/" content/ | grep -v "^Binary"
```

### 3.5 Verification Checklist

- [ ] All 25 blog posts migrated
- [ ] Frontmatter converts correctly
- [ ] All images copied to static/
- [ ] Image references in markdown still work
- [ ] bonnetjes.md migrated with appLink
- [ ] persona-webcam.md migrated with redirect

---

## Phase 4: RSS Feed Implementation

**Goal:** RSS feed matches current format exactly

### 4.1 Custom RSS Template

**layouts/_default/rss.xml:**
```xml
{{- $pctx := . -}}
{{- if .IsHome -}}{{ $pctx = .Site }}{{- end -}}
{{- $pages := slice -}}
{{- if or $.IsHome $.IsSection -}}
{{- $pages = $pctx.RegularPages -}}
{{- else -}}
{{- $pages = $pctx.Pages -}}
{{- end -}}
{{- $limit := .Site.Config.Services.RSS.Limit -}}
{{- if ge $limit 1 -}}
{{- $pages = $pages | first $limit -}}
{{- end -}}
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:content="http://purl.org/rss/1.0/modules/content/">
  <channel>
    <title>{{ .Site.Title }}</title>
    <link>{{ .Site.BaseURL }}</link>
    <description>{{ .Site.Params.description }}</description>
    <language>{{ .Site.LanguageCode }}</language>
    <lastBuildDate>{{ now.Format "Mon, 02 Jan 2006 15:04:05 -0700" }}</lastBuildDate>
    {{ with .Site.Author.email }}<managingEditor>{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}</managingEditor>{{ end }}
    {{ with .Site.Author.email }}<webMaster>{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}</webMaster>{{ end }}
    <ttl>250</ttl>
    <atom:link href="{{ "feed.rss" | absURL }}" rel="self" type="application/rss+xml"/>
    {{- range $pages }}
    <item>
      <title>{{ .Title }}</title>
      <link>{{ .Permalink }}</link>
      <pubDate>{{ .Date.Format "Mon, 02 Jan 2006 15:04:05 -0700" }}</pubDate>
      <guid isPermaLink="true">{{ .Permalink }}</guid>
      <description>{{ .Description }}</description>
      <content:encoded><![CDATA[{{ .Content }}]]></content:encoded>
    </item>
    {{- end }}
  </channel>
</rss>
```

### 4.2 Verification

- [ ] Feed accessible at `/feed.rss`
- [ ] TTL is 250
- [ ] Contains atom:link self-reference
- [ ] Contains content:encoded with full HTML
- [ ] Valid RSS (use feed validator)
- [ ] Compare with current feed structure

---

## Phase 5: Syntax Highlighting

**Goal:** Code blocks render with same styling as current site

### 5.1 Understanding the Change

**Current setup (Publish + Splash):**
- Blog posts contain standard markdown code blocks: ` ```swift ... ``` `
- Splash plugin renders them at build time, adding `splash-*` classes
- CSS targets `.splash-keyword`, `.splash-type`, etc.

**Hugo setup (Chroma):**
- Hugo uses Chroma (not Splash) to highlight code blocks at build time
- Chroma uses different CSS class names
- We update CSS to target Chroma's classes with the same colors

**This is safe because:** The markdown source files contain standard code fences, NOT pre-rendered HTML. Hugo will re-render them with Chroma.

### 5.2 Class Name Mapping

| Splash (current) | Chroma (Hugo) | Tailwind Color |
|------------------|---------------|----------------|
| `.splash-keyword` | `.k`, `.kd`, `.kn`, `.kc` | text-rose-500 font-bold |
| `.splash-type` | `.kt`, `.nc`, `.no` | text-purple-400 |
| `.splash-call` | `.nf`, `.fm` | text-cyan-500 |
| `.splash-property` | `.n`, `.na`, `.ni` | text-emerald-500 |
| `.splash-number` | `.mi`, `.mf`, `.mh`, `.mo` | text-amber-500 |
| `.splash-string` | `.s`, `.s1`, `.s2`, `.sa`, `.sb` | text-orange-500 |
| `.splash-comment` | `.c`, `.c1`, `.cm`, `.cs` | text-neutral-400 |
| `.splash-dotAccess` | `.o`, `.p` | text-emerald-500 |
| `.splash-preprocessing` | `.cp`, `.cpf` | text-yellow-600 |

### 5.3 Tailwind CSS Configuration

**assets/css/input.css:**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer components {
    pre code {
        overflow-x: auto;
        white-space: pre;
        -webkit-overflow-scrolling: touch;
    }

    /* Chroma syntax highlighting - matching current Splash colors */
    .highlight .k,
    .highlight .kd,
    .highlight .kn,
    .highlight .kc { @apply text-rose-500 font-bold }    /* keywords */

    .highlight .kt,
    .highlight .nc,
    .highlight .no { @apply text-purple-400 }             /* types */

    .highlight .nf,
    .highlight .fm { @apply text-cyan-500 }               /* function names */

    .highlight .n,
    .highlight .na,
    .highlight .ni { @apply text-emerald-500 }            /* names/properties */

    .highlight .s,
    .highlight .s1,
    .highlight .s2,
    .highlight .sa,
    .highlight .sb { @apply text-orange-500 }             /* strings */

    .highlight .mi,
    .highlight .mf,
    .highlight .mh,
    .highlight .mo { @apply text-amber-500 }              /* numbers */

    .highlight .c,
    .highlight .c1,
    .highlight .cm,
    .highlight .cs { @apply text-neutral-400 }            /* comments */

    .highlight .o,
    .highlight .p { @apply text-emerald-500 }             /* operators/punctuation */

    .highlight .cp,
    .highlight .cpf { @apply text-yellow-600 }            /* preprocessor */
}
```

### 5.3 Verification

- [ ] Swift code blocks render correctly
- [ ] Colors match current site
- [ ] Horizontal scroll works on overflow
- [ ] Test multiple code samples

---

## Phase 6: Blog Templates

**Goal:** Blog listing and posts match current functionality

### 6.1 Blog List Template

**layouts/blog/list.html:**
```html
{{ define "main" }}
<div class="relative bg-gray-50 px-6 pt-16 pb-20 lg:px-8 lg:pb-28">
    <div class="relative mx-auto max-w-7xl">
        <div class="text-center">
            <h1 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">Blog</h1>
            <p class="mx-auto mt-3 max-w-2xl text-xl text-gray-500 sm:mt-4">
                Opinions, learnings and thoughts on apps, business and tech.
            </p>
        </div>
        <div class="mx-auto mt-12 grid max-w-lg gap-5 lg:max-w-none lg:grid-cols-3">
            {{ range .Pages.ByDate.Reverse }}
            {{ partial "blog-card.html" . }}
            {{ end }}
        </div>
    </div>
</div>
{{ end }}
```

### 6.2 Blog Card Partial

**Note on image paths:** Frontmatter uses paths like `images/blog/photo.jpg` (no leading slash). The template adds the leading slash. Normalize to avoid double slashes:

**layouts/partials/blog-card.html:**
```html
<div class="flex flex-col overflow-hidden rounded-lg shadow-lg">
    {{ with .Params.image }}
    <div class="flex-shrink-0">
        <a href="{{ $.Permalink }}">
            {{/* Normalize image path - add leading slash only if missing */}}
            {{ $imgPath := . }}
            {{ if not (hasPrefix . "/") }}{{ $imgPath = printf "/%s" . }}{{ end }}
            <img src="{{ $imgPath }}" class="h-48 w-full object-cover"/>
        </a>
    </div>
    {{ end }}
    <div class="flex flex-1 flex-col justify-between bg-white p-6">
        <div class="flex-1">
            {{ with index .Params.tags 0 }}
            <p class="text-sm font-medium text-orange">{{ . }}</p>
            {{ end }}
            <a href="{{ .Permalink }}" class="mt-2 block group">
                <p class="text-xl font-semibold text-gray-900 group-hover:underline">{{ .Title }}</p>
                <p class="mt-3 text-base text-gray-500">{{ .Description }}</p>
            </a>
        </div>
        <div class="mt-6 flex items-center">
            {{ partial "author-avatars.html" . }}
            <div class="ml-3">
                <p class="text-sm font-medium text-gray-900">
                    {{ partial "author-names.html" . }}
                </p>
                <div class="flex space-x-1 text-sm text-gray-500">
                    <time datetime="{{ .Date.Format "2006-01-02" }}">{{ .Date.Format "January 2" }}</time>
                    <span aria-hidden="true">&middot;</span>
                    <span>{{ math.Max 1 .ReadingTime }} min read</span>
                </div>
            </div>
        </div>
    </div>
</div>
```

### 6.3 Author Partials

**layouts/partials/author-avatars.html:**
```html
<div class="flex-shrink-0 flex -space-x-2">
    {{ range .Params.authors }}
    {{ $author := index $.Site.Data.authors . }}
    <img src="https://www.gravatar.com/avatar/{{ $author.gravatar }}?s=256"
         alt="{{ $author.name }}"
         class="h-10 w-10 rounded-full ring-2 ring-white"/>
    {{ end }}
</div>
```

**layouts/partials/author-names.html:**
```html
{{ $names := slice }}
{{ range .Params.authors }}
{{ $author := index $.Site.Data.authors . }}
{{ $names = $names | append $author.name }}
{{ end }}
{{ delimit $names ", " }}
```

### 6.4 Single Blog Post Template

**layouts/blog/single.html:**
```html
{{ define "main" }}
<article class="prose prose-lg mx-auto px-6 py-16">
    <header class="mb-8">
        {{ if not .Params.hideImageHero }}
        {{ with .Params.image }}
        <img src="/{{ . }}" alt="{{ $.Params.imageAlt }}" class="w-full rounded-lg mb-8"/>
        {{ with $.Params.imageCaption }}
        <p class="text-sm text-gray-500 text-center -mt-6 mb-8">{{ . }}</p>
        {{ end }}
        {{ end }}
        {{ end }}

        <h1>{{ .Title }}</h1>

        <div class="flex items-center mt-4 not-prose">
            {{ partial "author-avatars.html" . }}
            <div class="ml-3">
                <p class="text-sm font-medium text-gray-900">
                    {{ partial "author-names.html" . }}
                </p>
                <div class="flex space-x-1 text-sm text-gray-500">
                    <time datetime="{{ .Date.Format "2006-01-02" }}">{{ .Date.Format "January 2, 2006" }}</time>
                    <span aria-hidden="true">&middot;</span>
                    <span>{{ math.Max 1 .ReadingTime }} min read</span>
                </div>
            </div>
        </div>
    </header>

    {{ .Content }}
</article>
{{ end }}
```

### 6.5 Verification Checklist

- [ ] Blog listing shows all posts
- [ ] Posts sorted by date (newest first)
- [ ] Author avatars display correctly
- [ ] Reading time shows (minimum 1 min)
- [ ] Tags display on cards
- [ ] Individual posts render with prose styling
- [ ] Featured images work
- [ ] hideImageHero respected

---

## Phase 7: Homepage Redesign

**Goal:** Implement new design from concept document

### 7.1 Homepage Structure

**layouts/index.html:**
```html
{{ define "main" }}
    {{ partial "hero.html" . }}
    {{ partial "featured-products.html" . }}
    {{ partial "app-grid.html" . }}
    {{ partial "blog-section.html" . }}
{{ end }}
```

### 7.2 Hero Section

Reference: `.claude/homepage-redesign-concept.md`

**layouts/partials/hero.html:**
```html
<div class="relative isolate overflow-x-clip bg-white">
    <!-- Orange gradient background -->
    <div class="absolute inset-x-0 top-[-10rem] -z-10 transform-gpu blur-3xl sm:top-[-20rem]">
        <!-- SVG gradient blob -->
    </div>

    <div class="mx-auto max-w-7xl px-6 pt-10 pb-24 sm:pb-32 lg:py-40 lg:px-8">
        <div class="mx-auto max-w-2xl text-center">
            <img class="h-16 mx-auto rounded-sm" src="/images/logomark-background.svg" alt="Nonstrict">

            <h1 class="mt-10 text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">
                We are Nonstrict
            </h1>

            <p class="mt-6 text-lg leading-8 text-gray-600">
                Two developers building native apps and SDKs for Apple platforms.
                We make Bezel, RecordKit, and more.
            </p>
        </div>
    </div>
</div>
```

### 7.3 Featured Products

**layouts/partials/featured-products.html:**
- Two equal cards for Bezel and RecordKit
- Icon, name, description, "Learn more →" link
- Soft shadows, 12px border radius
- Hover lift effect

### 7.4 App Grid

**data/apps.yaml:**
```yaml
- name: "Splitscreen"
  icon: "splitscreen.png"
  url: "https://apps.apple.com/app/..."

- name: "CleanPresenter"
  icon: "cleanpresenter.png"
  url: "https://apps.apple.com/app/..."

- name: "Persona Webcam"
  icon: "persona-webcam.png"
  url: "/persona-webcam/"

# ... etc
```

**layouts/partials/app-grid.html:**
- 6 columns desktop, 3 tablet, 2 mobile
- Icon + name for each app
- Hover lift effect

### 7.5 Blog Section

**layouts/partials/blog-section.html:**
```html
<div class="relative bg-gray-50 px-6 pt-16 pb-20 lg:px-8 lg:pb-28">
    <div class="relative mx-auto max-w-7xl">
        <div class="text-center">
            <h2 class="text-3xl font-bold tracking-tight text-gray-900 sm:text-4xl">
                From our engineering blog
            </h2>
            <p class="mx-auto mt-3 max-w-2xl text-xl text-gray-500 sm:mt-4">
                Deep dives into Apple platform development.
            </p>
        </div>
        <div class="mx-auto mt-12 grid max-w-lg gap-5 lg:max-w-none lg:grid-cols-3">
            {{/* Query featured posts, sorted by date, take first 3 */}}
            {{ $featured := where .Site.RegularPages ".Params.featured" true }}
            {{ $recent := $featured.ByDate.Reverse | first 3 }}
            {{ range $recent }}
                {{ partial "blog-card.html" . }}
            {{ end }}
        </div>
        <div class="text-center mt-8">
            <a href="/blog/" class="text-orange hover:underline font-medium">
                All posts →
            </a>
        </div>
    </div>
</div>
```

Key: Uses `where .Site.RegularPages ".Params.featured" true` to filter featured posts.

### 7.6 Verification Checklist

- [ ] Hero displays correctly
- [ ] Featured products cards work
- [ ] App grid shows all apps
- [ ] Blog section shows 3 latest
- [ ] Responsive on mobile/tablet
- [ ] Hover effects work

---

## Phase 8: Header & Footer

**Goal:** Consistent navigation across all pages

### 8.1 Header

**layouts/partials/header.html:**
```html
<header class="bg-white">
    <div class="mx-auto max-w-7xl px-6">
        <div class="flex items-center justify-between py-6">
            <a href="/">
                <img class="h-10 w-auto" src="/images/logomark-background.svg" alt="Nonstrict">
            </a>

            <nav class="flex space-x-10">
                <a href="/blog/" class="text-base font-medium text-gray-500 hover:text-gray-900">Blog</a>
                <a href="mailto:hello@nonstrict.com" class="text-base font-medium text-gray-500 hover:text-gray-900">Contact</a>
            </nav>
        </div>
    </div>
</header>
```

### 8.2 Footer

**layouts/partials/footer.html:**
```html
<footer class="bg-white">
    <div class="mx-auto max-w-7xl py-12 px-6 md:flex md:items-center md:justify-between lg:px-8">
        <div class="flex justify-center space-x-6 md:order-2">
            <!-- Social icons: Email, GitHub, Mastodon, Twitter, LinkedIn -->
        </div>
        <div class="mt-8 md:order-1 md:mt-0">
            <p class="text-center text-sm text-gray-500">
                Working on something interesting?
                <a href="mailto:hello@nonstrict.com" class="text-orange hover:underline">hello@nonstrict.com</a>
            </p>
            <p class="text-center text-xs leading-5 text-gray-500 mt-2">
                © 2023-{{ now.Year }} Nonstrict B.V. — Amersfoort, The Netherlands — KVK 89067657
            </p>
        </div>
    </div>
</footer>
```

### 8.3 Verification

- [ ] Header appears on all pages
- [ ] Footer appears on all pages
- [ ] Navigation links work
- [ ] Social links work
- [ ] Contact email correct
- [ ] "Join Forces" removed everywhere

---

## Phase 9: Special Pages

### 9.1 Bonnetjes Page

Keep as app page with custom layout.

### 9.2 Persona Webcam Page

The current persona-webcam page uses an inline `<meta http-equiv="refresh">` tag in the markdown content itself. Since Hugo is configured with `unsafe = true` for goldmark rendering, this HTML passes through directly.

**No special template needed.** Just migrate the markdown file as-is:

**content/persona-webcam.md:**
```yaml
---
title: "Persona Webcam"
description: "Virtual camera utility"
url: /persona-webcam/
authors: ["tom", "mathijs"]
tags: ["Apps", "Persona Webcam"]
image: "images/apps/app-icon-persona-webcam.png"
---
<meta http-equiv="refresh" content="0; url=https://apps.apple.com/us/app/id6498891868" />
```

The `unsafe = true` setting in hugo.toml allows this HTML to render, creating the redirect behavior.

### 9.3 Tags Pages

Create proper tag listing template instead of "TODO".

**layouts/_default/taxonomy.html** and **layouts/_default/term.html**:
- List all posts with that tag
- Use same card layout as blog listing

### 9.4 Apps Page

Keep `/apps/` page but show message directing to homepage, or implement a simple listing.

### 9.5 404 Page

**layouts/404.html:**
```html
{{ define "main" }}
<div class="mx-auto max-w-7xl px-6 py-24 text-center">
    <h1 class="text-4xl font-bold text-gray-900">Page not found</h1>
    <p class="mt-4 text-lg text-gray-600">
        Sorry, we couldn't find the page you're looking for.
    </p>
    <a href="/" class="mt-8 inline-block text-orange hover:underline">
        ← Back to homepage
    </a>
</div>
{{ end }}
```

### 9.6 robots.txt

**static/robots.txt:**
```
User-agent: *
Allow: /

Sitemap: https://nonstrict.eu/sitemap.xml
```

---

## Phase 10: Final Verification

### 10.1 URL Verification

```bash
./verify-urls.sh
```

### 10.2 Content Verification

- [ ] All 25 blog posts render correctly
- [ ] All images display
- [ ] All code blocks highlighted
- [ ] All links work

### 10.3 RSS Verification

```bash
# Download and compare
curl -s https://nonstrict.eu/feed.rss > old-feed.rss
curl -s http://localhost:8000/feed.rss > new-feed.rss
# Manual comparison of structure
```

### 10.4 Meta Tags Verification

Check each page type:
- [ ] Homepage has correct og:image
- [ ] Blog posts have article og:image
- [ ] Twitter cards work
- [ ] Descriptions populated

### 10.5 Design Verification

- [ ] Homepage matches concept
- [ ] Responsive on mobile
- [ ] Consistent header/footer
- [ ] No visual regressions on blog

### 10.6 Performance

- [ ] Build time < 1 second
- [ ] Page load fast
- [ ] No console errors

---

## Rollback Plan

If issues discovered after deployment:

1. Keep old Publish site in separate branch
2. Deployment can switch back by pointing to old Output/
3. No URL changes means no redirect cleanup needed

---

## Timeline Estimate

| Phase | Duration | Dependencies |
|-------|----------|--------------|
| 1. Hugo Setup | 1.5 hours | None |
| 2. URL Scaffold | 2.5 hours | Phase 1 |
| 3. Content Migration | 4 hours | Phase 2 |
| 4. RSS Feed | 1.5 hours | Phase 3 |
| 5. Syntax Highlighting | 1 hour | Phase 3 |
| 6. Blog Templates | 3 hours | Phases 4, 5 |
| 7. Homepage Redesign | 5 hours | Phase 6 |
| 8. Header & Footer | 1.5 hours | Phase 7 |
| 9. Special Pages | 2 hours | Phase 8 |
| 10. Final Verification | 3 hours | Phase 9 |

**Total: ~25 hours** (3-4 days)

*Timeline includes buffer for debugging and edge cases discovered during implementation.*

---

## Files to Delete After Migration

Once Hugo migration is verified and deployed:

```
Sources/                    # Swift source code
Package.swift              # Swift package
Package.resolved
.build/                    # Swift build cache
.swiftpm/
```

Keep:
```
Content/                   # Reference during migration
Resources/                 # Copy to static/
```

---

## Success Criteria

1. ✅ All URLs return same content (no 404s)
2. ✅ RSS feed validates and matches structure
3. ✅ All meta tags present and correct
4. ✅ Blog posts render with syntax highlighting
5. ✅ Images all load correctly
6. ✅ New homepage design implemented
7. ✅ Consistent design across pages
8. ✅ Build time < 1 second
9. ✅ No "Join Forces" anywhere
10. ✅ Contact subtle in footer

---

## Review Feedback Incorporated

This plan has been reviewed and updated to address:

1. **RSS extension fix** - Added `suffix = "rss"` to prevent `feed.xml` instead of `feed.rss`
2. **Sitemap clarification** - Parent build script handles sitemap index; Hugo just generates normal `sitemap.xml`
3. **Syntax highlighting** - Clarified that markdown uses standard code fences; CSS updated for Chroma classes
4. **Blog post count** - Corrected to 25 posts (not 26)
5. **Missing tags** - Added `bonnetjes` and `persona-webcam` tags to expected URLs
6. **Featured posts query** - Added Hugo template logic to filter by `featured: true`
7. **Image path normalization** - Added logic to handle paths with/without leading slash
8. **Persona webcam** - Uses existing inline `<meta refresh>` approach (no special template needed)
9. **Migration script** - Provided robust Python script for frontmatter conversion
10. **Added 404 page and robots.txt** - Included in Phase 9
11. **Timeline updated** - Revised to ~25 hours based on complexity found
