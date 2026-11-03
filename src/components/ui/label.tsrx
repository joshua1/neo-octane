import type { ClassValue } from "clsx"
import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type LabelProps = Record<string, any> & ClassProps

function Label({ class: klass, className, ...props }: LabelProps) @{
  <label
    data-slot="label"
    class={cn(
      "text-sm font-heading leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70 peer-data-disabled:cursor-not-allowed peer-data-disabled:opacity-70",
      className,
      klass,
    )}
    {...props}
  />
}

export { Label }
