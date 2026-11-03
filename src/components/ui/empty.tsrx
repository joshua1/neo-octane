import type { ClassValue } from "clsx"
import { cva, type VariantProps } from "class-variance-authority"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function Empty({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="empty"
    class={cn(
      "flex w-full min-w-0 flex-1 flex-col items-center justify-center gap-4 rounded-base border-2 border-dashed border-border bg-background p-6 text-center font-base md:p-12 text-foreground text-balance",
      className,
      klass,
    )}
    {...props}
  />
}

function EmptyHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="empty-header"
    class={cn("flex max-w-sm flex-col items-center gap-2", className, klass)}
    {...props}
  />
}

const emptyMediaVariants = cva(
  "mb-2 flex shrink-0 items-center justify-center [&_svg]:pointer-events-none [&_svg]:shrink-0",
  {
    variants: {
      variant: {
        default: "bg-transparent",
        icon: "flex size-10 shrink-0 items-center justify-center rounded-base border-2 border-border bg-secondary-background text-foreground [&_svg:not([class*='size-'])]:size-5",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  },
)

function EmptyMedia({
  class: klass,
  className,
  variant = "default",
  ...props
}: DivProps & VariantProps<typeof emptyMediaVariants>) @{
  <div
    data-slot="empty-icon"
    data-variant={variant}
    class={cn(emptyMediaVariants({ variant }), className, klass)}
    {...props}
  />
}

function EmptyTitle({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="empty-title"
    class={cn("font-heading text-sm tracking-tight", className, klass)}
    {...props}
  />
}

function EmptyDescription({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="empty-description"
    class={cn(
      "text-sm/relaxed font-base text-foreground [&>a]:underline [&>a]:underline-offset-4 [&>a:hover]:text-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

function EmptyContent({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="empty-content"
    class={cn(
      "flex w-full max-w-sm min-w-0 flex-col items-center gap-2.5 text-sm text-balance",
      className,
      klass,
    )}
    {...props}
  />
}

export {
  Empty,
  EmptyHeader,
  EmptyTitle,
  EmptyDescription,
  EmptyContent,
  EmptyMedia,
}
