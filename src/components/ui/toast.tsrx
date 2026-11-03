import type { ClassValue } from "clsx"
import { type OctaneNode } from "octane"
import { Toast as ToastPrimitive } from "@octanejs/base-ui/toast"
import {
  CircleCheckIcon,
  InfoIcon,
  Loader2Icon,
  OctagonXIcon,
  TriangleAlertIcon,
  XIcon,
} from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type PartProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

const toast = ToastPrimitive.createToastManager()

function ToastProvider(props: ToastPrimitive.Provider.Props) @{
  <ToastPrimitive.Provider {...props} />
}

function ToastPortal({ class: klass, className, ...props }: PartProps) @{
  <ToastPrimitive.Portal
    data-slot="toast-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function ToastViewport({ class: klass, className, ...props }: PartProps) @{
  <ToastPrimitive.Viewport
    data-slot="toast-viewport"
    className={cn(
      "pointer-events-none fixed inset-x-4 bottom-4 z-50 mx-auto w-auto max-w-sm outline-none sm:right-4 sm:left-auto sm:mx-0 sm:w-full",
      className,
      klass,
    )}
    {...props}
  />
}

function Toast({
  class: klass,
  className,
  ...props
}: PartProps & { toast: ToastPrimitive.Root.Props["toast"] }) @{
  <ToastPrimitive.Root
    data-slot="toast"
    className={cn(
      "group/toast pointer-events-auto absolute right-0 bottom-0 z-[calc(1000-var(--toast-index))] w-full origin-bottom rounded-base border-2 border-border bg-background text-foreground will-change-transform outline-none select-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2",
      "[--gap:0.75rem] [--height:var(--toast-frontmost-height,var(--toast-height))] [--offset-y:calc(var(--toast-offset-y)*-1+calc(var(--toast-index)*var(--gap)*-1)+var(--toast-swipe-movement-y))] [--peek:0.75rem] [--scale:calc(max(0,1-(var(--toast-index)*0.1)))] [--shrink:calc(1-var(--scale))]",
      "h-(--height) [transform:translateX(var(--toast-swipe-movement-x))_translateY(calc(var(--toast-swipe-movement-y)-(var(--toast-index)*var(--peek))-(var(--shrink)*var(--height))))_scale(var(--scale))] [transition:transform_500ms_cubic-bezier(0.22,1,0.36,1),opacity_500ms,height_150ms]",
      "after:absolute after:top-full after:left-0 after:h-[calc(var(--gap)+1px)] after:w-full after:content-['']",
      "data-expanded:h-(--toast-height) data-expanded:[transform:translateX(var(--toast-swipe-movement-x))_translateY(var(--offset-y))]",
      "data-limited:opacity-0 data-starting-style:[transform:translateY(150%)]",
      "[&[data-ending-style]:not([data-limited]):not([data-swipe-direction])]:[transform:translateY(150%)]",
      "data-ending-style:data-[swipe-direction=down]:[transform:translateY(calc(var(--toast-swipe-movement-y)+150%))]",
      "data-ending-style:data-[swipe-direction=left]:[transform:translateX(calc(var(--toast-swipe-movement-x)-150%))_translateY(var(--offset-y))]",
      "data-ending-style:data-[swipe-direction=right]:[transform:translateX(calc(var(--toast-swipe-movement-x)+150%))_translateY(var(--offset-y))]",
      "data-ending-style:data-[swipe-direction=up]:[transform:translateY(calc(var(--toast-swipe-movement-y)-150%))]",
      "data-expanded:data-ending-style:data-[swipe-direction=down]:[transform:translateY(calc(var(--toast-swipe-movement-y)+150%))]",
      "data-expanded:data-ending-style:data-[swipe-direction=left]:[transform:translateX(calc(var(--toast-swipe-movement-x)-150%))_translateY(var(--offset-y))]",
      "data-expanded:data-ending-style:data-[swipe-direction=right]:[transform:translateX(calc(var(--toast-swipe-movement-x)+150%))_translateY(var(--offset-y))]",
      "data-expanded:data-ending-style:data-[swipe-direction=up]:[transform:translateY(calc(var(--toast-swipe-movement-y)-150%))]",
      className,
      klass,
    )}
    {...props}
  />
}

