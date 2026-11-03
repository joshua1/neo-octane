import { ArrowUpRight } from "@octanejs/lucide"
import { createFileRoute, Link } from "@octanejs/tanstack-router"

import COMPONENTS from "@/data/components"

import StarField from "@/components/app/landing/star-field.tsrx"
import Star32 from "@/components/stars/s32.tsrx"
import { Button } from "@/components/ui/button.tsrx"

export const Route = createFileRoute("/")({
  component: Home,
})

function Home() @{
  <main class="relative flex h-[100dvh] w-full flex-col items-center justify-center overflow-hidden bg-background px-5 font-base text-foreground [@media(max-height:640px)]:pt-[70px] bg-[linear-gradient(to_right,#80808033_1px,transparent_1px),linear-gradient(to_bottom,#80808033_1px,transparent_1px)] bg-[size:70px_70px]">
    <StarField class="[@media(max-height:640px)]:top-[70px]" />

    <div class="relative flex w-full max-w-[820px] flex-col items-center text-center">
      <h1 class="font-heading text-3xl leading-tight sm:text-[40px] md:text-5xl xl:text-6xl">
        Build bold For Octane.dev
        <span class="inline-flex items-center gap-2 whitespace-nowrap align-baseline sm:gap-3">
          <Star32
            aria-hidden
            color="var(--chart-4)"
            stroke="var(--border)"
            strokeWidth={5}
            class="size-[0.8em] shrink-0"
          />
          <span class="text-chart-4 [paint-order:stroke_fill] [-webkit-text-stroke:3px_var(--border)] md:[-webkit-text-stroke:5px_var(--border)]">
            neobrutalism
          </span>
          <Star32
            aria-hidden
            color="var(--chart-4)"
            stroke="var(--border)"
            strokeWidth={5}
            class="size-[0.8em] shrink-0"
          />
        </span>{" "}
        layouts in minutes.
      </h1>

      <p class="mt-6 max-w-[680px] text-lg leading-snug sm:text-xl md:mt-8 md:text-2xl">
        {String(COMPONENTS.length)} components, charts and star shapes for
        Octane and Tailwind v4. Built on the Octane port of shadcn/ui and Base
        UI. Pick a palette and start shipping.
      </p>

      <Button
        size="lg"
        class="mt-8 h-12 gap-3 px-7 text-lg md:mt-10 md:h-14 md:px-9 md:text-xl"
        nativeButton={false}
        render={<Link to="/docs" />}
      >
        Get started
        <ArrowUpRight class="size-6! md:size-7!" />
      </Button>
    </div>
  </main>
}
