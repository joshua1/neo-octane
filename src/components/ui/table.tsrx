import type { ClassValue } from "clsx"
import type { OctaneNode } from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type HostProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function Table({ class: klass, className, ...props }: HostProps) @{
  <div class="relative w-full overflow-auto">
    <table
      data-slot="table"
      class={cn(
        "w-full caption-bottom border-2 border-border text-sm",
        className,
        klass,
      )}
      {...props}
    />
  </div>
}

function TableHeader({ class: klass, className, ...props }: HostProps) @{
  <thead
    data-slot="table-header"
    class={cn("[&_tr]:border-b-2 [&_tr]:border-border", className, klass)}
    {...props}
  />
}

function TableBody({ class: klass, className, ...props }: HostProps) @{
  <tbody
    data-slot="table-body"
    class={cn("[&_tr:last-child]:border-0", className, klass)}
    {...props}
  />
}

function TableFooter({ class: klass, className, ...props }: HostProps) @{
  <tfoot
    data-slot="table-footer"
    class={cn(
      "border-t-2 border-border bg-background font-base text-foreground last:[&>tr]:border-b-0",
      className,
      klass,
    )}
    {...props}
  />
}

function TableRow({ class: klass, className, ...props }: HostProps) @{
  <tr
    data-slot="table-row"
    class={cn(
      "border-b-2 border-border transition-colors text-foreground bg-background font-base data-[state=selected]:bg-main data-[state=selected]:text-main-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

function TableHead({ class: klass, className, ...props }: HostProps) @{
  <th
    data-slot="table-head"
    class={cn(
      "h-12 px-4 text-left align-middle font-heading text-foreground [&:has([role=checkbox])]:pr-0",
      className,
      klass,
    )}
    {...props}
  />
}

function TableCell({ class: klass, className, ...props }: HostProps) @{
  <td
    data-slot="table-cell"
    class={cn(
      "p-4 align-middle [&:has([role=checkbox])]:pr-0",
      className,
      klass,
    )}
    {...props}
  />
}

function TableCaption({ class: klass, className, ...props }: HostProps) @{
  <caption
    data-slot="table-caption"
    class={cn("mt-4 text-sm text-foreground font-base", className, klass)}
    {...props}
  />
}

export {
  Table,
  TableHeader,
  TableBody,
  TableFooter,
  TableHead,
  TableRow,
  TableCell,
  TableCaption,
}
