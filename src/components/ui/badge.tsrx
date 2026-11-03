import type { ClassValue } from "clsx"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

const badgeVariants = cva(
  "inline-flex items-center justify-center rounded-base border-2 border-border px-2.5 py-0.5 text-xs font-base w-fit whitespace-nowrap shrink-0 [&>svg]:size-3 gap-1 [&>svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] overflow-hidden",
  {
    variants: {
      variant: {
        default: "bg-background text-foreground",
        neutral: "bg-secondary-background text-foreground",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  },
)

function Badge({
  class: klass,
  className,
  variant,
  render,
  ...props
}: useRender.ComponentProps<"span"> &
  ClassProps &
  VariantProps<typeof badgeVariants>) {
  return useRender({
    defaultTagName: "span",
    // Binding typing gap: useRender.ComponentProps types `render` against HTMLProps while
    // useRender.Parameters expects HTMLAttributes (style string vs object); runtime is identical.
    render: render as any,
    props: mergeProps<"span">(
      {
        className: cn(badgeVariants({ variant }), className, klass),
      },
      props,
    ) as Record<string, unknown>,
    state: {
      slot: "badge",
      variant: variant ?? "default",
    },
  })
}

export { Badge, badgeVariants }