function ToastContent({ class: klass, className, ...props }: PartProps) @{
  <ToastPrimitive.Content
    data-slot="toast-content"
    className={cn(
      "flex h-full items-center gap-3 overflow-hidden px-4 py-3 transition-opacity duration-250 ease-[cubic-bezier(0.22,1,0.36,1)] data-behind:opacity-0 data-expanded:opacity-100",
      className,
      klass,
    )}
    {...props}
  />
}

function ToastTitle({ class: klass, className, ...props }: PartProps) @{
  <ToastPrimitive.Title
    data-slot="toast-title"
    className={cn("text-sm font-heading", className, klass)}
    {...props}
  />
}

function ToastDescription({ class: klass, className, ...props }: PartProps) @{
  <ToastPrimitive.Description
    data-slot="toast-description"
    className={cn("text-sm font-base text-foreground", className, klass)}
    {...props}
  />
}

// JSX in a destructuring default isn't compiled by the .tsrx compiler, so the
// default render element is applied in the body instead.
function ToastAction({
  class: klass,
  className,
  render: renderProp,
  ...props
}: PartProps) @{
  const render = renderProp ?? (
    <Button
      variant="noShadow"
      size="sm"
      class="bg-secondary-background text-foreground"
    />
  )
  <ToastPrimitive.Action
    data-slot="toast-action"
    render={render}
    className={cn("shrink-0", className, klass)}
    {...props}
  />
}

function ToastClose({
  class: klass,
  className,
  children,
  render: renderProp,
  ...props
}: PartProps) @{
  const render = renderProp ?? (
    <Button
      variant="neutral"
      size="icon"
      class="size-7 border-0 bg-transparent shadow-none! hover:translate-x-0! hover:translate-y-0!"
    />
  )
  <ToastPrimitive.Close
    data-slot="toast-close"
    aria-label="Close toast"
    render={render}
    className={cn(
      "relative shrink-0 text-foreground after:absolute after:-inset-2 after:content-[''] hover:opacity-70",
      className,
      klass,
    )}
    {...props}
  >
    @if (children != null) {
      {
        children
      }
    } @else {
      <XIcon aria-hidden="true" />
    }
  </ToastPrimitive.Close>
}

function ToastIcon({ type }: { type: string | undefined }) @{
  let icon: OctaneNode = null

  if (type === "success") {
    icon = <CircleCheckIcon aria-hidden="true" />
  }

  if (type === "info") {
    icon = <InfoIcon aria-hidden="true" />
  }

  if (type === "warning") {
    icon = <TriangleAlertIcon aria-hidden="true" />
  }

  if (type === "error") {
    icon = <OctagonXIcon class="text-black" aria-hidden="true" />
  }

  if (type === "loading") {
    icon = <Loader2Icon class="animate-spin" aria-hidden="true" />
  }

  @if (icon) {
    <span
      data-slot="toast-icon"
      class="shrink-0 [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4"
    >
      {icon}
    </span>
  }
}

function ToastList() @{
  const { toasts } = ToastPrimitive.useToastManager()

  <>
    @for (const toastItem of toasts; key toastItem.id) {
      <Toast toast={toastItem}>
        <ToastContent>
          <ToastIcon type={toastItem.type} />
          <div class="flex min-w-0 flex-1 flex-col gap-1">
            <ToastTitle />
            <ToastDescription />
          </div>
          <ToastAction />
          <ToastClose />
        </ToastContent>
      </Toast>
    }
  </>
}

function Toaster({
  children,
  toastManager = toast,
  ...props
}: ToastPrimitive.Provider.Props) @{
  <ToastProvider toastManager={toastManager} {...props}>
    {children}
    <ToastPortal>
      <ToastViewport>
        <ToastList />
      </ToastViewport>
    </ToastPortal>
  </ToastProvider>
}

const createToastManager = ToastPrimitive.createToastManager
const useToastManager = ToastPrimitive.useToastManager

export {
  Toaster,
  Toast,
  ToastAction,
  ToastClose,
  ToastContent,
  ToastDescription,
  ToastPortal,
  ToastProvider,
  ToastTitle,
  ToastViewport,
  createToastManager,
  toast,
  useToastManager,
}
