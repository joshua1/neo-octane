import type { ClassValue } from "clsx"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function Card({
  class: klass,
  className,
  size = "default",
  ...props
}: DivProps & { size?: "default" | "sm" }) @{
  <div
    data-slot="card"
    data-size={size}
    class={cn(
      "group/card rounded-base flex flex-col shadow-shadow border-2 gap-(--card-spacing) py-(--card-spacing) border-border bg-background text-foreground font-base [--card-spacing:--spacing(6)] data-[size=sm]:[--card-spacing:--spacing(4)]",
      className,
      klass,
    )}
    {...props}
  />
}

function CardHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="card-header"
    class={cn(
      "@container/card-header grid auto-rows-min grid-rows-[auto_auto] items-start gap-1.5 px-(--card-spacing) has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-(--card-spacing)",
      className,
      klass,
    )}
    {...props}
  />
}

function CardTitle({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="card-title"
    class={cn("font-heading leading-none", className, klass)}
    {...props}
  />
}

function CardDescription({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="card-description"
    class={cn("text-sm font-base", className, klass)}
    {...props}
  />
}

function CardAction({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="card-action"
    class={cn(
      "col-start-2 row-span-2 row-start-1 self-start justify-self-end",
      className,
      klass,
    )}
    {...props}
  />
}

function CardContent({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="card-content"
    class={cn("px-(--card-spacing)", className, klass)}
    {...props}
  />
}

function CardFooter({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="card-footer"
    class={cn(
      "flex items-center px-(--card-spacing) [.border-t]:pt-(--card-spacing)",
      className,
      klass,
    )}
    {...props}
  />
}

export {
  Card,
  CardHeader,
  CardFooter,
  CardTitle,
  CardDescription,
  CardContent,
  CardAction,
}
