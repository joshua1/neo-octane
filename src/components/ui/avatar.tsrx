import type { ClassValue } from "clsx"
import { Avatar as AvatarPrimitive } from "@octanejs/base-ui/avatar"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps
type HostProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

const avatarSizes = {
  sm: "size-8",
  default: "size-10",
  lg: "size-12",
}

function Avatar({
  class: klass,
  className,
  size = "default",
  ...props
}: StyledProps<AvatarPrimitive.Root.Props> & {
  size?: "default" | "sm" | "lg"
}) @{
  <AvatarPrimitive.Root
    data-slot="avatar"
    data-size={size}
    className={cn(
      "group/avatar relative flex shrink-0 rounded-full outline-2 outline-border",
      avatarSizes[size],
      className,
      klass,
    )}
    {...props}
  />
}

function AvatarImage({
  class: klass,
  className,
  ...props
}: StyledProps<AvatarPrimitive.Image.Props>) @{
  <AvatarPrimitive.Image
    data-slot="avatar-image"
    className={cn("aspect-square size-full rounded-full", className, klass)}
    {...props}
  />
}

function AvatarFallback({
  class: klass,
  className,
  ...props
}: StyledProps<AvatarPrimitive.Fallback.Props>) @{
  <AvatarPrimitive.Fallback
    data-slot="avatar-fallback"
    className={cn(
      "flex size-full items-center justify-center rounded-full bg-secondary-background text-foreground font-base group-data-[size=sm]/avatar:text-xs group-data-[size=lg]/avatar:text-lg",
      className,
      klass,
    )}
    {...props}
  />
}

function AvatarBadge({ class: klass, className, ...props }: HostProps) @{
  <span
    data-slot="avatar-badge"
    class={cn(
      "absolute right-0 bottom-0 z-10 inline-flex items-center justify-center rounded-full border-2 border-border bg-main text-main-foreground select-none [&>svg]:shrink-0",
      "group-data-[size=sm]/avatar:size-3 group-data-[size=sm]/avatar:[&>svg]:hidden",
      "group-data-[size=default]/avatar:size-4 group-data-[size=default]/avatar:[&>svg]:size-2",
      "group-data-[size=lg]/avatar:size-5 group-data-[size=lg]/avatar:[&>svg]:size-2.5",
      className,
      klass,
    )}
    {...props}
  />
}

function AvatarGroup({ class: klass, className, ...props }: HostProps) @{
  <div
    data-slot="avatar-group"
    class={cn("group/avatar-group flex -space-x-2", className, klass)}
    {...props}
  />
}

function AvatarGroupCount({ class: klass, className, ...props }: HostProps) @{
  <div
    data-slot="avatar-group-count"
    class={cn(
      "relative flex size-10 shrink-0 items-center justify-center rounded-full bg-secondary-background text-sm font-base text-foreground outline-2 outline-border [&>svg]:size-4",
      className,
      klass,
    )}
    {...props}
  />
}

export {
  Avatar,
  AvatarImage,
  AvatarFallback,
  AvatarBadge,
  AvatarGroup,
  AvatarGroupCount,
}
