---
date: 2023-06-21T12:00:00+01:00
slug: "avassetwriter-leaks-segment-data"
title: "AVAssetWriter leaking memory when segment data is used in Swift"
description: "Segment data delivered to AVAssetWriterDelegate is leaked when the delegate is implemented in Swift. You either need to implement the delegate in Objective-C or deallocate the data yourself. This issue is fixed by Apple in macOS 13.3."
authors: ["mathijs", "tom"]
tags: ["engineering"]
image: images/blog/harry-grout-BxiBbWR7rA-unsplash.jpg
featured: true
---

Placeholder - content to be migrated
