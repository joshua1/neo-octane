import type { ClassValue } from "clsx"
import { type OctaneNode } from "octane"
import { Tooltip as TooltipPrimitive } from "@octanejs/base-ui/tooltip"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type PartProps = Record<string, any> & ClassProps

function TooltipProvider({
  delay = 0,
  ...props
}: TooltipPrimitive.Provider.Props) @{
  <TooltipPrimitive.Provider
    data-slot="tooltip-provider"
    delay={delay}
    {...props}
  />
}

function Tooltip(props: TooltipPrimitive.Root.Props) @{
  <TooltipPrimitive.Root data-slot="tooltip" {...props} />
}

function TooltipTrigger({ class: klass, className, ...props }: PartProps) @{
  <TooltipPrimitive.Trigger
    data-slot="tooltip-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

type TooltipContentProps = PartProps & {
  children?: OctaneNode
} & Pick<
    TooltipPrimitive.Positioner.Props,
    "align" | "alignOffset" | "side" | "sideOffset"
  >

function TooltipContent({
  class: klass,
  className,
  side = "top",
  sideOffset = 4,
  align = "center",
  alignOffset = 0,
  children,
  ...props
}: TooltipContentProps) @{
  <TooltipPrimitive.Portal>
    <TooltipPrimitive.Positioner
      align={align}
      alignOffset={alignOffset}
      side={side}
      sideOffset={sideOffset}
      className="isolate z-50"
    >
      <TooltipPrimitive.Popup
        data-slot="tooltip-content"
        className={cn(
          "z-50 overflow-hidden rounded-base border-2 border-border bg-secondary-background px-3 py-1.5 text-sm font-base text-foreground origin-(--transform-origin) data-open:animate-in data-open:fade-in-0 data-open:zoom-in-95 data-closed:animate-out data-closed:fade-out-0 data-closed:zoom-out-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2",
          className,
          klass,
        )}
        {...props}
      >
        {children}
      </TooltipPrimitive.Popup>
    </TooltipPrimitive.Positioner>
  </TooltipPrimitive.Portal>
}

export { Tooltip, TooltipTrigger, TooltipContent, TooltipProvider }
