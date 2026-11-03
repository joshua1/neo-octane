import type { ClassValue } from "clsx"
import { Progress as ProgressPrimitive } from "@octanejs/base-ui/progress"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function Progress({
  class: klass,
  className,
  children,
  value,
  ...props
}: StyledProps<ProgressPrimitive.Root.Props>) @{
  <ProgressPrimitive.Root
    data-slot="progress"
    value={value}
    className={cn("flex w-full flex-wrap gap-2", className, klass)}
    {...props}
  >
    {children}
    <ProgressTrack>
      <ProgressIndicator />
    </ProgressTrack>
  </ProgressPrimitive.Root>
}

function ProgressTrack({
  class: klass,
  className,
  ...props
}: StyledProps<ProgressPrimitive.Track.Props>) @{
  <ProgressPrimitive.Track
    data-slot="progress-track"
    className={cn(
      "relative h-4 w-full overflow-hidden rounded-base border-2 border-border bg-secondary-background",
      className,
      klass,
    )}
    {...props}
  />
}

function ProgressIndicator({
  class: klass,
  className,
  ...props
}: StyledProps<ProgressPrimitive.Indicator.Props>) @{
  <ProgressPrimitive.Indicator
    data-slot="progress-indicator"
    className={cn(
      "h-full border-r-2 border-border bg-main transition-all",
      className,
      klass,
    )}
    {...props}
  />
}

function ProgressLabel({
  class: klass,
  className,
  ...props
}: StyledProps<ProgressPrimitive.Label.Props>) @{
  <ProgressPrimitive.Label
    data-slot="progress-label"
    className={cn("text-sm font-heading text-foreground", className, klass)}
    {...props}
  />
}

function ProgressValue({
  class: klass,
  className,
  ...props
}: StyledProps<ProgressPrimitive.Value.Props>) @{
  <ProgressPrimitive.Value
    data-slot="progress-value"
    className={cn(
      "ms-auto text-sm font-base text-foreground tabular-nums",
      className,
      klass,
    )}
    {...props}
  />
}

export {
  Progress,
  ProgressTrack,
  ProgressIndicator,
  ProgressLabel,
  ProgressValue,
}
