import type { ClassValue } from "clsx"
import { createContext, useContext, type OctaneNode } from "octane"
import { Menu as MenuPrimitive } from "@octanejs/base-ui/menu"
import { Menubar as MenubarPrimitive } from "@octanejs/base-ui/menubar"
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
  MenuPrimitive.Positioner.Props,
  "align" | "alignOffset" | "side" | "sideOffset"
>

// Base UI's GroupLabel must live inside a Group or RadioGroup. Track that so a
// standalone label (like Radix allowed) still renders instead of throwing.
const MenubarGroupContext = createContext(false)

function Menubar({ class: klass, className, ...props }: PartProps) @{
  <MenubarPrimitive
    data-slot="menubar"
    className={cn(
      "flex h-11 items-center space-x-1 rounded-base border-2 border-border bg-background p-1 font-base",
      className,
      klass,
    )}
    {...props}
  />
}

function MenubarMenu(props: MenuPrimitive.Root.Props) @{
  <MenuPrimitive.Root data-slot="menubar-menu" {...props} />
}

function MenubarTrigger({ class: klass, className, ...props }: PartProps) @{
  <MenuPrimitive.Trigger
    data-slot="menubar-trigger"
    className={cn(
      "flex cursor-default select-none items-center text-foreground rounded-base px-3 py-1.5 text-sm border-2 border-transparent font-heading outline-none hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-popup-open:bg-main data-popup-open:text-main-foreground data-popup-open:border-border",
      className,
      klass,
    )}
    {...props}
  />
}

const menubarPopupClassName =
  "z-50 min-w-[12rem] overflow-hidden rounded-base border-2 border-border bg-background p-1 text-foreground outline-none origin-(--transform-origin) data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2"

function MenubarContent({
  class: klass,
  className,
  align = "start",
  alignOffset = -4,
  side = "bottom",
  sideOffset = 8,
  ...props
}: PartProps & PositionerProps) @{
  <MenuPrimitive.Portal>
    <MenuPrimitive.Positioner
      className="isolate z-50 outline-none"
      align={align}
      alignOffset={alignOffset}
      side={side}
      sideOffset={sideOffset}
    >
      <MenuPrimitive.Popup
        data-slot="menubar-content"
        className={cn(menubarPopupClassName, className, klass)}
        {...props}
      />
    </MenuPrimitive.Positioner>
  </MenuPrimitive.Portal>
}

function MenubarGroup({ class: klass, className, ...props }: PartProps) @{
  <MenubarGroupContext value={true}>
    <MenuPrimitive.Group
      data-slot="menubar-group"
      className={cn(className, klass) || undefined}
      {...props}
    />
  </MenubarGroupContext>
}

function MenubarPortal({ class: klass, className, ...props }: PartProps) @{
  <MenuPrimitive.Portal
    data-slot="menubar-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function MenubarSub(props: MenuPrimitive.SubmenuRoot.Props) @{
  <MenuPrimitive.SubmenuRoot data-slot="menubar-sub" {...props} />
}

function MenubarRadioGroup({ class: klass, className, ...props }: PartProps) @{
  <MenubarGroupContext value={true}>
    <MenuPrimitive.RadioGroup
      data-slot="menubar-radio-group"
      className={cn(className, klass) || undefined}
      {...props}
    />
  </MenubarGroupContext>
}

