/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./layouts/**/*.html",
    "./content/**/*.md",
    "./Output/**/*.html"
  ],
  theme: {
    extend: {
      colors: {
        'orange': {
          DEFAULT: '#FF9500',
          50: '#FFF5E6',
          100: '#FFE5BF',
          200: '#FFD699',
          300: '#FFC266',
          400: '#FFAD33',
          500: '#FF9500',
          600: '#E68600',
          700: '#CC7700',
          800: '#996600',
          900: '#664400',
        }
      }
    },
  },
  plugins: [],
}
