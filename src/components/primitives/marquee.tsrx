/**
 * Octane port of `@devnomic/marquee@1.0.2` (`Marquee`).
 * Upstream: npm @devnomic/marquee@1.0.2, dist/index.js (built from src/index.tsx).
 * License: MIT, (c) 2024 Erick Hartanto — see ./LICENSE.upstream.md.
 * Styles: the package's dist/index.css marquee rules live in
 * `@/styling/marquee.css`; class names below are kept identical to match it.
 * Divergences:
 * - The `repeat` copies render through a keyed `@for` (key = copy index).
 * - Follows the published 1.0.2 dist, which (unlike src/index.tsx) does not
 *   spread extra props onto the root `div`; the typed surface matches its
 *   `index.d.ts`.
 * - Upstream's local `cn` (clsx + tailwind-merge) is the app's identical `cn`.
 */
import type { OctaneNode } from "octane"

import { cn, type ClassValue } from "@/lib/utils"

export type MarqueeProps = {
  children: OctaneNode
  direction?: "left" | "up"
  pauseOnHover?: boolean
  reverse?: boolean
  fade?: boolean
  class?: ClassValue
  className?: string
  innerClassName?: string
  numberOfCopies?: number
}

function Marquee({
  children,
  direction = "left",
  pauseOnHover = false,
  reverse = false,
  fade = false,
  class: klass,
  className,
  innerClassName,
  numberOfCopies = 2,
}: MarqueeProps) @{
  const maskDirection = direction === "left" ? "to right" : "to bottom"
  const mask = fade
    ? "linear-gradient(" +
      maskDirection +
      ", transparent 0%, rgba(0, 0, 0, 1.0) 10%, rgba(0, 0, 0, 1.0) 90%, transparent 100%)"
    : undefined
  const copies = Array.from({ length: numberOfCopies }, (_, i) => i)

  <div
    class={cn(
      "group flex gap-[1rem] overflow-hidden",
      direction === "left" ? "flex-row" : "flex-col",
      className,
      klass,
    )}
    style={{
      maskImage: mask,
      WebkitMaskImage: mask,
    }}
  >
    @for (const i of copies; key i) {
      <div
        class={cn(
          "flex justify-around gap-[1rem] [--gap:1rem] shrink-0",
          direction === "left"
            ? "animate-marquee-left flex-row"
            : "animate-marquee-up flex-col",
          pauseOnHover && "group-hover:[animation-play-state:paused]",
          reverse && "direction-reverse",
          innerClassName,
        )}
      >
        {children}
      </div>
    }
  </div>
}

export { Marquee }
