import { defineConfig } from 'vitepress'
import { groupIconMdPlugin, groupIconVitePlugin } from 'vitepress-plugin-group-icons'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  markdown: {
    config(md) {
      md.use(groupIconMdPlugin)
    },
  },
  vite: {
    plugins: [
      groupIconVitePlugin({
        customIcon: {
          'swift': 'vscode-icons:file-type-swift',
          'electron': 'logos:electron',
        }
      })
    ],
  },

  title: "RecordKit",
  description: "Recording SDK for macOS apps",
  base: '/recordkit/',
  srcExclude: ['README.md'],
  head: [
    ['script', { defer: '', src: 'https://web.nonstrictmetrics.com/js/script.js', 'data-domain': 'nonstrict.eu', 'data-api': 'https://web.nonstrictmetrics.com/api/event' }]
  ],
  sitemap: {
    hostname: 'https://nonstrict.eu/recordkit/',
    transformItems: (items) => {
      // DocC doesn't generate a sitemap, so at least reference the Swift API docs here
      items.push({url: 'https://nonstrict.eu/recordkit/api/swift/documentation/recordkit/'})
      return items
    }
  },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Get Started', link: '/try' },
      {
        text: 'Docs',
        items: [
          { text: 'Guide', link: '/try' },
          { text: 'Swift API Reference', link: 'https://nonstrict.eu/recordkit/api/swift/documentation/recordkit/' },
          { text: 'Electron API Reference', link: 'https://nonstrict.eu/recordkit/api/electron/' }
        ]
      },
      { text: 'Contact Sales', link: 'mailto:team+recordkit@nonstrict.com' }
    ],

    sidebar: [
      {
        text: 'Introduction',
        items: [
          { text: 'What is RecordKit?', link: '/introduction' },
          { text: 'Features', link: '/features' },
          { text: 'Product Demo', link: '/product-demo' }
        ]
      },
      {
        text: 'Getting Started',
        items: [
          { text: 'Try using Swift', link: '/try-swift' },
          { text: 'Try using Electron', link: '/try-electron' },
        ]
      },
      {
        text: 'Guides',
        items: [
          { text: 'Output formats', link: '/guides/output-formats' },
        ]
      },
      {
        text: 'References',
        items: [
          { text: 'Changelog', link: '/changelog' },
          { text: 'Swift API docs', link: 'https://nonstrict.eu/recordkit/api/swift/documentation/recordkit/' },
          { text: 'Electron API docs', link: 'https://nonstrict.eu/recordkit/api/electron/' }
        ]
      }
    ],

    footer: {
      message: 'Questions? Feel free to contact us at team@nonstrict.com',
      copyright: 'Copyright 2023-2025 Nonstrict B.V. All Rights Reserved.'
    }
  }
})
