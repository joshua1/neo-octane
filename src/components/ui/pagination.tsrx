import type { ClassValue } from "clsx"
import { ChevronLeft, ChevronRight, MoreHorizontal } from "@octanejs/lucide"
import type { OctaneNode } from "octane"

import { buttonVariants } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type HostProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type PaginationLinkProps = HostProps & {
  isActive?: boolean
  size?: "default" | "sm" | "lg" | "icon"
}

function Pagination({ class: klass, className, ...props }: HostProps) @{
  <nav
    data-slot="pagination"
    role="navigation"
    aria-label="pagination"
    class={cn("mx-auto flex w-full justify-center", className, klass)}
    {...props}
  />
}

function PaginationContent({ class: klass, className, ...props }: HostProps) @{
  <ul
    data-slot="pagination-content"
    class={cn("flex flex-row items-center gap-1", className, klass)}
    {...props}
  />
}

function PaginationItem({ class: klass, className, ...props }: HostProps) @{
  <li data-slot="pagination-item" class={cn("", className, klass)} {...props} />
}

function PaginationLink({
  class: klass,
  className,
  isActive,
  size = "icon",
  ...props
}: PaginationLinkProps) @{
  <a
    data-slot="pagination-link"
    aria-current={isActive ? "page" : undefined}
    class={cn(
      buttonVariants({
        variant: "noShadow",
        size,
      }),
      "bg-background text-foreground",
      isActive && "bg-main text-main-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

function PaginationPrevious({
  class: klass,
  className,
  ...props
}: PaginationLinkProps) @{
  <PaginationLink
    data-slot="pagination-previous"
    aria-label="Go to previous page"
    size="default"
    class={cn("gap-1 pl-2.5", className, klass)}
    {...props}
  >
    <ChevronLeft class="size-4" />
    <span>Previous</span>
  </PaginationLink>
}

function PaginationNext({
  class: klass,
  className,
  ...props
}: PaginationLinkProps) @{
  <PaginationLink
    data-slot="pagination-next"
    aria-label="Go to next page"
    size="default"
    class={cn("gap-1 pr-2.5", className, klass)}
    {...props}
  >
    <span>Next</span>
    <ChevronRight class="size-4" />
  </PaginationLink>
}

function PaginationEllipsis({ class: klass, className, ...props }: HostProps) @{
  <span
    data-slot="pagination-ellipsis"
    aria-hidden
    class={cn("flex size-9 items-center justify-center", className, klass)}
    {...props}
  >
    <MoreHorizontal class="size-4" />
    <span class="sr-only">More pages</span>
  </span>
}

export {
  Pagination,
  PaginationContent,
  PaginationEllipsis,
  PaginationItem,
  PaginationLink,
  PaginationNext,
  PaginationPrevious,
}
