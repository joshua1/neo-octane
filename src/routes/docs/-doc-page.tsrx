// Shared by /docs (index.tsrx) and /docs/$ ($.tsrx): the port of
// app/docs/[[...slug]]/page.tsx. The `-` prefix keeps the router generator
// from treating this file as a route.
import { ExternalLink } from "@octanejs/lucide"
import { notFound } from "@octanejs/tanstack-router"
import { use } from "octane"

import { MAIN_SIDEBAR } from "@/data/sidebar-links"

import { sharedComponents } from "@/components/app/mdx-components.tsrx"
import Pagination from "@/components/app/pagination.tsrx"
import { TableOfContents } from "@/components/app/toc.tsrx"
import { Badge } from "@/components/ui/badge.tsrx"

import {
  flattenToc,
  getLoadedDoc,
  hasDoc,
  loadDoc,
  type TOCItem,
} from "@/lib/docs"

export interface DocLoaderData {
  slug: string
  title: string
  description: string
  shadcnDocsLink?: string
  toc: TOCItem[]
}

/**
 * Route loader: validates the slug and returns the serialisable parts of the
 * document. Awaiting loadDoc here also means the module is settled before the
 * page renders, on the server and on client navigations.
 */
export async function loadDocData(slug: string): Promise<DocLoaderData> {
  if (!hasDoc(slug)) throw notFound()
  const { frontmatter, toc } = await loadDoc(slug)
  return {
    slug,
    title: frontmatter.title,
    description: frontmatter.description,
    shadcnDocsLink: frontmatter.shadcnDocsLink,
    toc: flattenToc(toc),
  }
}

export function docHead(data: DocLoaderData | undefined) {
  if (!data) return {}
  return {
    meta: [
      { title: `${data.title} - Neobrutalism components` },
      { name: "description", content: data.description },
    ],
  }
}

/**
 * The document body. The loader already awaited the module, so it is read
 * synchronously; only the first hydration of a docs page, before the doc's
 * chunk has loaded in the browser, goes through `use()`. That attempt
 * suspends, the server HTML stays in place, and hydration resumes once the
 * chunk arrives.
 */
function DocBody({ slug }: { slug: string }) @{
  const mod = getLoadedDoc(slug) ?? use(loadDoc(slug))
  const Doc = mod.default as (props: {
    components?: Record<string, unknown>
  }) => any

  <Doc components={sharedComponents} />
}

export function DocPage({ data }: { data: DocLoaderData }) @{
  const { description, title, shadcnDocsLink, slug } = data

  const filteredSidebar = MAIN_SIDEBAR.filter(
    (item): item is { href: string; text: string } => typeof item === "object",
  )

  const currentIndex = filteredSidebar.findIndex((item) => {
    const isIndex = slug === ""

    if (isIndex) {
      return item.href === "/docs"
    }

    return item.href === "/docs/" + slug
  })

  const prevItem = filteredSidebar[currentIndex - 1]
  const nextItem = filteredSidebar[currentIndex + 1]

  const tableOfContents = data.toc

  const paginationProps = {
    prev: prevItem ? { name: prevItem.text, path: prevItem.href } : undefined,
    next: nextItem ? { name: nextItem.text, path: nextItem.href } : undefined,
  }

  const isTocEmpty = tableOfContents.length < 2

  <div class="docs min-h-[100dvh] w-full bg-background pt-[70px]">
    <div class="lg:ml-[250px] xl:mr-[250px] mr-0 ml-0 prose-p:text-foreground prose-p:mt-6 prose-headings:scroll-mt-32 prose-h1:mb-4 prose-ul:pl-5 prose-ul:list-disc prose-li:font-base sm:prose-li:text-base prose-li:text-sm prose-li:mt-2 lg:py-20 sm:py-16 py-12 leading-relaxed prose-h2:mt-10 prose-h2:mb-6 prose-h3:mt-8 prose-headings:font-heading sm:prose-h1:text-3xl prose-h1:text-2xl sm:prose-h2:text-2xl prose-h2:text-xl prose-h3:mb-6 sm:prose-h3:text-xl prose-h3:text-lg prose-p:leading-7 sm:prose-p:text-base prose-p:text-sm prose-p:font-base prose-code:px-[5px] prose-code:py-[2px] prose-a:underline prose-a:decoration-2 prose-a:underline-offset-2 prose-a:font-heading prose-code:rounded-base prose-code:font-base prose-code:font-[inherit] prose-code:border-2 prose-code:text-foreground prose-code:whitespace-nowrap prose-code:text-sm prose-code:mx-0.5 prose-code:border-border prose-code:bg-secondary-background">
      <div class="2xl:max-w-[750px] max-w-[650px] w-full px-5 mx-auto">
        <article>
          <div class="mb-8">
            <h1>{title as string}</h1>
            @if (description) {
              <p class="mt-0 mb-4 not-prose sm:text-lg text-base font-base text-foreground">
                {description as string}
              </p>
            }
            @if (shadcnDocsLink) {
              <a href={shadcnDocsLink} target="_blank">
                <Badge variant="neutral" class="gap-2">
                  shadcn/ui docs
                  <ExternalLink />
                </Badge>
              </a>
            }
          </div>
          @try {
            <DocBody slug={slug} />
          } @pending {
            <></>
          }

          <div class="mt-14">
            <Pagination {...paginationProps} />
          </div>
        </article>
        @if (!isTocEmpty) {
          <aside class="fixed bg-secondary-background border-l-4 not-prose border-l-border overflow-hidden top-[70px] xl:flex hidden flex-col right-0 w-[250px] h-[calc(100svh-70px)]">
            <TableOfContents items={tableOfContents} />
          </aside>
        }
      </div>
    </div>
  </div>
}
