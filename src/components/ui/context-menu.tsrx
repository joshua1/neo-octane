import type { ClassValue } from "clsx"
import { createContext, useContext, type OctaneNode } from "octane"
import { ContextMenu as ContextMenuPrimitive } from "@octanejs/base-ui/context-menu"
import { Check, ChevronRight, Circle } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type PartProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type PositionerProps = Pick<
  ContextMenuPrimitive.Positioner.Props,
  "align" | "alignOffset" | "side" | "sideOffset"
>

// Base UI's GroupLabel must live inside a Group or RadioGroup. Track that so a
// standalone label (like Radix allowed) still renders instead of throwing.
const ContextMenuGroupContext = createContext(false)

function ContextMenu(props: ContextMenuPrimitive.Root.Props) @{
  <ContextMenuPrimitive.Root data-slot="context-menu" {...props} />
}

function ContextMenuTrigger({ class: klass, className, ...props }: PartProps) @{
  <ContextMenuPrimitive.Trigger
    data-slot="context-menu-trigger"
    className={cn("select-none", className, klass)}
    {...props}
  />
}

function ContextMenuGroup({ class: klass, className, ...props }: PartProps) @{
  <ContextMenuGroupContext value={true}>
    <ContextMenuPrimitive.Group
      data-slot="context-menu-group"
      className={cn(className, klass) || undefined}
      {...props}
    />
  </ContextMenuGroupContext>
}

function ContextMenuPortal({ class: klass, className, ...props }: PartProps) @{
  <ContextMenuPrimitive.Portal
    data-slot="context-menu-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function ContextMenuSub(props: ContextMenuPrimitive.SubmenuRoot.Props) @{
  <ContextMenuPrimitive.SubmenuRoot data-slot="context-menu-sub" {...props} />
}

