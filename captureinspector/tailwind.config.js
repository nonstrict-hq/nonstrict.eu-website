/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'media',
  content: [
    'layouts/**/*.html',
    'content/**/*.md',
    'static/**/*.html',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          'ui-sans-serif', '-apple-system', 'BlinkMacSystemFont',
          '"Segoe UI"', 'Roboto', 'Helvetica', 'Arial', 'sans-serif',
        ],
        display: ['"Space Grotesk"', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        mono: ['"Space Mono"', 'ui-monospace', 'SFMono-Regular', 'Menlo', 'monospace'],
      },
      colors: {
        // Brand: the info-sign blue, used for site chrome accents + CTAs.
        brand: {
          DEFAULT: '#0A6CF0',
          600: '#0A6CF0',
          700: '#0A55C2',
        },
        // Live/active status (straight from the app's own green badges/dots).
        live: {
          DEFAULT: '#22C55E',
          600: '#16A34A',
        },
        // Per-mock accents so each live preview card has its own energy.
        cam: '#7C3AED',  // camera  → violet
        mic: '#F59E0B',  // mic     → amber
        disp: '#06B6D4', // display → cyan
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
