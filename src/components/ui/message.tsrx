import type { ClassValue } from "clsx"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> & ClassProps & { children?: OctaneNode }

function MessageGroup({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="message-group"
    class={cn("flex min-w-0 flex-col gap-2", className, klass)}
    {...props}
  />
}

function Message({
  class: klass,
  className,
  align = "start",
  ...props
}: DivProps & { align?: "start" | "end" }) @{
  <div
    data-slot="message"
    data-align={align}
    class={cn(
      "group/message relative flex w-full min-w-0 gap-2 text-sm font-base data-[align=end]:flex-row-reverse",
      className,
      klass,
    )}
    {...props}
  />
}

function MessageAvatar({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="message-avatar"
    class={cn(
      "flex size-10 shrink-0 items-center justify-center self-start overflow-hidden rounded-full border-2 border-border bg-background [&_[data-slot=avatar]]:size-full [&_[data-slot=avatar]]:outline-0 [&_[data-slot=avatar-fallback]]:bg-background",
      className,
      klass,
    )}
    {...props}
  />
}

function MessageContent({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="message-content"
    class={cn(
      "flex w-full min-w-0 flex-col gap-2.5 wrap-break-word group-data-[align=end]/message:*:data-slot:self-end",
      className,
      klass,
    )}
    {...props}
  />
}

function MessageHeader({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="message-header"
    class={cn(
      "flex max-w-full min-w-0 items-center px-3 text-xs font-base text-foreground group-has-data-[variant=ghost]/message:px-0",
      className,
      klass,
    )}
    {...props}
  />
}

function MessageFooter({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="message-footer"
    class={cn(
      "flex max-w-full min-w-0 items-center px-3 text-xs font-base text-foreground group-has-data-[variant=ghost]/message:px-0 group-data-[align=end]/message:justify-end",
      className,
      klass,
    )}
    {...props}
  />
}

export {
  MessageGroup,
  Message,
  MessageAvatar,
  MessageContent,
  MessageFooter,
  MessageHeader,
}
