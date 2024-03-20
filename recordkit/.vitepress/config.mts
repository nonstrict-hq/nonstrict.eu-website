import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "RecordKit",
  description: "Recording SDK for macOS apps",
  base: '/recordkit/',
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Get Started', link: '/try' },
      {
        text: 'API Reference',
        items: [
          { text: 'Swift', link: 'https://nonstrict.eu/recordkit/api/swift/documentation/recordkit/' },
          { text: 'Electron', link: 'https://nonstrict.eu/recordkit/api/electron/' },
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
      }
    ],

    footer: {
      message: 'Questions? Feel free to contact us at team@nonstrict.com',
      copyright: 'Copyright 2023-2024 Nonstrict B.V. All Rights Reserved.'
    }
  }
})
