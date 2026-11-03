import type { ClassValue } from "clsx"
import { Radio as RadioPrimitive } from "@octanejs/base-ui/radio"
import { RadioGroup as RadioGroupPrimitive } from "@octanejs/base-ui/radio-group"
import { Circle } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function RadioGroup({
  class: klass,
  className,
  ...props
}: StyledProps<RadioGroupPrimitive.Props>) @{
  <RadioGroupPrimitive
    data-slot="radio-group"
    className={cn("grid gap-2", className, klass)}
    {...props}
  />
}

function RadioGroupItem({
  class: klass,
  className,
  ...props
}: StyledProps<RadioPrimitive.Root.Props>) @{
  <RadioPrimitive.Root
    data-slot="radio-group-item"
    className={cn(
      "inline-flex aspect-square size-4 items-center justify-center rounded-full border-2 border-border text-black focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 data-disabled:cursor-not-allowed data-disabled:opacity-50 aria-invalid:border-red-500 aria-invalid:text-red-500",
      className,
      klass,
    )}
    {...props}
  >
    <RadioPrimitive.Indicator
      data-slot="radio-group-indicator"
      className="flex items-center justify-center"
    >
      <Circle class="size-2 fill-current text-current" />
    </RadioPrimitive.Indicator>
  </RadioPrimitive.Root>
}

export { RadioGroup, RadioGroupItem }
