/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./Output/**/*.{html,js}"],
  theme: {
    extend: {
        colors: {
            'orange': {
                DEFAULT: '#FF9500',
            }
        }
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
