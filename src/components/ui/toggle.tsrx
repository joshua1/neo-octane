import type { ClassValue } from "clsx"
import { Toggle as TogglePrimitive } from "@octanejs/base-ui/toggle"
import { cva, type VariantProps } from "class-variance-authority"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

const toggleVariants = cva(
  "group/toggle inline-flex items-center justify-center gap-1 rounded-base border-2 border-border text-sm font-heading whitespace-nowrap transition-all outline-none ring-offset-white focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 data-disabled:pointer-events-none data-disabled:opacity-50 aria-pressed:bg-main aria-pressed:text-main-foreground data-pressed:bg-main data-pressed:text-main-foreground [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
  {
    variants: {
      variant: {
        default: "bg-secondary-background text-foreground",
        outline: "bg-secondary-background text-foreground",
      },
      size: {
        default:
          "h-10 min-w-10 px-3 has-data-[icon=inline-end]:pr-2 has-data-[icon=inline-start]:pl-2",
        sm: "h-9 min-w-9 px-2.5 text-[0.8rem] has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3.5",
        lg: "h-11 min-w-11 px-4 has-data-[icon=inline-end]:pr-2.5 has-data-[icon=inline-start]:pl-2.5",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  },
)

function Toggle({
  class: klass,
  className,
  variant = "default",
  size = "default",
  ...props
}: StyledProps<TogglePrimitive.Props> & VariantProps<typeof toggleVariants>) @{
  <TogglePrimitive
    data-slot="toggle"
    className={cn(toggleVariants({ variant, size }), className, klass)}
    {...props}
  />
}

export { Toggle, toggleVariants }
