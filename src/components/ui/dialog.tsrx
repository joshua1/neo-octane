import type { ClassValue } from "clsx"
import { type OctaneNode } from "octane"
import { Dialog as DialogPrimitive } from "@octanejs/base-ui/dialog"
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

function Dialog(props: DialogPrimitive.Root.Props) @{
  <DialogPrimitive.Root data-slot="dialog" {...props} />
}

function DialogTrigger({ class: klass, className, ...props }: PartProps) @{
  <DialogPrimitive.Trigger
    data-slot="dialog-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DialogPortal({ class: klass, className, ...props }: PartProps) @{
  <DialogPrimitive.Portal
    data-slot="dialog-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DialogClose({ class: klass, className, ...props }: PartProps) @{
  <DialogPrimitive.Close
    data-slot="dialog-close"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DialogOverlay({ class: klass, className, ...props }: PartProps) @{
  <DialogPrimitive.Backdrop
    data-slot="dialog-overlay"
    className={cn(
      "fixed inset-0 z-50 bg-overlay duration-200 fill-mode-forwards data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0",
      className,
      klass,
    )}
    {...props}
  />
}

type DialogContentProps = PartProps & {
  children?: OctaneNode
  showCloseButton?: boolean
}

function DialogContent({
  class: klass,
  className,
  children,
  showCloseButton = true,
  ...props
}: DialogContentProps) @{
  <DialogPortal>
    <DialogOverlay />
    <DialogPrimitive.Popup
      data-slot="dialog-content"
      className={cn(
        "bg-background data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] translate-x-[-50%] translate-y-[-50%] gap-4 rounded-base border-2 border-border p-6 shadow-shadow duration-200 outline-none sm:max-w-lg",
        className,
        klass,
      )}
      {...props}
    >
      {children}
      @if (showCloseButton) {
        <DialogPrimitive.Close
          data-slot="dialog-close"
          className="absolute right-4 top-4 rounded-base opacity-100 ring-offset-white focus:outline-hidden focus:ring-2 focus:ring-black focus:ring-offset-2 disabled:pointer-events-none [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"
        >
          <X />
          <span class="sr-only">Close</span>
        </DialogPrimitive.Close>
      }
    </DialogPrimitive.Popup>
  </DialogPortal>
}

function DialogHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="dialog-header"
    class={cn("flex flex-col gap-2 text-center sm:text-left", className, klass)}
    {...props}
  />
}

function DialogFooter({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="dialog-footer"
    class={cn(
      "flex flex-col-reverse gap-3 sm:flex-row sm:justify-end",
      className,
      klass,
    )}
    {...props}
  />
}

function DialogTitle({ class: klass, className, ...props }: PartProps) @{
  <DialogPrimitive.Title
    data-slot="dialog-title"
    className={cn(
      "text-lg font-heading leading-none tracking-tight",
      className,
      klass,
    )}
    {...props}
  />
}

function DialogDescription({ class: klass, className, ...props }: PartProps) @{
  <DialogPrimitive.Description
    data-slot="dialog-description"
    className={cn("text-sm font-base text-foreground", className, klass)}
    {...props}
  />
}

export {
  Dialog,
  DialogPortal,
  DialogOverlay,
  DialogClose,
  DialogTrigger,
  DialogContent,
  DialogHeader,
  DialogFooter,
  DialogTitle,
  DialogDescription,
}
