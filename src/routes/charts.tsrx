import { createFileRoute, Link } from "@octanejs/tanstack-router"

import {
  PageDescription,
  PageHeader,
  PageHeading,
  PageWrapper,
} from "@/components/app/page.tsrx"

import Examples from "@/app/charts/examples.tsrx"

const description =
  "Beautiful charts. Built using Recharts. Copy and paste into your apps."

export const Route = createFileRoute("/charts")({
  head: () => ({
    meta: [
      { title: "Charts - Neobrutalism components" },
      { name: "description", content: description },
    ],
  }),
  component: Page,
})

function Page() @{
  <PageWrapper>
    <PageHeader>
      <PageHeading>Charts</PageHeading>

      <PageDescription>
        Beautiful charts. Built using Recharts. Copy and paste into your apps.{" "}
        <br />
        Visit{" "}
        <Link class="underline" to="/docs/chart">
          charts docs
        </Link>{" "}
        for more info.
      </PageDescription>
    </PageHeader>

    <Examples />
  </PageWrapper>
}
