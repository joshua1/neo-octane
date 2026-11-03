import type { ClassValue } from "clsx"
import { createContext, useContext, useMemo, type OctaneNode } from "octane"
import { Drawer as DrawerPrimitive } from "@octanejs/base-ui/drawer"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type PartProps = Record<string, any> & ClassProps

type DrawerContextProps = {
  hasSnapPoints: boolean
  modal: DrawerPrimitive.Root.Props["modal"]
  showSwipeHandle: boolean
  swipeDirection: NonNullable<DrawerPrimitive.Root.Props["swipeDirection"]>
}

const DrawerContext = createContext<DrawerContextProps | null>(null)

function useDrawer() {
  const context = useContext(DrawerContext)

  if (!context) {
    throw new Error("useDrawer must be used within a Drawer.")
  }

  return context
}

type DrawerProps = DrawerPrimitive.Root.Props & {
  showSwipeHandle?: boolean
}

function Drawer({
  modal = true,
  snapPoints,
  swipeDirection = "down",
  showSwipeHandle = swipeDirection === "down",
  ...props
}: DrawerProps) @{
  const hasSnapPoints = snapPoints != null && snapPoints.length > 0
  const contextValue = useMemo(
    () => ({ hasSnapPoints, modal, showSwipeHandle, swipeDirection }),
    [hasSnapPoints, modal, showSwipeHandle, swipeDirection],
  )

  <DrawerContext value={contextValue}>
    <DrawerPrimitive.Root
      data-slot="drawer"
      modal={modal}
      snapPoints={snapPoints}
      swipeDirection={swipeDirection}
      {...props}
    />
  </DrawerContext>
}

