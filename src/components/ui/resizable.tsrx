import type { ClassValue } from "clsx"
import { GripVertical } from "@octanejs/lucide"
import * as ResizablePrimitive from "@octanejs/resizable-panels"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function ResizablePanelGroup({
  class: klass,
  className,
  ...props
}: StyledProps<ResizablePrimitive.GroupProps>) @{
  <ResizablePrimitive.Group
    data-slot="resizable-panel-group"
    className={cn(
      "flex h-full w-full font-base aria-[orientation=vertical]:flex-col",
      className,
      klass,
    )}
    {...props}
  />
}

function ResizablePanel({
  class: klass,
  className,
  ...props
}: StyledProps<ResizablePrimitive.PanelProps>) @{
  <ResizablePrimitive.Panel
    data-slot="resizable-panel"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function ResizableHandle({
  withHandle,
  class: klass,
  className,
  ...props
}: StyledProps<ResizablePrimitive.SeparatorProps> & {
  withHandle?: boolean
}) @{
  <ResizablePrimitive.Separator
    data-slot="resizable-handle"
    className={cn(
      "relative flex w-0.5 items-center justify-center bg-border after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2 focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-black focus-visible:ring-offset-1 aria-[orientation=horizontal]:h-0.5 aria-[orientation=horizontal]:w-full aria-[orientation=horizontal]:after:left-0 aria-[orientation=horizontal]:after:h-1 aria-[orientation=horizontal]:after:w-full aria-[orientation=horizontal]:after:-translate-y-1/2 aria-[orientation=horizontal]:after:translate-x-0 [&[aria-orientation=horizontal]>div]:rotate-90",
      className,
      klass,
    )}
    {...props}
  >
    @if (withHandle) {
      <div class="z-10 flex h-4 w-3 items-center justify-center rounded-base border bg-border">
        <GripVertical class="size-2.5" />
      </div>
    }
  </ResizablePrimitive.Separator>
}

export { ResizablePanelGroup, ResizablePanel, ResizableHandle }
