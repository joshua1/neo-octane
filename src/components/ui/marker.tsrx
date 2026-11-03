import type { ClassValue } from "clsx"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { cva, type VariantProps } from "class-variance-authority"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type SpanProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

const markerVariants = cva(
  "group/marker relative flex min-h-4 w-full items-center gap-2 text-left text-sm font-base text-foreground [&_svg:not([class*='size-'])]:size-4 [a]:underline [a]:underline-offset-3 [a]:hover:text-foreground",
  {
    variants: {
      variant: {
        default: "",
        separator:
          "before:mr-0 before:h-0.5 before:min-w-0 before:flex-1 before:bg-border after:ml-0 after:h-0.5 after:min-w-0 after:flex-1 after:bg-border",
        border: "border-b-2 border-border pb-2",
      },
    },
  },
)

function Marker({
  class: klass,
  className,
  variant = "default",
  render,
  ...props
}: Omit<useRender.ComponentProps<"div">, "className"> &
  ClassProps &
  VariantProps<typeof markerVariants>) {
  return useRender({
    defaultTagName: "div",
    props: mergeProps<"div">(
      {
        className: cn(markerVariants({ variant }), className, klass),
      },
      props,
    ) as Record<string, unknown>,
    // Binding typing gap: useRender.ComponentProps types `render` against HTMLProps while
    // useRender.Parameters expects HTMLAttributes (style string vs object); runtime is identical.
    render: render as any,
    state: {
      slot: "marker",
      variant,
    },
  })
}

function MarkerIcon({ class: klass, className, ...props }: SpanProps) @{
  <span
    data-slot="marker-icon"
    aria-hidden="true"
    class={cn(
      "size-4 shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    {...props}
  />
}

function MarkerContent({ class: klass, className, ...props }: SpanProps) @{
  <span
    data-slot="marker-content"
    class={cn(
      "min-w-0 wrap-break-word group-data-[variant=separator]/marker:flex-none group-data-[variant=separator]/marker:text-center *:[a]:underline *:[a]:underline-offset-3 *:[a]:hover:text-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

export { Marker, MarkerIcon, MarkerContent, markerVariants }
