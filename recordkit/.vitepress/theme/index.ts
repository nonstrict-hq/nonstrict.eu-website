// .vitepress/theme/index.ts
import DefaultTheme from 'vitepress/theme'
import type { Theme } from 'vitepress'
import './custom.css'   // ← add this line

// Sections
import Intro from './components/Intro.vue'
import UntilYouShip from './components/UntilYouShip.vue'
import HowHelps from './components/HowHelps.vue'
import Features from './components/Features.vue'
import HowItWorks from './components/HowItWorks.vue'
import FreeTrial from './components/FreeTrial.vue'
import Customers from './components/Customers.vue'
import FAQ from './components/FAQ.vue'
import FooterLinks from './components/FooterLinks.vue'
import CtaButtons from './components/CtaButtons.vue'

export default {
  extends: DefaultTheme,
  enhanceApp({ app }) {
    app.component('Intro', Intro)
    app.component('UntilYouShip', UntilYouShip)
    app.component('HowHelps', HowHelps)
    app.component('Features', Features)
    app.component('HowItWorks', HowItWorks)
    app.component('FreeTrial', FreeTrial)
    app.component('Customers', Customers)
    app.component('FAQ', FAQ)
    app.component('FooterLinks', FooterLinks)
    app.component('CtaButtons', CtaButtons)
  }
} satisfies Theme
