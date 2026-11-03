import type { ClassValue } from "clsx"
import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type KbdProps = Record<string, any> & ClassProps

function Kbd({ class: klass, className, ...props }: KbdProps) @{
  <kbd
    data-slot="kbd"
    class={cn(
      "pointer-events-none inline-flex h-5 w-fit min-w-5 items-center justify-center gap-1 rounded-base border-2 border-border bg-secondary-background px-1 font-sans text-xs font-heading text-foreground select-none in-data-[slot=tooltip-content]:border-main-foreground/30 in-data-[slot=tooltip-content]:bg-main in-data-[slot=tooltip-content]:text-main-foreground [&_svg:not([class*='size-'])]:size-3",
      className,
      klass,
    )}
    {...props}
  />
}

function KbdGroup({ class: klass, className, ...props }: KbdProps) @{
  <kbd
    data-slot="kbd-group"
    class={cn("inline-flex items-center gap-1", className, klass)}
    {...props}
  />
}

export { Kbd, KbdGroup }
