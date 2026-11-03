import type { ClassValue } from "clsx"
import { ScrollArea as ScrollAreaPrimitive } from "@octanejs/base-ui/scroll-area"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function ScrollArea({
  class: klass,
  className,
  children,
  ...props
}: StyledProps<ScrollAreaPrimitive.Root.Props>) @{
  <ScrollAreaPrimitive.Root
    data-slot="scroll-area"
    className={cn("relative overflow-hidden", className, klass)}
    {...props}
  >
    <ScrollAreaPrimitive.Viewport
      data-slot="scroll-area-viewport"
      className="h-full w-full font-base outline-none"
    >
      {children}
    </ScrollAreaPrimitive.Viewport>
    <ScrollBar />
    <ScrollAreaPrimitive.Corner />
  </ScrollAreaPrimitive.Root>
}

function ScrollBar({
  class: klass,
  className,
  orientation = "vertical",
  ...props
}: StyledProps<ScrollAreaPrimitive.Scrollbar.Props>) @{
  <ScrollAreaPrimitive.Scrollbar
    data-slot="scroll-area-scrollbar"
    orientation={orientation}
    className={cn(
      "flex touch-none select-none transition-colors",
      orientation === "vertical" &&
        "h-full w-2.5 border-l border-l-transparent p-[1px]",
      orientation === "horizontal" &&
        "h-2.5 flex-col border-t border-t-transparent p-[1px]",
      className,
      klass,
    )}
    {...props}
  >
    <ScrollAreaPrimitive.Thumb
      data-slot="scroll-area-thumb"
      className="relative flex-1 rounded-full bg-border"
    />
  </ScrollAreaPrimitive.Scrollbar>
}

export { ScrollArea, ScrollBar }
