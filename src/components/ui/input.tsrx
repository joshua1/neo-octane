import type { ClassValue } from "clsx"
import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type InputProps = Record<string, any> & ClassProps & { type?: string }

// Plain native <input>. Events are native: use
// `onInput` for per-keystroke updates (`onChange` fires on commit/blur).
function Input({ class: klass, className, type, ...props }: InputProps) @{
  <input
    type={type}
    data-slot="input"
    class={cn(
      "flex h-10 w-full rounded-base border-2 border-border bg-secondary-background selection:bg-main selection:text-main-foreground px-3 py-2 text-sm font-base text-foreground file:border-0 file:bg-transparent file:text-sm file:font-heading placeholder:text-foreground/50 focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50",
      className,
      klass,
    )}
    {...props}
  />
}

export { Input }