function ContextMenuRadioGroup({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <ContextMenuGroupContext value={true}>
    <ContextMenuPrimitive.RadioGroup
      data-slot="context-menu-radio-group"
      className={cn(className, klass) || undefined}
      {...props}
    />
  </ContextMenuGroupContext>
}

function ContextMenuSubTrigger({
  class: klass,
  className,
  inset,
  children,
  ...props
}: PartProps & { inset?: boolean }) @{
  <ContextMenuPrimitive.SubmenuTrigger
    data-slot="context-menu-sub-trigger"
    data-inset={inset}
    className={cn(
      "flex cursor-default select-none items-center rounded-base border-2 border-transparent px-2 py-1.5 text-sm font-base outline-hidden data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-popup-open:bg-main data-popup-open:text-main-foreground data-popup-open:border-border",
      className,
      klass,
    )}
    {...props}
  >
    {children}
    <ChevronRight class="ml-auto" />
  </ContextMenuPrimitive.SubmenuTrigger>
}

const contextMenuPopupClassName =
  "z-50 min-w-[8rem] overflow-hidden rounded-base border-2 border-border bg-background p-1 font-base text-foreground outline-none origin-(--transform-origin) data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2"

function ContextMenuSubContent({
  class: klass,
  className,
  align,
  alignOffset,
  side,
  sideOffset,
  ...props
}: PartProps & PositionerProps) @{
  <ContextMenuPrimitive.Portal>
    <ContextMenuPrimitive.Positioner
      className="isolate z-50 outline-none"
      align={align}
      alignOffset={alignOffset}
      side={side}
      sideOffset={sideOffset}
    >
      <ContextMenuPrimitive.Popup
        data-slot="context-menu-sub-content"
        className={cn(contextMenuPopupClassName, className, klass)}
        {...props}
      />
    </ContextMenuPrimitive.Positioner>
  </ContextMenuPrimitive.Portal>
}

function ContextMenuContent({
  class: klass,
  className,
  align,
  alignOffset,
  side,
  sideOffset,
  ...props
}: PartProps & PositionerProps) @{
  <ContextMenuPrimitive.Portal>
    <ContextMenuPrimitive.Positioner
      className="isolate z-50 outline-none"
      align={align}
      alignOffset={alignOffset}
      side={side}
      sideOffset={sideOffset}
    >
      <ContextMenuPrimitive.Popup
        data-slot="context-menu-content"
        className={cn(contextMenuPopupClassName, className, klass)}
        {...props}
      />
    </ContextMenuPrimitive.Positioner>
  </ContextMenuPrimitive.Portal>
}

function ContextMenuItem({
  class: klass,
  className,
  inset,
  variant = "default",
  ...props
}: PartProps & {
  inset?: boolean
  variant?: "default" | "destructive"
}) @{
  <ContextMenuPrimitive.Item
    data-slot="context-menu-item"
    data-inset={inset}
    data-variant={variant}
    className={cn(
      "relative flex cursor-default select-none items-center rounded-base border-2 border-transparent px-2 py-1.5 gap-2 text-sm outline-none hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      "data-[variant=destructive]:text-red-500 data-[variant=destructive]:hover:bg-red-500 data-[variant=destructive]:hover:text-white data-[variant=destructive]:focus:bg-red-500 data-[variant=destructive]:focus:text-white data-[variant=destructive]:data-highlighted:bg-red-500 data-[variant=destructive]:data-highlighted:text-white",
      className,
      klass,
    )}
    {...props}
  />
}

function ContextMenuCheckboxItem({
  class: klass,
  className,
  children,
  checked,
  ...props
}: PartProps & { checked?: boolean }) @{
  <ContextMenuPrimitive.CheckboxItem
    data-slot="context-menu-checkbox-item"
    className={cn(
      "relative flex cursor-default select-none items-center rounded-base border-2 border-transparent py-1.5 pl-8 pr-2 gap-2 text-sm font-base outline-hidden hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50",
      className,
      klass,
    )}
    checked={checked}
    {...props}
  >
    <span class="pointer-events-none absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      <ContextMenuPrimitive.CheckboxItemIndicator>
        <Check class="h-4 w-4" />
      </ContextMenuPrimitive.CheckboxItemIndicator>
    </span>
    {children}
  </ContextMenuPrimitive.CheckboxItem>
}

function ContextMenuRadioItem({
  class: klass,
  className,
  children,
  ...props
}: PartProps & { value: unknown }) @{
  <ContextMenuPrimitive.RadioItem
    data-slot="context-menu-radio-item"
    className={cn(
      "relative flex cursor-default select-none items-center rounded-base border-2 border-transparent py-1.5 pl-8 pr-2 gap-2 text-sm font-base outline-hidden hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50",
      className,
      klass,
    )}
    {...props}
  >
    <span class="pointer-events-none absolute left-2 flex h-3.5 w-3.5 items-center justify-center">
      <ContextMenuPrimitive.RadioItemIndicator>
        <Circle class="h-2 w-2 fill-current" />
      </ContextMenuPrimitive.RadioItemIndicator>
    </span>
    {children}
  </ContextMenuPrimitive.RadioItem>
}

function ContextMenuLabel({
  class: klass,
  className,
  inset,
  ...props
}: PartProps & { inset?: boolean }) @{
  const inGroup = useContext(ContextMenuGroupContext)
  const labelClassName = cn(
    "px-2 py-1.5 text-sm font-base border-2 border-transparent data-inset:pl-8",
    className,
    klass,
  )

  // Outside a group, Base UI's GroupLabel has no context and throws, so fall
  // back to a plain element (which is what Radix rendered anyway).
  @if (!inGroup) {
    <div
      data-slot="context-menu-label"
      data-inset={inset}
      class={labelClassName}
      {...props}
    />
  } @else {
    <ContextMenuPrimitive.GroupLabel
      data-slot="context-menu-label"
      data-inset={inset}
      className={labelClassName}
      {...props}
    />
  }
}

function ContextMenuSeparator({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <ContextMenuPrimitive.Separator
    data-slot="context-menu-separator"
    className={cn("-mx-1 my-1 h-0.5 bg-border", className, klass)}
    {...props}
  />
}

function ContextMenuShortcut({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <span
    data-slot="context-menu-shortcut"
    class={cn("ml-auto text-xs font-base tracking-widest", className, klass)}
    {...props}
  />
}

export {
  ContextMenu,
  ContextMenuTrigger,
  ContextMenuContent,
  ContextMenuItem,
  ContextMenuCheckboxItem,
  ContextMenuRadioItem,
  ContextMenuLabel,
  ContextMenuSeparator,
  ContextMenuShortcut,
  ContextMenuGroup,
  ContextMenuPortal,
  ContextMenuSub,
  ContextMenuSubContent,
  ContextMenuSubTrigger,
  ContextMenuRadioGroup,
}
