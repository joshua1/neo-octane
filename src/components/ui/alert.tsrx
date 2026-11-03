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

const alertVariants = cva(
  "relative w-full rounded-base border-2 border-border px-4 py-3 text-sm grid has-[>svg]:grid-cols-[calc(var(--spacing)*4)_1fr] grid-cols-[0_1fr] has-[>svg]:gap-x-3 gap-y-0.5 items-start [&>svg]:size-4 [&>svg]:translate-y-0.5 [&>svg]:text-current shadow-shadow",
  {
    variants: {
      variant: {
        default: "bg-background text-foreground",
        destructive: "bg-black text-white",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  },
)

function Alert({
  class: klass,
  className,
  variant,
  ...props
}: DivProps & VariantProps<typeof alertVariants>) @{
  <div
    data-slot="alert"
    role="alert"
    class={cn(alertVariants({ variant }), className, klass)}
    {...props}
  />
}

function AlertTitle({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="alert-title"
    class={cn(
      "col-start-2 line-clamp-1 min-h-4 font-heading tracking-tight",
      className,
      klass,
    )}
    {...props}
  />
}

function AlertDescription({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="alert-description"
    class={cn(
      "col-start-2 grid justify-items-start gap-1 text-sm font-base [&_p]:leading-relaxed",
      className,
      klass,
    )}
    {...props}
  />
}

export { Alert, AlertTitle, AlertDescription }
