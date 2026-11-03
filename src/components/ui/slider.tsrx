import type { ClassValue } from "clsx"
import { useMemo } from "octane"
import { Slider as SliderPrimitive } from "@octanejs/base-ui/slider"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function Slider({
  class: klass,
  className,
  defaultValue,
  value,
  min = 0,
  max = 100,
  ...props
}: StyledProps<SliderPrimitive.Root.Props>) @{
  const _values = useMemo(
    () =>
      Array.isArray(value)
        ? value
        : Array.isArray(defaultValue)
          ? defaultValue
          : [min, max],
    [value, defaultValue, min, max],
  )
  const thumbIndexes = Array.from(
    { length: _values.length },
    (_, index) => index,
  )

  <SliderPrimitive.Root
    data-slot="slider"
    defaultValue={defaultValue}
    value={value}
    min={min}
    max={max}
    thumbAlignment="edge"
    className={cn(
      "data-[orientation=horizontal]:w-full data-[orientation=vertical]:h-full",
      className,
      klass,
    )}
    {...props}
  >
    <SliderPrimitive.Control
      data-slot="slider-control"
      className="relative flex w-full touch-none select-none items-center data-disabled:opacity-50 data-[orientation=vertical]:h-full data-[orientation=vertical]:min-h-44 data-[orientation=vertical]:w-auto data-[orientation=vertical]:flex-col"
    >
      <SliderPrimitive.Track
        data-slot="slider-track"
        className="relative grow overflow-hidden rounded-base bg-secondary-background border-2 border-border select-none data-[orientation=horizontal]:h-3 data-[orientation=horizontal]:w-full data-[orientation=vertical]:h-full data-[orientation=vertical]:w-3"
      >
        <SliderPrimitive.Indicator
          data-slot="slider-range"
          className="bg-main select-none data-[orientation=horizontal]:h-full data-[orientation=vertical]:w-full"
        />
      </SliderPrimitive.Track>
      @for (const index of thumbIndexes; key index) {
        <SliderPrimitive.Thumb
          data-slot="slider-thumb"
          className="block size-5 shrink-0 rounded-full border-2 border-border bg-white ring-offset-white transition-colors select-none has-focus-visible:outline-none has-focus-visible:ring-2 has-focus-visible:ring-ring has-focus-visible:ring-offset-2 data-disabled:pointer-events-none data-disabled:opacity-50"
        />
      }
    </SliderPrimitive.Control>
  </SliderPrimitive.Root>
}

export { Slider }