function DrawerTrigger({ class: klass, className, ...props }: PartProps) @{
  <DrawerPrimitive.Trigger
    data-slot="drawer-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DrawerPortal({ class: klass, className, ...props }: PartProps) @{
  <DrawerPrimitive.Portal
    data-slot="drawer-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DrawerClose({ class: klass, className, ...props }: PartProps) @{
  <DrawerPrimitive.Close
    data-slot="drawer-close"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DrawerOverlay({ class: klass, className, ...props }: PartProps) @{
  <DrawerPrimitive.Backdrop
    data-slot="drawer-overlay"
    className={cn(
      "fixed inset-0 z-50 min-h-dvh bg-overlay opacity-[max(var(--drawer-overlay-min-opacity,0),calc(1-var(--drawer-swipe-progress)))] transition-opacity duration-450 ease-[cubic-bezier(0.32,0.72,0,1)] select-none data-ending-style:pointer-events-none data-ending-style:opacity-0 data-ending-style:duration-[calc(var(--drawer-swipe-strength)*400ms)] data-snap-points:[--drawer-overlay-min-opacity:0.5] data-starting-style:opacity-0 data-swiping:duration-0 supports-[-webkit-touch-callout:none]:absolute",
      className,
      klass,
    )}
    {...props}
  />
}

function DrawerSwipeHandle({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="drawer-swipe-handle"
    aria-hidden="true"
    class={cn(
      "relative z-10 flex shrink-0 cursor-grab transition-opacity duration-200 group-data-nested-drawer-open/drawer-popup:opacity-0 group-data-nested-drawer-swiping/drawer-popup:opacity-100 group-data-[swipe-axis=x]/drawer-popup:h-full group-data-[swipe-axis=x]/drawer-popup:w-4 group-data-[swipe-axis=x]/drawer-popup:items-center group-data-[swipe-axis=y]/drawer-popup:h-4 group-data-[swipe-axis=y]/drawer-popup:w-full group-data-[swipe-axis=y]/drawer-popup:justify-center group-data-[swipe-direction=down]/drawer-popup:items-end group-data-[swipe-direction=left]/drawer-popup:order-last group-data-[swipe-direction=left]/drawer-popup:justify-start group-data-[swipe-direction=right]/drawer-popup:justify-end group-data-[swipe-direction=up]/drawer-popup:order-last group-data-[swipe-direction=up]/drawer-popup:items-start after:block after:shrink-0 after:rounded-full after:bg-current group-data-[swipe-axis=x]/drawer-popup:after:h-[100px] group-data-[swipe-axis=x]/drawer-popup:after:w-2 group-data-[swipe-axis=y]/drawer-popup:after:h-2 group-data-[swipe-axis=y]/drawer-popup:after:w-[100px] active:cursor-grabbing",
      className,
      klass,
    )}
    {...props}
  />
}

type DrawerContentProps = PartProps & { children?: OctaneNode }

function DrawerContent({
  class: klass,
  className,
  children,
  ...props
}: DrawerContentProps) @{
  const { hasSnapPoints, modal, showSwipeHandle, swipeDirection } = useDrawer()
  const swipeAxis =
    swipeDirection === "down" || swipeDirection === "up" ? "y" : "x"

  <DrawerPortal>
    @if (modal === true) {
      <DrawerOverlay data-snap-points={hasSnapPoints ? "" : undefined} />
    }
    <DrawerPrimitive.Viewport
      data-slot="drawer-viewport"
      data-modal={modal}
      className="pointer-events-none fixed inset-0 z-50 select-none data-[modal=true]:pointer-events-auto"
    >
      <DrawerPrimitive.Popup
        data-slot="drawer-popup"
        data-swipe-axis={swipeAxis}
        data-snap-points={hasSnapPoints ? "" : undefined}
        className={cn(
          // Base.
          "group/drawer-popup pointer-events-auto fixed z-50 m-(--drawer-inset,0px) flex h-(--drawer-content-height) max-h-(--drawer-content-max-height,none) min-h-0 w-(--drawer-content-width,auto) transform-[translate3d(var(--translate-x,0px),var(--translate-y,0px),0)_scale(var(--stack-scale))] flex-col bg-background text-foreground border-border transition-[transform,height,opacity,filter] duration-450 ease-[cubic-bezier(0.22,1,0.36,1)] will-change-transform outline-none select-none [interpolate-size:allow-keywords] data-[swipe-direction=down]:rounded-t-base data-[swipe-direction=down]:border-t-2 data-[swipe-direction=left]:rounded-r-base data-[swipe-direction=left]:border-r-2 data-[swipe-direction=right]:rounded-l-base data-[swipe-direction=right]:border-l-2 data-[swipe-direction=up]:rounded-b-base data-[swipe-direction=up]:border-b-2",
          // Nested.
          "data-nested-drawer-open:overflow-hidden data-nested-drawer-open:brightness-95",
          // Bleed.
          "after:pointer-events-none after:absolute after:bg-(--drawer-bleed-background,var(--color-background)) data-[swipe-axis=x]:after:inset-y-0 data-[swipe-axis=x]:after:w-(--bleed) data-[swipe-axis=y]:after:inset-x-0 data-[swipe-axis=y]:after:h-(--bleed) data-[swipe-direction=down]:after:top-full data-[swipe-direction=left]:after:right-full data-[swipe-direction=right]:after:left-full data-[swipe-direction=up]:after:bottom-full",
          // Sizing.
          "[--drawer-content-height:var(--drawer-height,auto)] data-[swipe-axis=x]:[--drawer-content-width:75%] data-[swipe-axis=y]:[--drawer-content-max-height:calc(100dvh-6rem)] data-[swipe-axis=y]:data-snap-points:[--drawer-content-height:100dvh] data-[swipe-axis=x]:sm:[--drawer-content-width:24rem]",
          // Stack.
          "[--bleed:3rem] [--peek:1rem] [--stack-height:var(--drawer-frontmost-height,var(--drawer-height,0px))] [--stack-peek-offset:max(0px,calc((var(--nested-drawers)-var(--stack-progress))*var(--peek)))] [--stack-progress:clamp(0,var(--drawer-swipe-progress),1)] [--stack-scale-base:max(0,calc(1-(var(--nested-drawers)*var(--stack-step))))] [--stack-scale:clamp(0,calc(var(--stack-scale-base)+(var(--stack-step)*var(--stack-progress))),1)] [--stack-shrink:calc(1-var(--stack-scale))] [--stack-step:0.05]",
          // Transitions.
          "data-ending-style:transform-(--closed-transform) data-ending-style:opacity-[0.9999] data-ending-style:duration-[calc(var(--drawer-swipe-strength)*400ms)] data-nested-drawer-swiping:duration-0 data-ending-style:data-nested-drawer-swiping:duration-[calc(var(--drawer-swipe-strength)*400ms)] data-starting-style:transform-(--closed-transform) data-swiping:duration-0 data-ending-style:data-swiping:duration-[calc(var(--drawer-swipe-strength)*400ms)]",
          // Axis: y.
          "data-[swipe-axis=y]:inset-x-0 data-[swipe-axis=y]:data-nested-drawer-open:h-(--stack-height)",
          // Axis: x.
          "data-[swipe-axis=x]:inset-y-0 data-[swipe-axis=x]:flex-row",
          // Direction: down.
          "data-[swipe-direction=down]:bottom-0 data-[swipe-direction=down]:origin-bottom data-[swipe-direction=down]:[--closed-transform:translate3d(0,calc(100%+var(--drawer-inset,0px)+2px),0)] data-[swipe-direction=down]:[--translate-y:calc(var(--drawer-snap-point-offset,0px)+var(--drawer-swipe-movement-y)-var(--stack-peek-offset)-(var(--stack-shrink)*var(--stack-height)))]",
          // Direction: up.
          "data-[swipe-direction=up]:top-0 data-[swipe-direction=up]:origin-top data-[swipe-direction=up]:[--closed-transform:translate3d(0,calc(-100%-var(--drawer-inset,0px)-2px),0)] data-[swipe-direction=up]:[--translate-y:calc(var(--drawer-snap-point-offset,0px)+var(--drawer-swipe-movement-y)+var(--stack-peek-offset)+(var(--stack-shrink)*var(--stack-height)))]",
          // Direction: left.
          "data-[swipe-direction=left]:left-0 data-[swipe-direction=left]:origin-left data-[swipe-direction=left]:[--closed-transform:translate3d(calc(-100%-var(--drawer-inset,0px)-2px),0,0)] data-[swipe-direction=left]:[--translate-x:calc(var(--drawer-swipe-movement-x)+var(--stack-peek-offset)+(var(--stack-shrink)*100%))]",
          // Direction: right.
          "data-[swipe-direction=right]:right-0 data-[swipe-direction=right]:origin-right data-[swipe-direction=right]:[--closed-transform:translate3d(calc(100%+var(--drawer-inset,0px)+2px),0,0)] data-[swipe-direction=right]:[--translate-x:calc(var(--drawer-swipe-movement-x)-var(--stack-peek-offset)-(var(--stack-shrink)*100%))]",
          className,
          klass,
        )}
        {...props}
      >
        @if (showSwipeHandle) {
          <DrawerSwipeHandle />
        }
        <DrawerPrimitive.Content
          data-slot="drawer-content"
          className="flex min-h-0 flex-1 flex-col overflow-hidden overscroll-contain rounded-[inherit] transition-opacity duration-300 ease-[cubic-bezier(0.45,1.005,0,1.005)] select-text group-data-nested-drawer-open/drawer-popup:opacity-0 group-data-nested-drawer-swiping/drawer-popup:opacity-100 group-data-swiping/drawer-popup:select-none"
        >
          {children}
        </DrawerPrimitive.Content>
      </DrawerPrimitive.Popup>
    </DrawerPrimitive.Viewport>
  </DrawerPortal>
}

function DrawerHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="drawer-header"
    class={cn("grid gap-1.5 p-4 text-center sm:text-left", className, klass)}
    {...props}
  />
}

function DrawerFooter({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="drawer-footer"
    class={cn("mt-auto flex flex-col gap-3 p-4", className, klass)}
    {...props}
  />
}

function DrawerTitle({ class: klass, className, ...props }: PartProps) @{
  <DrawerPrimitive.Title
    data-slot="drawer-title"
    className={cn(
      "text-lg font-heading leading-none tracking-tight",
      className,
      klass,
    )}
    {...props}
  />
}

function DrawerDescription({ class: klass, className, ...props }: PartProps) @{
  <DrawerPrimitive.Description
    data-slot="drawer-description"
    className={cn("text-sm font-base text-foreground", className, klass)}
    {...props}
  />
}

export {
  Drawer,
  DrawerPortal,
  DrawerOverlay,
  DrawerSwipeHandle,
  DrawerTrigger,
  DrawerClose,
  DrawerContent,
  DrawerHeader,
  DrawerFooter,
  DrawerTitle,
  DrawerDescription,
}
