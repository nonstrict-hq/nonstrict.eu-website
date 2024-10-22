# Commit Template based website

Commit is a [Tailwind UI](https://tailwindui.com) site template built using [Tailwind CSS](https://tailwindcss.com) and [Next.js](https://nextjs.org).

## Getting started

1. Install dependencies `./setup.sh`
2. Update `.env.local`: `NEXT_PUBLIC_SITE_URL=https://nonstrict.eu/name_of_app`
3. Update `next.config.mjs`: `basePath: '/name_of_app'`

Search for `name_of_app` in the project to find all places where you need to edit content for this app.

You can now run the dev server: `./serve.sh`
Open http://localhost:3000/name_of_app in your browser to view the website.

## Build a production version

Run: `./build.sh`
The site will be put in the `out` folder.

Don't forget to add the new site to the root folders `setup.sh` and `build.sh` script!

### Adding changelog entries

All of the changelog entries are stored in one big `./src/app/page.mdx` file. We were inspired to set it up this way by how projects commonly maintain plaintext `CHANGELOG` files, and thought it would be cool to parse this sort of format and turn it into a nicely designed site.

Each changelog entry should be separated by a horizontal rule (`---`) and should include an `<h2>` with a date, specified as an [MDX annotation](https://github.com/bradlc/mdx-annotations):

```md
---

![](@/images/your-screenshot.png)

## My new changelog entry {{ date: '2023-04-06T00:00Z' }}

Your content...
```

### Newsletter

You can find the newsletter sign up form in `./src/components/SignUpForm.tsx` — if you have a newsletter you'll want to wire this up with whatever mailing list software you use to get it to actually work.

## License

This site template is a commercial product and is licensed under the [Tailwind UI license](https://tailwindui.com/license).
