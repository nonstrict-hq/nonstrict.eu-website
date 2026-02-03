import { MetadataRoute } from 'next'

export default function sitemap(): MetadataRoute.Sitemap {
  const baseUrl = 'https://nonstrict.eu/fikkie'

  return [
    { url: `${baseUrl}/` },
    { url: `${baseUrl}/privacy/` },
    { url: `${baseUrl}/gebruiksvoorwaarden/` },
    { url: `${baseUrl}/en/` },
    { url: `${baseUrl}/en/privacy/` },
    { url: `${baseUrl}/en/terms/` },
  ]
}
