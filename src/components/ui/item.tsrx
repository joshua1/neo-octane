import type { ClassValue } from "clsx"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { cva, type VariantProps } from "class-variance-authority"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type HostProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function ItemGroup({ class: klass, className, ...props }: HostProps) @{
  <div
    role="list"
    data-slot="item-group"
    class={cn(
      "group/item-group flex w-full flex-col gap-4 has-data-[size=sm]:gap-2.5 has-data-[size=xs]:gap-2",
      className,
      klass,
    )}
    {...props}
  />
}

const itemVariants = cva(
  "group/item flex w-full flex-wrap items-center rounded-base border-2 border-border bg-background text-sm font-base text-foreground transition-colors duration-100 outline-none ring-offset-white focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 [a]:transition-colors [a]:hover:bg-main [a]:hover:text-main-foreground [button]:transition-colors [button]:hover:bg-main [button]:hover:text-main-foreground",
  {
    variants: {
      size: {
        default: "gap-3.5 px-4 py-3.5",
        sm: "gap-2.5 px-3 py-2.5",
        xs: "gap-2 px-2.5 py-2 in-data-[slot=dropdown-menu-content]:p-0",
      },
    },
    defaultVariants: {
      size: "default",
    },
  },
)

function Item({
  class: klass,
  className,
  size = "default",
  render,
  ...props
}: Omit<useRender.ComponentProps<"div">, "className"> &
  ClassProps &
  VariantProps<typeof itemVariants>) {
  return useRender({
    defaultTagName: "div",
    props: mergeProps<"div">(
      {
        className: cn(itemVariants({ size }), className, klass),
      },
      props,
    ) as Record<string, unknown>,
    // Binding typing gap: useRender.ComponentProps types `render` against HTMLProps while
    // useRender.Parameters expects HTMLAttributes (style string vs object); runtime is identical.
    render: render as any,
    state: {
      slot: "item",
      size,
    },
  })
}

const itemMediaVariants = cva(
  "flex shrink-0 items-center justify-center gap-2 group-has-data-[slot=item-description]/item:translate-y-0.5 group-has-data-[slot=item-description]/item:self-start [&_svg]:pointer-events-none",
  {
    variants: {
      variant: {
        default: "bg-transparent",
        icon: "[&_svg:not([class*='size-'])]:size-5",
        image:
          "size-10 overflow-hidden rounded-base border-2 border-border group-data-[size=sm]/item:size-8 group-data-[size=xs]/item:size-6 [&_img]:size-full [&_img]:object-cover",
      },
    },
    defaultVariants: {
      variant: "default",
    },
  },
)

function ItemMedia({
  class: klass,
  className,
  variant = "default",
  ...props
}: HostProps & VariantProps<typeof itemMediaVariants>) @{
  <div
    data-slot="item-media"
    data-variant={variant}
    class={cn(itemMediaVariants({ variant }), className, klass)}
    {...props}
  />
}

function ItemContent({ class: klass, className, ...props }: HostProps) @{
  <div
    data-slot="item-content"
    class={cn(
      "flex flex-1 flex-col gap-1 group-data-[size=xs]/item:gap-0 [&+[data-slot=item-content]]:flex-none",
      className,
      klass,
    )}
    {...props}
  />
}

function ItemTitle({ class: klass, className, ...props }: HostProps) @{
  <div
    data-slot="item-title"
    class={cn(
      "line-clamp-1 flex w-fit items-center gap-2 text-sm leading-snug font-base underline-offset-4",
      className,
      klass,
    )}
    {...props}
  />
}

function ItemDescription({ class: klass, className, ...props }: HostProps) @{
  <p
    data-slot="item-description"
    class={cn(
      "line-clamp-2 text-left text-sm leading-normal font-base text-foreground group-data-[size=xs]/item:text-xs [&>a]:underline [&>a]:underline-offset-4 [&>a:hover]:text-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

function ItemActions({ class: klass, className, ...props }: HostProps) @{
  <div
    data-slot="item-actions"
    class={cn("flex items-center gap-2", className, klass)}
    {...props}
  />
}

function ItemHeader({ class: klass, className, ...props }: HostProps) @{
  <div
    data-slot="item-header"
    class={cn(
      "flex basis-full items-center justify-between gap-2",
      className,
      klass,
    )}
    {...props}
  />
}

function ItemFooter({ class: klass, className, ...props }: HostProps) @{
  <div
    data-slot="item-footer"
    class={cn(
      "flex basis-full items-center justify-between gap-2",
      className,
      klass,
    )}
    {...props}
  />
}

export {
  Item,
  ItemMedia,
  ItemContent,
  ItemActions,
  ItemGroup,
  ItemTitle,
  ItemDescription,
  ItemHeader,
  ItemFooter,
}
