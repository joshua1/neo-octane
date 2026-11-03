import { createFileRoute } from "@octanejs/tanstack-router"

import {
  PageDescription,
  PageHeader,
  PageHeading,
  PageWrapper,
} from "@/components/app/page.tsrx"

export const Route = createFileRoute("/templates")({
  head: () => ({
    meta: [
      { title: "Templates - Neobrutalism components" },
      {
        name: "description",
        content: "Neobrutalism templates are coming soon.",
      },
    ],
  }),
  component: Page,
})

function Page() @{
  <PageWrapper>
    <PageHeader>
      <PageHeading>Templates</PageHeading>

      <PageDescription>Templates are coming soon.</PageDescription>
    </PageHeader>
  </PageWrapper>
}
