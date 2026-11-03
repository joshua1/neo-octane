import type { ClassValue } from "clsx"
import { ChevronDownIcon } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type NativeSelectProps = Record<string, any> &
  ClassProps & {
    size?: "sm" | "default"
  }

// A real <select>: native `change` is the commit event for selects, so
// consumer `onChange` handlers pass through unrenamed.
function NativeSelect({
  class: klass,
  className,
  size = "default",
  ...props
}: NativeSelectProps) @{
  <div
    class={cn(
      "group/native-select relative w-fit has-[select:disabled]:opacity-50",
      className,
      klass,
    )}
    data-slot="native-select-wrapper"
    data-size={size}
  >
    <select
      data-slot="native-select"
      data-size={size}
      class="h-10 w-full min-w-0 appearance-none rounded-base border-2 border-border bg-secondary-background py-2 pr-9 pl-3 text-sm font-base text-foreground transition-colors outline-none select-none selection:bg-main selection:text-main-foreground placeholder:text-foreground/50 focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 disabled:pointer-events-none disabled:cursor-not-allowed data-[size=sm]:h-9 data-[size=sm]:py-1"
      {...props}
    />
    <ChevronDownIcon
      class="pointer-events-none absolute top-1/2 right-3 size-4 -translate-y-1/2 text-foreground select-none"
      aria-hidden="true"
      data-slot="native-select-icon"
    />
  </div>
}

type ElementProps = Record<string, any> & ClassProps

function NativeSelectOption({
  class: klass,
  className,
  ...props
}: ElementProps) @{
  <option
    data-slot="native-select-option"
    class={cn("bg-[Canvas] text-[CanvasText]", className, klass)}
    {...props}
  />
}

function NativeSelectOptGroup({
  class: klass,
  className,
  ...props
}: ElementProps) @{
  <optgroup
    data-slot="native-select-optgroup"
    class={cn("bg-[Canvas] text-[CanvasText]", className, klass)}
    {...props}
  />
}

export { NativeSelect, NativeSelectOptGroup, NativeSelectOption }
