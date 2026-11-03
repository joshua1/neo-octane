import type { ClassValue } from "clsx"
import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type TextareaProps = Record<string, any> & ClassProps

// Native <textarea>: use `onInput` for per-keystroke updates.
function Textarea({ class: klass, className, ...props }: TextareaProps) @{
  <textarea
    data-slot="textarea"
    class={cn(
      "flex min-h-[80px] w-full rounded-base border-2 border-border bg-secondary-background selection:bg-main selection:text-main-foreground px-3 py-2 text-sm font-base text-foreground placeholder:text-foreground/50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 aria-invalid:border-red-500",
      className,
      klass,
    )}
    {...props}
  />
}

export { Textarea }
