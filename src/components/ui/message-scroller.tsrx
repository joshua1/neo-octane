import type { ClassValue } from "clsx"
import { ArrowDownIcon } from "@octanejs/lucide"
import type { ComponentProps } from "octane"
import type { VariantProps } from "class-variance-authority"

import {
  MessageScroller as MessageScrollerPrimitive,
  useMessageScroller,
  useMessageScrollerScrollable,
  useMessageScrollerVisibility,
} from "@/components/primitives/message-scroller/index.ts"
import { Button, type buttonVariants } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function MessageScrollerProvider(
  props: ComponentProps<typeof MessageScrollerPrimitive.Provider>,
) @{
  <MessageScrollerPrimitive.Provider {...props} />
}

function MessageScroller({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof MessageScrollerPrimitive.Root>>) @{
  <MessageScrollerPrimitive.Root
    data-slot="message-scroller"
    class={cn(
      "group/message-scroller relative flex size-full min-h-0 flex-col overflow-hidden",
      className,
      klass,
    )}
    {...props}
  />
}

function MessageScrollerViewport({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof MessageScrollerPrimitive.Viewport>>) @{
  <MessageScrollerPrimitive.Viewport
    data-slot="message-scroller-viewport"
    class={cn(
      "size-full min-h-0 min-w-0 overflow-y-auto overscroll-contain data-pending-scroll:invisible",
      className,
      klass,
    )}
    {...props}
  />
}

function MessageScrollerContent({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof MessageScrollerPrimitive.Content>>) @{
  <MessageScrollerPrimitive.Content
    data-slot="message-scroller-content"
    class={cn("flex h-max min-h-full flex-col gap-6", className, klass)}
    {...props}
  />
}

function MessageScrollerItem({
  class: klass,
  className,
  scrollAnchor = false,
  ...props
}: StyledProps<ComponentProps<typeof MessageScrollerPrimitive.Item>>) @{
  <MessageScrollerPrimitive.Item
    data-slot="message-scroller-item"
    scrollAnchor={scrollAnchor}
    class={cn(
      "min-w-0 shrink-0 [contain-intrinsic-size:auto_10rem] [content-visibility:auto]",
      className,
      klass,
    )}
    {...props}
  />
}

function MessageScrollerButton({
  direction = "end",
  class: klass,
  className,
  children,
  render,
  variant = "neutral",
  size = "icon",
  ...props
}: StyledProps<ComponentProps<typeof MessageScrollerPrimitive.Button>> &
  Pick<VariantProps<typeof buttonVariants>, "variant" | "size">) @{
  <MessageScrollerPrimitive.Button
    data-slot="message-scroller-button"
    data-direction={direction}
    data-variant={variant}
    data-size={size}
    direction={direction}
    className={cn(
      "absolute inset-s-1/2 size-8 rounded-full! -translate-x-1/2 transition-[translate,scale,opacity] duration-200 shadow-none! hover:-translate-x-1/2! hover:translate-y-0! data-[active=false]:pointer-events-none data-[active=false]:scale-95 data-[active=false]:opacity-0 data-[active=false]:duration-400 data-[active=false]:ease-[cubic-bezier(0.7,0,0.84,0)] data-[active=true]:translate-y-0 data-[active=true]:scale-100 data-[active=true]:opacity-100 data-[active=true]:ease-[cubic-bezier(0.23,1,0.32,1)] data-[direction=end]:bottom-4 data-[direction=end]:data-[active=false]:translate-y-full data-[direction=start]:top-4 data-[direction=start]:data-[active=false]:-translate-y-full rtl:translate-x-1/2 rtl:hover:translate-x-1/2 data-[direction=start]:[&_svg]:rotate-180",
      className,
      klass,
    )}
    render={render ?? <Button variant={variant} size={size} />}
    {...props}
  >
    @if (children != null) {
      {
        children
      }
    } @else {
      <>
        <ArrowDownIcon />
        <span class="sr-only">
          {direction === "end" ? "Scroll to end" : "Scroll to start"}
        </span>
      </>
    }
  </MessageScrollerPrimitive.Button>
}

export {
  MessageScrollerProvider,
  MessageScroller,
  MessageScrollerViewport,
  MessageScrollerContent,
  MessageScrollerItem,
  MessageScrollerButton,
  useMessageScroller,
  useMessageScrollerScrollable,
  useMessageScrollerVisibility,
}
