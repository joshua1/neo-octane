import { createFileRoute } from "@octanejs/tanstack-router"

import SHOWCASE from "@/data/showcase"

import {
  PageDescription,
  PageHeader,
  PageHeading,
  PageWrapper,
} from "@/components/app/page.tsrx"
import ShowcaseContainer from "@/components/app/showcase-container.tsrx"

export const Route = createFileRoute("/showcase")({
  head: () => ({
    meta: [
      { title: "Showcase - Neobrutalism components" },
      {
        name: "description",
        content: "Showcase of websites built with neobrutalism components.",
      },
    ],
  }),
  component: Page,
})

function Page() @{
  <PageWrapper>
    <PageHeader>
      <PageHeading>Showcase</PageHeading>

      <PageDescription>
        Showcase of websites built with neobrutalism components.
        <br />
        If you&apos;ve built something and want to get it featured here,{" "}
        <a
          class="underline"
          target="_blank"
          href="https://x.com/samuelbreznjak"
        >
          dm me
        </a>{" "}
        or{" "}
        <a class="underline" href="mailto:samuelbreznjak35@gmail.com">
          email me
        </a>
        .{" "}
      </PageDescription>
    </PageHeader>

    <ShowcaseContainer items={SHOWCASE} />
  </PageWrapper>
}
