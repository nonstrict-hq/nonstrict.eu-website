/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./layouts/**/*.html", "./content/**/*.md", "./static/**/*.html"],
  theme: {
    extend: {
      colors: {
        'orange': {
          DEFAULT: '#FF9500',
          500: '#E88600',
        }
      }
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
