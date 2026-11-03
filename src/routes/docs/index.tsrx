import { createFileRoute } from "@octanejs/tanstack-router"

import { docHead, DocPage, loadDocData } from "./-doc-page.tsrx"

// /docs renders markdown/docs/index.mdx (slugAsParams "").
export const Route = createFileRoute("/docs/")({
  loader: () => loadDocData(""),
  head: ({ loaderData }) => docHead(loaderData),
  component: Page,
})

function Page() @{
  const data = Route.useLoaderData()

  <DocPage data={data} />
}
