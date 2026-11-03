// Docs content index. Replaces the velite `docs` collection: every .mdx file
// under src/markdown is compiled by @octanejs/mdx (see mdx.config.ts) and
// loaded lazily per page, so the docs route only ships the document it shows.
import type { Toc } from "@stefanprobst/rehype-extract-toc"

export interface DocFrontmatter {
  title: string
  description: string
  shadcnDocsLink?: string
}

export interface DocModule {
  default: (props: { components?: Record<string, unknown> }) => unknown
  frontmatter: DocFrontmatter
  toc: Toc
}

const modules = import.meta.glob<DocModule>("/src/markdown/**/*.mdx")

// velite's `slugAsParams`: drop the collection folder ("docs"/"components")
// and the trailing "index", so docs/index.mdx -> "" and components/button.mdx
// -> "button".
function toSlugAsParams(path: string) {
  const parts = path
    .replace(/^\/src\/markdown\//, "")
    .replace(/\.mdx$/, "")
    .split("/")
    .slice(1)
  if (parts.at(-1) === "index") parts.pop()
  return parts.join("/")
}

const loaders = new Map<string, () => Promise<DocModule>>()
for (const [path, load] of Object.entries(modules)) {
  loaders.set(toSlugAsParams(path), load)
}

export const docSlugs = [...loaders.keys()]

export function hasDoc(slug: string) {
  return loaders.has(slug)
}

// One promise per slug so `use()` sees a stable thenable across renders and
// across server render -> client hydration.
const cache = new Map<string, Promise<DocModule>>()
// Settled modules, so a render that runs after the route loader awaited the
// doc (server render, client navigation) reads it synchronously instead of
// going through `use()`. Only the first client hydration of a doc page,
// before its chunk has arrived, has to suspend.
const loaded = new Map<string, DocModule>()

export function loadDoc(slug: string): Promise<DocModule> {
  let promise = cache.get(slug)
  if (!promise) {
    const load = loaders.get(slug)
    if (!load) return Promise.reject(new Error(`Unknown doc: ${slug}`))
    promise = load().then((mod) => {
      loaded.set(slug, mod)
      return mod
    })
    cache.set(slug, promise)
  }
  return promise
}

export function getLoadedDoc(slug: string): DocModule | undefined {
  return loaded.get(slug)
}

export interface TOCItem {
  depth: number
  value: string
  id: string
}

export function flattenToc(items: Toc): TOCItem[] {
  const flattened: TOCItem[] = []
  for (const item of items) {
    flattened.push({ depth: item.depth, value: item.value, id: item.id ?? "" })
    if (item.children) flattened.push(...flattenToc(item.children))
  }
  return flattened
}
