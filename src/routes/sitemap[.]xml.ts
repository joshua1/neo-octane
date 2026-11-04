import { createFileRoute } from "@octanejs/tanstack-router"

import COMPONENTS from "@/data/components"

import { transformToSlug } from "@/lib/utils"

// Port of app/sitemap.ts as a server route.
const root = "https://neobrutalism-octane.vercel.app"

const DOCS_PAGES = [
  "/docs",
  "/docs/figma",
  "/docs/changelog",
  "/docs/installation",
  "/docs/stars",
  "/templates",
  "/showcase",
  "/stars",
  "/styling",
  "/charts",
]

function sitemap() {
  const lastModified = new Date().toISOString()
  const entries = [
    { url: root, priority: 1 },
    ...DOCS_PAGES.map((page) => ({ url: root + page, priority: 1 })),
    ...COMPONENTS.map((page) => ({
      url: root + "/docs/" + transformToSlug(page.name),
      priority: 0.8,
    })),
  ]

  const urls = entries
    .map(
      ({ url, priority }) =>
        `<url>\n<loc>${url}</loc>\n<lastmod>${lastModified}</lastmod>\n<priority>${priority}</priority>\n</url>`,
    )
    .join("\n")

  return `<?xml version="1.0" encoding="UTF-8"?>\n<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n${urls}\n</urlset>\n`
}

export const Route = createFileRoute("/sitemap.xml")({
  server: {
    handlers: {
      GET: async () =>
        new Response(sitemap(), {
          headers: { "Content-Type": "application/xml" },
        }),
    },
  },
})