function MenubarItem({
  class: klass,
  className,
  inset,
  ...props
}: PartProps & { inset?: boolean }) @{
  <MenuPrimitive.Item
    data-slot="menubar-item"
    data-inset={inset}
    className={cn(
      "relative flex cursor-default select-none items-center gap-2 rounded-base border-2 border-transparent px-2 py-1.5 text-sm font-base outline-hidden hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    {...props}
  />
}

function MenubarCheckboxItem({
  class: klass,
  className,
  children,
  checked,
  ...props
}: PartProps & { checked?: boolean }) @{
  <MenuPrimitive.CheckboxItem
    data-slot="menubar-checkbox-item"
    className={cn(
      "relative flex cursor-default select-none items-center rounded-base border-2 border-transparent py-1.5 pl-8 pr-2 text-sm font-base outline-hidden hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    checked={checked}
    {...props}
  >
    <span class="pointer-events-none absolute left-2 flex size-3.5 items-center justify-center">
      <MenuPrimitive.CheckboxItemIndicator>
        <Check class="size-4" />
      </MenuPrimitive.CheckboxItemIndicator>
    </span>
    {children}
  </MenuPrimitive.CheckboxItem>
}

function MenubarRadioItem({
  class: klass,
  className,
  children,
  ...props
}: PartProps & { value: unknown }) @{
  <MenuPrimitive.RadioItem
    data-slot="menubar-radio-item"
    className={cn(
      "relative flex cursor-default select-none items-center rounded-base border-2 border-transparent py-1.5 pl-8 pr-2 text-sm font-base outline-hidden hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    {...props}
  >
    <span class="pointer-events-none absolute left-2 flex size-3.5 items-center justify-center">
      <MenuPrimitive.RadioItemIndicator>
        <Circle class="size-2 fill-current" />
      </MenuPrimitive.RadioItemIndicator>
    </span>
    {children}
  </MenuPrimitive.RadioItem>
}

function MenubarLabel({
  class: klass,
  className,
  inset,
  ...props
}: PartProps & { inset?: boolean }) @{
  const inGroup = useContext(MenubarGroupContext)
  const labelClassName = cn(
    "px-2 py-1.5 text-sm font-heading data-inset:pl-8",
    className,
    klass,
  )

  // Outside a group, Base UI's GroupLabel has no context and throws, so fall
  // back to a plain element (which is what Radix rendered anyway).
  @if (!inGroup) {
    <div
      data-slot="menubar-label"
      data-inset={inset}
      class={labelClassName}
      {...props}
    />
  } @else {
    <MenuPrimitive.GroupLabel
      data-slot="menubar-label"
      data-inset={inset}
      className={labelClassName}
      {...props}
    />
  }
}

function MenubarSeparator({ class: klass, className, ...props }: PartProps) @{
  <MenuPrimitive.Separator
    data-slot="menubar-separator"
    className={cn("-mx-1 my-1 h-0.5 bg-border", className, klass)}
    {...props}
  />
}

function MenubarShortcut({ class: klass, className, ...props }: PartProps) @{
  <span
    data-slot="menubar-shortcut"
    class={cn("ml-auto text-xs tracking-widest", className, klass)}
    {...props}
  />
}

function MenubarSubTrigger({
  class: klass,
  className,
  inset,
  children,
  ...props
}: PartProps & { inset?: boolean }) @{
  <MenuPrimitive.SubmenuTrigger
    data-slot="menubar-sub-trigger"
    data-inset={inset}
    className={cn(
      "flex cursor-default select-none items-center gap-2 rounded-base border-2 border-transparent px-3 py-1.5 text-sm font-base outline-hidden hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-popup-open:bg-main data-popup-open:text-main-foreground data-popup-open:border-border data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    {...props}
  >
    {children}
    <ChevronRight class="ml-auto size-4" />
  </MenuPrimitive.SubmenuTrigger>
}

function MenubarSubContent({
  class: klass,
  className,
  align,
  alignOffset,
  side,
  sideOffset,
  ...props
}: PartProps & PositionerProps) @{
  <MenuPrimitive.Portal>
    <MenuPrimitive.Positioner
      className="isolate z-50 outline-none"
      align={align}
      alignOffset={alignOffset}
      side={side}
      sideOffset={sideOffset}
    >
      <MenuPrimitive.Popup
        data-slot="menubar-sub-content"
        className={cn(menubarPopupClassName, "min-w-[8rem]", className, klass)}
        {...props}
      />
    </MenuPrimitive.Positioner>
  </MenuPrimitive.Portal>
}

export {
  Menubar,
  MenubarMenu,
  MenubarTrigger,
  MenubarContent,
  MenubarItem,
  MenubarSeparator,
  MenubarLabel,
  MenubarCheckboxItem,
  MenubarRadioGroup,
  MenubarRadioItem,
  MenubarPortal,
  MenubarSubContent,
  MenubarSubTrigger,
  MenubarGroup,
  MenubarSub,
  MenubarShortcut,
}
