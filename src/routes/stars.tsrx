import { createFileRoute, Link } from "@octanejs/tanstack-router"

import {
  PageDescription,
  PageHeader,
  PageHeading,
  PageWrapper,
} from "@/components/app/page.tsrx"

import StarsGrid from "@/app/stars/stars-grid.tsrx"

export const Route = createFileRoute("/stars")({
  head: () => ({
    meta: [
      { title: "Stars - Neobrutalism components" },
      { name: "description", content: "Get started with neobrutalism stars." },
    ],
  }),
  component: Page,
})

function Page() @{
  <PageWrapper>
    <PageHeader>
      <PageHeading>Stars</PageHeading>

      <PageDescription>
        40 geometrical shapes (as Octane components) often used in neobrutalism
        layouts you can use in your next project. Check the{" "}
        <Link class="underline" to="/docs/stars">
          installation guide
        </Link>{" "}
        for more info.
      </PageDescription>
    </PageHeader>
    <StarsGrid />
  </PageWrapper>
}
