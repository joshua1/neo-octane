import type { ClassValue } from "clsx"
import { type OctaneNode } from "octane"
import {
  Command as CommandPrimitive,
  type CommandProps,
  type EmptyProps,
  type GroupProps,
  type InputProps,
  type ItemProps,
  type ListProps,
  type SeparatorProps,
} from "@octanejs/cmdk"
import { type Dialog as DialogPrimitive } from "@octanejs/base-ui/dialog"
import { Search } from "@octanejs/lucide"

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
} from "@/components/ui/dialog.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

// cmdk parts spread their props onto plain DOM nodes, so they take `class`.
type StyledProps<P> = Omit<P, "class" | "className"> & ClassProps

function Command({
  class: klass,
  className,
  ...props
}: StyledProps<CommandProps>) @{
  <CommandPrimitive
    data-slot="command"
    class={cn(
      "flex h-full w-full flex-col overflow-hidden rounded-[0px] border-2 border-border bg-background font-base text-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

type CommandDialogProps = Omit<DialogPrimitive.Root.Props, "children"> & {
  title?: string
  description?: string
  children: OctaneNode
}

function CommandDialog({
  title = "Command Palette",
  description = "Search for a command to run...",
  children,
  ...props
}: CommandDialogProps) @{
  <Dialog {...props}>
    <DialogHeader class="sr-only">
      <DialogTitle>{title as string}</DialogTitle>
      <DialogDescription>{description as string}</DialogDescription>
    </DialogHeader>
    <DialogContent class="overflow-hidden p-0 rounded-[0px]! shadow-shadow border-0">
      <Command class="**:data-[slot=command-input-wrapper]:h-12 [&_[cmdk-group-heading]]:px-2 [&_[cmdk-group-heading]]:font-heading [&_[cmdk-group-heading]]:mb-1 [&_[cmdk-group]]:px-2 [&_[cmdk-input-wrapper]_svg]:h-5 [&_[cmdk-input-wrapper]_svg]:w-5 [&_[cmdk-input]]:h-12 [&_[cmdk-item]]:px-2 [&_[cmdk-item]]:py-3 [&_[cmdk-item]_svg]:h-5 [&_[cmdk-item]_svg]:w-5">
        {children}
      </Command>
    </DialogContent>
  </Dialog>
}

function CommandInput({
  class: klass,
  className,
  ...props
}: StyledProps<InputProps>) @{
  <div
    data-slot="command-input-wrapper"
    class="flex h-9 gap-2 items-center border-b-2 border-border px-3"
  >
    <Search class="size-4 shrink-0" />
    <CommandPrimitive.Input
      data-slot="command-input"
      class={cn(
        "flex h-10 w-full rounded-base bg-transparent py-3 text-sm outline-hidden placeholder:text-foreground placeholder:opacity-50 disabled:cursor-not-allowed disabled:opacity-50",
        className,
        klass,
      )}
      {...props}
    />
  </div>
}

function CommandList({
  class: klass,
  className,
  ...props
}: StyledProps<ListProps>) @{
  <CommandPrimitive.List
    data-slot="command-list"
    class={cn(
      "max-h-[300px] scroll-py-1 overflow-x-hidden overflow-y-auto",
      className,
      klass,
    )}
    {...props}
  />
}

function CommandEmpty({
  class: klass,
  className,
  ...props
}: StyledProps<EmptyProps>) @{
  <CommandPrimitive.Empty
    data-slot="command-empty"
    class={cn("py-6 text-center text-sm", className, klass)}
    {...props}
  />
}

function CommandGroup({
  class: klass,
  className,
  ...props
}: StyledProps<GroupProps>) @{
  <CommandPrimitive.Group
    data-slot="command-group"
    class={cn(
      "text-foreground overflow-hidden p-2 [&_[cmdk-group-heading]]:px-2 [&_[cmdk-group-heading]]:py-1.5 [&_[cmdk-group-heading]]:text-base [&_[cmdk-group-heading]]:font-heading",
      className,
      klass,
    )}
    {...props}
  />
}

function CommandSeparator({
  class: klass,
  className,
  ...props
}: StyledProps<SeparatorProps>) @{
  <CommandPrimitive.Separator
    data-slot="command-separator"
    class={cn("-mx-1 h-0.5 bg-border", className, klass)}
    {...props}
  />
}

function CommandItem({
  class: klass,
  className,
  ...props
}: StyledProps<ItemProps>) @{
  <CommandPrimitive.Item
    data-slot="command-item"
    class={cn(
      "relative flex cursor-default select-none items-center rounded-base px-2 py-1.5 gap-2 text-sm text-foreground border-2 border-transparent aria-selected:border-border aria-selected:bg-main aria-selected:text-main-foreground data-[disabled=true]:pointer-events-none data-[disabled=true]:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    {...props}
  />
}

type SpanProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function CommandShortcut({ class: klass, className, ...props }: SpanProps) @{
  <span
    data-slot="command-shortcut"
    class={cn("ml-auto text-xs tracking-widest", className, klass)}
    {...props}
  />
}

export {
  Command,
  CommandDialog,
  CommandInput,
  CommandList,
  CommandEmpty,
  CommandGroup,
  CommandItem,
  CommandShortcut,
  CommandSeparator,
}
