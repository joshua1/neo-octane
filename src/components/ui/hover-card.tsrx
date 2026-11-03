import type { ClassValue } from "clsx"
import { PreviewCard as HoverCardPrimitive } from "@octanejs/base-ui/preview-card"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type PartProps = Record<string, any> & ClassProps

function HoverCard(props: HoverCardPrimitive.Root.Props) @{
  <HoverCardPrimitive.Root data-slot="hover-card" {...props} />
}

function HoverCardTrigger({ class: klass, className, ...props }: PartProps) @{
  <HoverCardPrimitive.Trigger
    data-slot="hover-card-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

type HoverCardContentProps = PartProps &
  Pick<
    HoverCardPrimitive.Positioner.Props,
    "align" | "alignOffset" | "side" | "sideOffset"
  >

function HoverCardContent({
  class: klass,
  className,
  align = "center",
  alignOffset = 0,
  side = "bottom",
  sideOffset = 4,
  ...props
}: HoverCardContentProps) @{
  <HoverCardPrimitive.Portal>
    <HoverCardPrimitive.Positioner
      align={align}
      alignOffset={alignOffset}
      side={side}
      sideOffset={sideOffset}
      className="isolate z-50"
    >
      <HoverCardPrimitive.Popup
        data-slot="hover-card-content"
        className={cn(
          "z-50 w-64 rounded-base border-2 border-border bg-background p-4 font-base text-foreground outline-none origin-(--transform-origin) data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2",
          className,
          klass,
        )}
        {...props}
      />
    </HoverCardPrimitive.Positioner>
  </HoverCardPrimitive.Portal>
}

export { HoverCard, HoverCardTrigger, HoverCardContent }
