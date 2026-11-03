import type { ClassValue } from "clsx"
import { createContext, useContext, type OctaneNode } from "octane"
import { Menu as MenuPrimitive } from "@octanejs/base-ui/menu"
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
const DropdownMenuGroupContext = createContext(false)

function DropdownMenu(props: MenuPrimitive.Root.Props) @{
  <MenuPrimitive.Root data-slot="dropdown-menu" {...props} />
}

function DropdownMenuTrigger({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <MenuPrimitive.Trigger
    data-slot="dropdown-menu-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DropdownMenuGroup({ class: klass, className, ...props }: PartProps) @{
  <DropdownMenuGroupContext value={true}>
    <MenuPrimitive.Group
      data-slot="dropdown-menu-group"
      className={cn(className, klass) || undefined}
      {...props}
    />
  </DropdownMenuGroupContext>
}

function DropdownMenuPortal({ class: klass, className, ...props }: PartProps) @{
  <MenuPrimitive.Portal
    data-slot="dropdown-menu-portal"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function DropdownMenuSub(props: MenuPrimitive.SubmenuRoot.Props) @{
  <MenuPrimitive.SubmenuRoot data-slot="dropdown-menu-sub" {...props} />
}

function DropdownMenuRadioGroup({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <DropdownMenuGroupContext value={true}>
    <MenuPrimitive.RadioGroup
      data-slot="dropdown-menu-radio-group"
      className={cn(className, klass) || undefined}
      {...props}
    />
  </DropdownMenuGroupContext>
}

function DropdownMenuSubTrigger({
  class: klass,
  className,
  inset,
  children,
  ...props
}: PartProps & { inset?: boolean }) @{
  <MenuPrimitive.SubmenuTrigger
    data-slot="dropdown-menu-sub-trigger"
    data-inset={inset}
    className={cn(
      "flex cursor-default select-none items-center rounded-base border-2 border-transparent px-2 py-1.5 text-sm font-base outline-hidden hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-popup-open:bg-main data-popup-open:text-main-foreground data-popup-open:border-border gap-2 data-inset:pl-8 [&_svg]:pointer-events-none [&_svg]:w-4 [&_svg]:h-4 [&_svg]:shrink-0",
      className,
      klass,
    )}
    {...props}
  >
    {children}
    <ChevronRight class="ml-auto" />
  </MenuPrimitive.SubmenuTrigger>
}

const dropdownMenuPopupClassName =
  "z-50 min-w-[8rem] overflow-hidden rounded-base border-2 border-border bg-background p-1 font-base text-foreground outline-none origin-(--transform-origin) data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2"

function DropdownMenuSubContent({
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
        data-slot="dropdown-menu-sub-content"
        className={cn(dropdownMenuPopupClassName, className, klass)}
        {...props}
      />
    </MenuPrimitive.Positioner>
  </MenuPrimitive.Portal>
}

function DropdownMenuContent({
  class: klass,
  className,
  align = "center",
  alignOffset = 0,
  side = "bottom",
  sideOffset = 4,
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
        data-slot="dropdown-menu-content"
        className={cn(dropdownMenuPopupClassName, className, klass)}
        {...props}
      />
    </MenuPrimitive.Positioner>
  </MenuPrimitive.Portal>
}

function DropdownMenuItem({
  class: klass,
  className,
  inset,
  ...props
}: PartProps & { inset?: boolean }) @{
  <MenuPrimitive.Item
    data-slot="dropdown-menu-item"
    data-inset={inset}
    className={cn(
      "relative gap-2 [&_svg]:pointer-events-none [&_svg]:w-4 [&_svg]:h-4 [&_svg]:shrink-0 flex cursor-default select-none items-center rounded-base border-2 border-transparent data-inset:pl-8 px-2 py-1.5 text-sm font-base outline-hidden transition-colors hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50",
      className,
      klass,
    )}
    {...props}
  />
}

function DropdownMenuCheckboxItem({
  class: klass,
  className,
  children,
  checked,
  ...props
}: PartProps & { checked?: boolean }) @{
  <MenuPrimitive.CheckboxItem
    data-slot="dropdown-menu-checkbox-item"
    className={cn(
      "relative flex cursor-default select-none items-center rounded-base border-2 border-transparent gap-2 py-1.5 pl-8 pr-2 text-sm font-base outline-hidden transition-colors hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    checked={checked}
    {...props}
  >
    <span class="pointer-events-none absolute left-2 flex size-3.5 items-center justify-center">
      <MenuPrimitive.CheckboxItemIndicator>
        <Check />
      </MenuPrimitive.CheckboxItemIndicator>
    </span>
    {children}
  </MenuPrimitive.CheckboxItem>
}

function DropdownMenuRadioItem({
  class: klass,
  className,
  children,
  ...props
}: PartProps & { value: unknown }) @{
  <MenuPrimitive.RadioItem
    data-slot="dropdown-menu-radio-item"
    className={cn(
      "relative flex cursor-default select-none items-center rounded-base border-2 border-transparent gap-2 py-1.5 pl-8 pr-2 text-sm font-base outline-hidden transition-colors hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50",
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

function DropdownMenuLabel({
  class: klass,
  className,
  inset,
  ...props
}: PartProps & { inset?: boolean }) @{
  const inGroup = useContext(DropdownMenuGroupContext)
  const labelClassName = cn(
    "px-2 py-1.5 text-sm font-heading data-inset:pl-8",
    className,
    klass,
  )

  // Outside a group, Base UI's GroupLabel has no context and throws, so fall
  // back to a plain element (which is what Radix rendered anyway).
  @if (!inGroup) {
    <div
      data-slot="dropdown-menu-label"
      data-inset={inset}
      class={labelClassName}
      {...props}
    />
  } @else {
    <MenuPrimitive.GroupLabel
      data-slot="dropdown-menu-label"
      data-inset={inset}
      className={labelClassName}
      {...props}
    />
  }
}

function DropdownMenuSeparator({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <MenuPrimitive.Separator
    data-slot="dropdown-menu-separator"
    className={cn("-mx-1 my-1 h-0.5 bg-border", className, klass)}
    {...props}
  />
}

function DropdownMenuShortcut({
  class: klass,
  className,
  ...props
}: PartProps) @{
  <span
    data-slot="dropdown-menu-shortcut"
    class={cn("ml-auto text-xs font-base tracking-widest", className, klass)}
    {...props}
  />
}

export {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuCheckboxItem,
  DropdownMenuRadioItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuGroup,
  DropdownMenuPortal,
  DropdownMenuSub,
  DropdownMenuSubContent,
  DropdownMenuSubTrigger,
  DropdownMenuRadioGroup,
}
