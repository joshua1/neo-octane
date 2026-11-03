import type { ClassValue } from "clsx"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { cva, type VariantProps } from "class-variance-authority"

import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> & ClassProps & { children?: OctaneNode }

function BubbleGroup({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="bubble-group"
    class={cn("flex min-w-0 flex-col gap-2", className, klass)}
    {...props}
  />
}

const bubbleVariants = cva(
  "group/bubble relative flex w-fit max-w-[80%] min-w-0 flex-col gap-1 group-data-[align=end]/message:self-end data-[align=end]:self-end",
  {
    variants: {
      variant: {
        default:
          "*:data-[slot=bubble-content]:bg-main *:data-[slot=bubble-content]:text-main-foreground [&>[data-slot=bubble-content]:is(button,a):hover]:bg-main/80",
        secondary:
          "*:data-[slot=bubble-content]:bg-secondary-background *:data-[slot=bubble-content]:text-foreground [&>[data-slot=bubble-content]:is(button,a):hover]:bg-background",
        muted:
          "*:data-[slot=bubble-content]:bg-background *:data-[slot=bubble-content]:text-foreground [&>[data-slot=bubble-content]:is(button,a):hover]:bg-secondary-background",
        destructive:
          "*:data-[slot=bubble-content]:bg-black *:data-[slot=bubble-content]:text-white [&>[data-slot=bubble-content]:is(button,a):hover]:bg-black/80",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  },
)

function Bubble({
  variant = "default",
  align = "start",
  class: klass,
  className,
  ...props
}: DivProps &
  VariantProps<typeof bubbleVariants> & {
    align?: "start" | "end"
  }) @{
  <div
    data-slot="bubble"
    data-variant={variant}
    data-align={align}
    class={cn(bubbleVariants({ variant }), className, klass)}
    {...props}
  />
}

function BubbleContent({
  class: klass,
  className,
  render,
  ...props
}: useRender.ComponentProps<"div"> & ClassProps) {
  // Casts: @octanejs/base-ui types mergeProps() as PropsOf<T> (no index signature) and
  // useRender.ComponentProps["render"] with HTMLProps, neither of which matches useRender's params.
  return useRender({
    defaultTagName: "div",
    props: mergeProps<"div">(
      {
        className: cn(
          "w-fit max-w-full min-w-0 overflow-hidden rounded-base border-2 border-border px-3 py-2.5 text-sm font-base leading-5 wrap-break-word group-data-[align=end]/bubble:self-end [button]:text-left [button,a]:transition-colors [button,a]:outline-none [button,a]:focus-visible:ring-2 [button,a]:focus-visible:ring-black [button,a]:focus-visible:ring-offset-2",
          className,
          klass,
        ),
      },
      props,
    ) as Record<string, unknown>,
    render: render as useRender.RenderProp<any>,
    state: {
      slot: "bubble-content",
    },
  })
}

const bubbleReactionsVariants = cva(
  "absolute z-10 flex w-fit shrink-0 items-center justify-center gap-1 rounded-full border-2 border-border bg-secondary-background px-1.5 py-0.5 text-sm font-base text-foreground has-[button]:p-0",
  {
    variants: {
      side: {
        top: "top-0 -translate-y-3/4",
        bottom: "bottom-0 translate-y-3/4",
      },
      align: {
        start: "left-3",
        end: "right-3",
      },
    },
    defaultVariants: {
      side: "bottom",
      align: "end",
    },
  },
)

function BubbleReactions({
  side = "bottom",
  align = "end",
  class: klass,
  className,
  ...props
}: DivProps & {
  align?: "start" | "end"
  side?: "top" | "bottom"
}) @{
  <div
    data-slot="bubble-reactions"
    data-align={align}
    data-side={side}
    class={cn(bubbleReactionsVariants({ side, align }), className, klass)}
    {...props}
  />
}

export { BubbleGroup, Bubble, BubbleContent, BubbleReactions }
