# Nonstrict Homepage Redesign Concept

## Overview

Redesign the nonstrict.eu homepage to shift focus from client work to showcasing our apps and SDK. Inspired by Iconfactory, Lickability, App Ahead, and Sindre Sorhus.

## Goals

- Showcase Bezel and RecordKit as equal hero products
- Display all apps in a grid on the homepage
- Keep the engineering blog prominent (shows expertise)
- Remove "Join Forces" and client work messaging
- Add subtle contact option in footer
- Create a warmer, more designed feel (not generic Tailwind)

---

## Hero Section

### Text

**Headline:** "We are Nonstrict" *(keep current)*

**Subline:**
> Two developers building native apps and SDKs for Apple platforms. We make Bezel, RecordKit, and more.

### Visual

- Keep the Nonstrict logomark
- Keep the orange/yellow gradient blur background (refine positioning)
- Remove or significantly reduce the large Swift bird image
- No CTA buttons in hero - products section immediately follows

---

## Page Structure

```
┌────────────────────────────────────────────────────────────────┐
│  HEADER                                                        │
│  [Logo]                                     [Blog]  [Contact]  │
├────────────────────────────────────────────────────────────────┤
│  HERO                                                          │
│  - Logomark                                                    │
│  - "We are Nonstrict"                                          │
│  - Subline with product mention                                │
├────────────────────────────────────────────────────────────────┤
│  FEATURED PRODUCTS                                             │
│  - Bezel card (icon, name, one-liner, link)                    │
│  - RecordKit card (icon, name, one-liner, link)                │
│  - Equal size, side by side                                    │
├────────────────────────────────────────────────────────────────┤
│  MORE APPS                                                     │
│  - Grid of all other apps                                      │
│  - Icon + name for each                                        │
│  - 6 columns desktop, 3 tablet, 2 mobile                       │
├────────────────────────────────────────────────────────────────┤
│  ENGINEERING BLOG                                              │
│  - Section title + subtitle                                    │
│  - 3 recent posts (keep current card design)                   │
│  - "All posts" link                                            │
├────────────────────────────────────────────────────────────────┤
│  FOOTER                                                        │
│  - Company info                                                │
│  - Social links                                                │
│  - Subtle contact line                                         │
│  - Copyright                                                   │
└────────────────────────────────────────────────────────────────┘
```

---

## Featured Products Section

Two equal-sized cards for Bezel and RecordKit:

### Bezel Card
- **Icon:** Bezel app icon (64x64 or larger)
- **Name:** Bezel
- **Description:** Mirror any iPhone, iPad, or Apple TV on your Mac
- **Link:** "Learn more →" to nonstrict.eu/bezel/

### RecordKit Card
- **Icon:** RecordKit logo/icon (64x64 or larger)
- **Name:** RecordKit
- **Description:** Screen recording SDK for macOS developers
- **Link:** "Learn more →" to nonstrict.eu/recordkit/

### Card Styling
- White background
- Soft shadow: `0 1px 3px rgba(0,0,0,0.04), 0 4px 12px rgba(0,0,0,0.06)`
- Border radius: 12px
- Hover: subtle lift (`translateY(-2px)`) + shadow increase

---

## App Grid Section

### Apps to Include (11 total)

| App | Platform | Link |
|-----|----------|------|
| Splitscreen | visionOS, Mac | App Store |
| CleanPresenter | Mac | App Store |
| Persona Webcam | Mac, visionOS | App Store |
| Keep Going | iOS, watchOS | App Store |
| Rhythm | iOS, iPadOS, watchOS | App Store |
| Typos | iOS, iPadOS, visionOS | App Store |
| Receipt Scanner (Bonnetjes) | iOS, iPadOS | App Store |
| Upscale (VideoKit) | iOS, iPadOS | App Store |
| WWDC Index | Web | nonstrict.eu/wwdcindex/ |

### Grid Layout
- 6 columns on desktop (xl+)
- 4 columns on large tablet (lg)
- 3 columns on tablet (md)
- 2 columns on mobile

### Item Styling
- App icon (48x48)
- App name below icon
- Link to App Store or dedicated page
- Hover: subtle lift effect
- Optional: one-liner tooltip on hover (future enhancement)

### Section Background
- Off-white (#fafafa) to create visual rhythm

---

## Blog Section

### Content
- Section title: "From our engineering blog"
- Subtitle: "Deep dives into Apple platform development"
- Show 3 most recent posts
- "All posts →" link to /blog

### Styling
- Keep current card design (works well)
- White background section

---

## Footer

### Content
```
Nonstrict B.V.
Amersfoort, The Netherlands

[GitHub] [Mastodon] [X] [LinkedIn] [Email]

────────────────────────────────────────

Working on something interesting? hello@nonstrict.com

© 2023-2025 Nonstrict B.V. — KVK 89067657
```

### Changes from Current
- Remove "Join Forces" button
- Add subtle contact invitation text
- Keep social links

---

## Navigation

### Header
- Logo (links to home)
- "Blog" link
- "Contact" link (mailto or anchor to footer)

### Removed
- "Apps" nav item (all apps shown on homepage)
- "Join forces" CTA button

---

## Visual Design Direction

### Color Palette

```css
/* Primary */
--orange: #FF9500;
--orange-dark: #E68600;      /* hover states */
--orange-light: #FFF5E6;     /* subtle backgrounds */

/* Neutrals */
--text-primary: #1a1a1a;     /* headlines */
--text-secondary: #4a4a4a;   /* body text */
--text-muted: #737373;       /* captions, metadata */
--border: #e5e5e5;           /* dividers */
--bg-off-white: #fafafa;     /* alternating sections */
```

### Typography
- Headlines: System UI, bold (700), tight tracking (-0.02em)
- Body: System UI, regular, 1.6 line-height, #4a4a4a
- App names: Medium weight (500), slightly larger than body

### Spacing
- Section padding: 5-6rem vertical on desktop
- Card gaps: 1.5rem minimum
- Content max-width: ~72rem

### Visual Accents
- Soft shadows on cards (not flat)
- Rounded corners: 12px cards, 8px buttons
- Background color shifts between sections for rhythm
- Subtle hover interactions (lift + shadow)
- Orange used intentionally, not everywhere

---

## What's Removed

- [ ] "Join Forces" button (header and everywhere)
- [ ] "Occasionally we work with clients" text
- [ ] /apps as separate page
- [ ] Large Swift bird hero image (or make much smaller)
- [ ] "Contact us" as primary CTA

## What's Added

- [ ] RecordKit as hero product (equal to Bezel)
- [ ] Complete app grid with all apps
- [ ] Splitscreen app (Jordi Bruin collab)
- [ ] Subtle contact in footer
- [ ] Visual warmth (shadows, background rhythm)
- [ ] Product mentions in hero text

---

## Future Enhancements (Not in Scope Now)

- Reusable app page template for individual apps
- One-liner tooltips on app grid hover
- Dark mode support
- App filtering by platform

---

## Reference Sites

- [Iconfactory](https://iconfactory.com) - Visual warmth, apps + services balance
- [Lickability](https://lickability.com) - Modern design, playful accents
- [App Ahead](https://appahead.studio) - Clean app grid, minimal
- [Sindre Sorhus](https://sindresorhus.com) - App showcase, filtering
- [Panic](https://panic.com) - Product categories, personality
