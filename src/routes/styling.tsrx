import { createFileRoute } from "@octanejs/tanstack-router"

import {
  PageDescription,
  PageHeader,
  PageHeading,
  PageWrapper,
} from "@/components/app/page.tsrx"

import ExampleComponents from "@/app/styling/example-components.tsrx"
import Styling from "@/app/styling/styling.tsrx"

export const Route = createFileRoute("/styling")({
  head: () => ({
    meta: [
      { title: "Styling - Neobrutalism components" },
      {
        name: "description",
        content: "Learn how to fully customize your neobrutalism layouts.",
      },
    ],
  }),
  component: Page,
})

function Page() @{
  <PageWrapper>
    <PageHeader>
      <PageHeading>Styling</PageHeading>

      <PageDescription>
        Choose a color scheme with other styling options and copy the styling to
        your project.
      </PageDescription>

      <Styling />

      <ExampleComponents />
    </PageHeader>
  </PageWrapper>
}
