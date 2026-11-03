import type { ClassValue } from "clsx"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

const buttonGroupVariants = cva(
  "flex w-fit items-stretch rounded-base *:shadow-none! *:hover:translate-x-0! *:hover:translate-y-0! *:focus-visible:relative *:focus-visible:z-10 has-[>[data-slot=button-group]]:gap-2 has-[select[aria-hidden=true]:last-child]:[&>[data-slot=select-trigger]:last-of-type]:rounded-r-base [&>[data-slot=select-trigger]:not([class*='w-'])]:w-fit [&>input]:flex-1",
  {
    variants: {
      orientation: {
        horizontal:
          "*:data-slot:rounded-r-none [&>[data-slot]:not(:has(~[data-slot]))]:rounded-r-base! [&>[data-slot]~[data-slot]]:rounded-l-none [&>[data-slot]~[data-slot]]:border-l-0",
        vertical:
          "flex-col *:data-slot:rounded-b-none [&>[data-slot]:not(:has(~[data-slot]))]:rounded-b-base! [&>[data-slot]~[data-slot]]:rounded-t-none [&>[data-slot]~[data-slot]]:border-t-0",
      },
    },
    defaultVariants: {
      orientation: "horizontal",
    },
  },
)

type DivProps = Record<string, any> & ClassProps

function ButtonGroup({
  class: klass,
  className,
  orientation,
  ...props
}: DivProps & VariantProps<typeof buttonGroupVariants>) @{
  <div
    role="group"
    data-slot="button-group"
    data-orientation={orientation}
    class={cn(buttonGroupVariants({ orientation }), className, klass)}
    {...props}
  />
}

function ButtonGroupText({
  class: klass,
  className,
  render,
  ...props
}: useRender.ComponentProps<"div"> & ClassProps) {
  return useRender({
    defaultTagName: "div",
    props: mergeProps<"div">(
      {
        className: cn(
          "flex items-center gap-2 rounded-base border-2 border-border bg-secondary-background px-2.5 text-sm font-heading text-foreground [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4",
          className,
          klass,
        ),
      },
      props,
      // The binding types `mergeProps` output as the precise host props while
      // `useRender` takes `Record<string, unknown>`; same object at runtime.
    ) as Record<string, unknown>,
    // Binding typing gap: `useRender.ComponentProps` types `render` against
    // `HTMLProps` while `useRender` expects `HTMLAttributes`.
    render: render as useRender.RenderProp<{ slot: string }> | undefined,
    state: {
      slot: "button-group-text",
    },
  })
}

function ButtonGroupSeparator({
  class: klass,
  className,
  orientation = "vertical",
  ...props
}: DivProps & {
  orientation?: "horizontal" | "vertical"
}) @{
  <div
    role="separator"
    aria-orientation={orientation}
    data-slot="button-group-separator"
    data-orientation={orientation}
    class={cn(
      "relative shrink-0 self-stretch border-border data-[orientation=horizontal]:my-px data-[orientation=horizontal]:w-full data-[orientation=horizontal]:border-t-2 data-[orientation=vertical]:mx-px data-[orientation=vertical]:border-l-2",
      className,
      klass,
    )}
    {...props}
  />
}

export {
  ButtonGroup,
  ButtonGroupSeparator,
  ButtonGroupText,
  buttonGroupVariants,
}
