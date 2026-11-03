import type { ClassValue } from "clsx"
import { type OctaneNode } from "octane"
import { Dialog as SheetPrimitive } from "@octanejs/base-ui/dialog"
import { X } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type PartProps = Record<string, any> & ClassProps

function Sheet(props: SheetPrimitive.Root.Props) @{
  <SheetPrimitive.Root data-slot="sheet" {...props} />
}

function SheetTrigger({ class: klass, className, ...props }: PartProps) @{
  <SheetPrimitive.Trigger
    data-slot="sheet-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function SheetClose({ class: klass, className, ...props }: PartProps) @{
  <SheetPrimitive.Close
    data-slot="sheet-close"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function SheetPortal({ class: klass, className, ...props }: PartProps) @{
  <SheetPrimitive.Portal
    data-slot="sheet-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function SheetOverlay({ class: klass, className, ...props }: PartProps) @{
  <SheetPrimitive.Backdrop
    data-slot="sheet-overlay"
    className={cn(
      "data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:duration-300 data-open:duration-500 fill-mode-forwards fixed inset-0 z-50 bg-overlay",
      className,
      klass,
    )}
    {...props}
  />
}

type SheetContentProps = PartProps & {
  children?: OctaneNode
  side?: "top" | "bottom" | "left" | "right"
  showCloseButton?: boolean
}

function SheetContent({
  class: klass,
  className,
  children,
  side = "right",
  showCloseButton = true,
  ...props
}: SheetContentProps) @{
  <SheetPortal>
    <SheetOverlay />
    <SheetPrimitive.Popup
      data-slot="sheet-content"
      data-side={side}
      className={cn(
        "bg-background data-open:animate-in data-closed:animate-out fixed z-50 flex flex-col gap-4 border-2 border-border outline-none transition ease-in-out data-closed:duration-300 data-open:duration-500",
        side === "right" &&
          "data-closed:slide-out-to-right data-open:slide-in-from-right inset-y-0 right-0 h-full w-3/4 border-l sm:max-w-sm",
        side === "left" &&
          "data-closed:slide-out-to-left data-open:slide-in-from-left inset-y-0 left-0 h-full w-3/4 border-r sm:max-w-sm",
        side === "top" &&
          "data-closed:slide-out-to-top data-open:slide-in-from-top inset-x-0 top-0 h-auto border-b",
        side === "bottom" &&
          "data-closed:slide-out-to-bottom data-open:slide-in-from-bottom inset-x-0 bottom-0 h-auto border-t",
        className,
        klass,
      )}
      {...props}
    >
      {children}
      @if (showCloseButton) {
        <SheetPrimitive.Close
          data-slot="sheet-close"
          className="absolute right-4 top-4 rounded-base ring-offset-white focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 disabled:pointer-events-none"
        >
          <X class="h-4 w-4" />
          <span class="sr-only">Close</span>
        </SheetPrimitive.Close>
      }
    </SheetPrimitive.Popup>
  </SheetPortal>
}

function SheetHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="sheet-header"
    class={cn("flex flex-col gap-1.5 p-4", className, klass)}
    {...props}
  />
}

function SheetFooter({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="sheet-footer"
    class={cn("mt-auto flex flex-col gap-3 p-4", className, klass)}
    {...props}
  />
}

function SheetTitle({ class: klass, className, ...props }: PartProps) @{
  <SheetPrimitive.Title
    data-slot="sheet-title"
    className={cn("text-foreground font-heading", className, klass)}
    {...props}
  />
}

function SheetDescription({ class: klass, className, ...props }: PartProps) @{
  <SheetPrimitive.Description
    data-slot="sheet-description"
    className={cn("text-sm text-foreground font-base", className, klass)}
    {...props}
  />
}

export {
  Sheet,
  SheetPortal,
  SheetOverlay,
  SheetTrigger,
  SheetClose,
  SheetContent,
  SheetHeader,
  SheetFooter,
  SheetTitle,
  SheetDescription,
}
