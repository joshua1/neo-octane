import type { ClassValue } from "clsx"
import { type OctaneNode } from "octane"
import { Popover as PopoverPrimitive } from "@octanejs/base-ui/popover"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type PartProps = Record<string, any> & ClassProps

function Popover(props: PopoverPrimitive.Root.Props) @{
  <PopoverPrimitive.Root data-slot="popover" {...props} />
}

function PopoverTrigger({ class: klass, className, ...props }: PartProps) @{
  <PopoverPrimitive.Trigger
    data-slot="popover-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

type PopoverContentProps = PartProps &
  Pick<
    PopoverPrimitive.Positioner.Props,
    "align" | "alignOffset" | "side" | "sideOffset"
  >

function PopoverContent({
  class: klass,
  className,
  align = "center",
  alignOffset = 0,
  side = "bottom",
  sideOffset = 4,
  ...props
}: PopoverContentProps) @{
  <PopoverPrimitive.Portal>
    <PopoverPrimitive.Positioner
      align={align}
      alignOffset={alignOffset}
      side={side}
      sideOffset={sideOffset}
      className="isolate z-50"
    >
      <PopoverPrimitive.Popup
        data-slot="popover-content"
        className={cn(
          "z-50 flex w-72 flex-col gap-4 rounded-base border-2 border-border bg-background p-4 text-foreground outline-none origin-(--transform-origin) data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2",
          className,
          klass,
        )}
        {...props}
      />
    </PopoverPrimitive.Positioner>
  </PopoverPrimitive.Portal>
}

function PopoverHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="popover-header"
    class={cn("flex flex-col gap-1", className, klass)}
    {...props}
  />
}

function PopoverTitle({ class: klass, className, ...props }: PartProps) @{
  <PopoverPrimitive.Title
    data-slot="popover-title"
    className={cn("font-heading leading-none", className, klass)}
    {...props}
  />
}

function PopoverDescription({ class: klass, className, ...props }: PartProps) @{
  <PopoverPrimitive.Description
    data-slot="popover-description"
    className={cn("text-sm font-base text-foreground", className, klass)}
    {...props}
  />
}

export {
  Popover,
  PopoverTrigger,
  PopoverContent,
  PopoverHeader,
  PopoverTitle,
  PopoverDescription,
}
