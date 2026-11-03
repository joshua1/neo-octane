import type { ClassValue } from "clsx"
import { type OctaneNode } from "octane"
import { AlertDialog as AlertDialogPrimitive } from "@octanejs/base-ui/alert-dialog"
import { type VariantProps } from "class-variance-authority"

import { buttonVariants } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type PartProps = Record<string, any> & ClassProps

function AlertDialog(props: AlertDialogPrimitive.Root.Props) @{
  <AlertDialogPrimitive.Root data-slot="alert-dialog" {...props} />
}

function AlertDialogTrigger({ class: klass, className, ...props }: PartProps) @{
  <AlertDialogPrimitive.Trigger
    data-slot="alert-dialog-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function AlertDialogPortal({ class: klass, className, ...props }: PartProps) @{
  <AlertDialogPrimitive.Portal
    data-slot="alert-dialog-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function AlertDialogOverlay({ class: klass, className, ...props }: PartProps) @{
  <AlertDialogPrimitive.Backdrop
    data-slot="alert-dialog-overlay"
    className={cn(
      "fixed inset-0 z-50 bg-overlay duration-200 fill-mode-forwards data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0",
      className,
      klass,
    )}
    {...props}
  />
}

type AlertDialogContentProps = PartProps & {
  children?: OctaneNode
  size?: "default" | "sm"
}

function AlertDialogContent({
  class: klass,
  className,
  size = "default",
  ...props
}: AlertDialogContentProps) @{
  <AlertDialogPortal>
    <AlertDialogOverlay />
    <AlertDialogPrimitive.Popup
      data-slot="alert-dialog-content"
      data-size={size}
      className={cn(
        "group/alert-dialog-content bg-background data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] translate-x-[-50%] translate-y-[-50%] gap-4 rounded-base border-2 border-border p-6 shadow-shadow duration-200 outline-none sm:max-w-lg sm:data-[size=sm]:max-w-sm",
        className,
        klass,
      )}
      {...props}
    />
  </AlertDialogPortal>
}

function AlertDialogHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="alert-dialog-header"
    class={cn(
      "flex flex-col gap-2 text-center sm:text-left group-data-[size=sm]/alert-dialog-content:text-center",
      className,
      klass,
    )}
    {...props}
  />
}

function AlertDialogFooter({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="alert-dialog-footer"
    class={cn(
      "flex flex-col-reverse gap-3 sm:flex-row sm:justify-end group-data-[size=sm]/alert-dialog-content:grid group-data-[size=sm]/alert-dialog-content:grid-cols-2",
      className,
      klass,
    )}
    {...props}
  />
}

function AlertDialogMedia({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="alert-dialog-media"
    class={cn(
      "mb-2 flex size-12 shrink-0 items-center justify-center self-center rounded-base border-2 border-border bg-main text-main-foreground [&_svg]:size-6 sm:size-10 sm:self-start sm:[&_svg]:size-5 group-data-[size=sm]/alert-dialog-content:self-center",
      className,
      klass,
    )}
    {...props}
  />
}

function AlertDialogTitle({ class: klass, className, ...props }: PartProps) @{
  <AlertDialogPrimitive.Title
    data-slot="alert-dialog-title"
    className={cn("text-lg font-heading", className, klass)}
    {...props}
  />
}

function AlertDialogDescription({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <AlertDialogPrimitive.Description
    data-slot="alert-dialog-description"
    className={cn("text-sm font-base text-foreground", className, klass)}
    {...props}
  />
}

type AlertDialogButtonProps = PartProps & VariantProps<typeof buttonVariants>

function AlertDialogAction({
  class: klass,
  className,
  variant = "default",
  size = "default",
  ...props
}: AlertDialogButtonProps) @{
  <AlertDialogPrimitive.Close
    data-slot="alert-dialog-action"
    className={cn(buttonVariants({ variant, size }), className, klass)}
    {...props}
  />
}

function AlertDialogCancel({
  class: klass,
  className,
  variant = "neutral",
  size = "default",
  ...props
}: AlertDialogButtonProps) @{
  <AlertDialogPrimitive.Close
    data-slot="alert-dialog-cancel"
    className={cn(buttonVariants({ variant, size }), className, klass)}
    {...props}
  />
}

export {
  AlertDialog,
  AlertDialogPortal,
  AlertDialogOverlay,
  AlertDialogTrigger,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogFooter,
  AlertDialogMedia,
  AlertDialogTitle,
  AlertDialogDescription,
  AlertDialogAction,
  AlertDialogCancel,
}
