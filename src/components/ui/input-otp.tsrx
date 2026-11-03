import type { ClassValue } from "clsx"
import { useContext } from "octane"
import {
  OTPInput,
  OTPInputContext,
  type OTPInputProps,
} from "@octanejs/input-otp"
import { Dot } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

function InputOTP({
  class: klass,
  className,
  containerClassName,
  ...props
}: OTPInputProps &
  ClassProps & {
    containerClassName?: string
  }) @{
  <OTPInput
    data-slot="input-otp"
    containerClassName={cn(
      "flex items-center gap-2 has-disabled:opacity-50",
      containerClassName,
    )}
    class={cn("disabled:cursor-not-allowed", className, klass)}
    {...props}
  />
}

type DivProps = Record<string, any> & ClassProps

function InputOTPGroup({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="input-otp-group"
    class={cn("flex items-center", className, klass)}
    {...props}
  />
}

function InputOTPSlot({
  index,
  class: klass,
  className,
  ...props
}: DivProps & { index: number }) @{
  const inputOTPContext = useContext(OTPInputContext)
  const { char, hasFakeCaret, isActive } = inputOTPContext?.slots[index] ?? {}

  <div
    data-slot="input-otp-slot"
    data-active={isActive}
    class={cn(
      "relative flex size-10 items-center justify-center border-y-2 border-r-2 border-border bg-secondary-background text-sm font-base text-foreground first:rounded-l-base first:border-l-2 last:rounded-r-base transition-all aria-invalid:border-red-500 aria-invalid:ring-red-500",
      isActive && "z-10 ring-1 ring-ring",
      className,
      klass,
    )}
    {...props}
  >
    {(char ?? "") as string}
    @if (hasFakeCaret) {
      <div class="pointer-events-none absolute inset-0 flex items-center justify-center">
        <div class="h-4 w-px animate-caret-blink bg-current duration-1000" />
      </div>
    }
  </div>
}

function InputOTPSeparator({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="input-otp-separator"
    role="separator"
    class={cn(className, klass) || undefined}
    {...props}
  >
    <Dot class="size-4" />
  </div>
}

export { InputOTP, InputOTPGroup, InputOTPSlot, InputOTPSeparator }
