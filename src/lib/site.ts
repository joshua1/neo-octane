/**
 * Origin the registry is served from, used for the CLI commands shown in the
 * docs, on the styling page and on the stars page. Locally that is the dev
 * server, so the commands can be tried against unpublished registry items;
 * in production it is the site. Set VITE_SITE_URL to override, for
 * example when the dev server runs on another port.
 *
 * The registry files themselves (src/data/registry.ts and the styling items)
 * keep the production origin, since they are what gets published.
 */
// Vite exposes only VITE_-prefixed env vars to the client (a bare
// `process.env` reference throws in the browser), so the override is
// VITE_SITE_URL here.
export const SITE_URL: string =
  (import.meta.env.VITE_SITE_URL as string | undefined) ??
  (import.meta.env.PROD ? "https://neobrutalism-octane.vercel.app" : "http://localhost:3000")

export const REGISTRY_URL = `${SITE_URL}/r`
