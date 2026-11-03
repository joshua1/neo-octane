import type { ClassValue } from "clsx"
import { Loader2Icon, type LucideProps } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

function Spinner({
  class: klass,
  className,
  ...props
}: LucideProps & ClassProps) @{
  <Loader2Icon
    data-slot="spinner"
    role="status"
    aria-label="Loading"
    class={cn("size-4 animate-spin", className, klass)}
    {...props}
  />
}

export { Spinner }
