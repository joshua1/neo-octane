import type { ClassValue } from "clsx"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { ChevronRight, MoreHorizontal } from "@octanejs/lucide"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type HostProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function Breadcrumb({ class: klass, className, ...props }: HostProps) @{
  <nav
    data-slot="breadcrumb"
    aria-label="breadcrumb"
    class={cn(className, klass) || undefined}
    {...props}
  />
}

function BreadcrumbList({ class: klass, className, ...props }: HostProps) @{
  <ol
    data-slot="breadcrumb-list"
    class={cn(
      "flex flex-wrap items-center gap-1.5 text-sm font-base break-words text-foreground sm:gap-2.5",
      className,
      klass,
    )}
    {...props}
  />
}

function BreadcrumbItem({ class: klass, className, ...props }: HostProps) @{
  <li
    data-slot="breadcrumb-item"
    class={cn("inline-flex items-center gap-1.5", className, klass)}
    {...props}
  />
}

function BreadcrumbLink({
  class: klass,
  className,
  render,
  ...props
}: useRender.ComponentProps<"a"> & ClassProps) {
  return useRender({
    defaultTagName: "a",
    // Binding typing gap: useRender.ComponentProps types `render` against HTMLProps while
    // useRender.Parameters expects HTMLAttributes (style string vs object); runtime is identical.
    render: render as any,
    props: mergeProps<"a">(
      { className: cn(className, klass) },
      props,
    ) as Record<string, unknown>,
    state: {
      slot: "breadcrumb-link",
    },
  })
}

function BreadcrumbPage({ class: klass, className, ...props }: HostProps) @{
  <span
    data-slot="breadcrumb-page"
    role="link"
    aria-disabled="true"
    aria-current="page"
    class={cn(className, klass)}
    {...props}
  />
}

function BreadcrumbSeparator({
  children,
  class: klass,
  className,
  ...props
}: HostProps) @{
  <li
    data-slot="breadcrumb-separator"
    role="presentation"
    aria-hidden="true"
    class={cn("[&>svg]:size-3.5", className, klass)}
    {...props}
  >
    {children ?? <ChevronRight />}
  </li>
}

function BreadcrumbEllipsis({ class: klass, className, ...props }: HostProps) @{
  <span
    data-slot="breadcrumb-ellipsis"
    role="presentation"
    aria-hidden="true"
    class={cn("flex size-9 items-center justify-center", className, klass)}
    {...props}
  >
    <MoreHorizontal class="size-4" />
    <span class="sr-only">More</span>
  </span>
}

export {
  Breadcrumb,
  BreadcrumbList,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbPage,
  BreadcrumbSeparator,
  BreadcrumbEllipsis,
}
