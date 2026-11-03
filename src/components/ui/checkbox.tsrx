import type { ClassValue } from "clsx"
import { Checkbox as CheckboxPrimitive } from "@octanejs/base-ui/checkbox"
import { Check } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function Checkbox({
  class: klass,
  className,
  ...props
}: StyledProps<CheckboxPrimitive.Root.Props>) @{
  <CheckboxPrimitive.Root
    data-slot="checkbox"
    className={cn(
      "peer flex size-4 shrink-0 items-center justify-center outline-2 outline-border ring-offset-white focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 data-disabled:cursor-not-allowed data-disabled:opacity-50 data-checked:bg-main data-checked:text-white data-indeterminate:bg-main data-indeterminate:text-white aria-invalid:outline-red-500",
      className,
      klass,
    )}
    {...props}
  >
    <CheckboxPrimitive.Indicator
      data-slot="checkbox-indicator"
      className={cn("flex items-center justify-center text-current")}
    >
      <Check class="size-4 text-main-foreground" />
    </CheckboxPrimitive.Indicator>
  </CheckboxPrimitive.Root>
}

export { Checkbox }
