import type { ClassValue } from "clsx"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function Skeleton({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="skeleton"
    class={cn(
      "animate-pulse rounded-base bg-secondary-background border-2 border-border",
      className,
      klass,
    )}
    {...props}
  />
}

export { Skeleton }
