import { createFileRoute } from "@octanejs/tanstack-router"

import NotFound from "@/components/app/not-found.tsrx"

import { docHead, DocPage, loadDocData } from "./-doc-page.tsrx"

export const Route = createFileRoute("/docs/$")({
  loader: ({ params }) => loadDocData(params._splat ?? ""),
  head: ({ loaderData }) => docHead(loaderData),
  component: Page,
  // An unknown slug throws notFound() from the loader. Handling it on this
  // route (not the /docs layout) renders the 404 inside the layout's Outlet,
  // so the Sidebar and footer stay, as with the Next.js docs layout.
  notFoundComponent: NotFound,
})

function Page() @{
  const data = Route.useLoaderData()

  <DocPage data={data} />
}
