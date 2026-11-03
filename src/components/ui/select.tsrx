import type { ClassValue } from "clsx"
import { Select as SelectPrimitive } from "@octanejs/base-ui/select"
import { Check, ChevronDown, ChevronUp } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

const Select = SelectPrimitive.Root

function SelectGroup({
  class: klass,
  className,
  ...props
}: StyledProps<SelectPrimitive.Group.Props>) @{
  <SelectPrimitive.Group
    data-slot="select-group"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function SelectValue({
  class: klass,
  className,
  ...props
}: StyledProps<SelectPrimitive.Value.Props>) @{
  <SelectPrimitive.Value
    data-slot="select-value"
    className={cn("flex flex-1 items-center gap-2 text-left", className, klass)}
    {...props}
  />
}

function SelectTrigger({
  class: klass,
  className,
  children,
  ...props
}: StyledProps<SelectPrimitive.Trigger.Props>) @{
  <SelectPrimitive.Trigger
    data-slot="select-trigger"
    className={cn(
      "flex h-10 w-full items-center justify-between rounded-base border-2 border-border bg-main gap-2 px-3 py-2 text-sm font-base text-main-foreground ring-offset-white placeholder:text-foreground/50 focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 focus:outline-hidden focus:ring-2 focus:ring-black focus:ring-offset-2 disabled:cursor-not-allowed disabled:opacity-50 data-disabled:cursor-not-allowed data-disabled:opacity-50 *:data-[slot=select-value]:line-clamp-1 *:data-[slot=select-value]:flex *:data-[slot=select-value]:items-center *:data-[slot=select-value]:gap-2 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    {...props}
  >
    {children}
    <SelectPrimitive.Icon render={<ChevronDown className="size-4" />} />
  </SelectPrimitive.Trigger>
}

function SelectScrollUpButton({
  class: klass,
  className,
  ...props
}: StyledProps<SelectPrimitive.ScrollUpArrow.Props>) @{
  <SelectPrimitive.ScrollUpArrow
    data-slot="select-scroll-up"
    className={cn(
      "top-0 z-10 flex w-full cursor-default items-center justify-center bg-background py-1 font-base text-foreground",
      className,
      klass,
    )}
    {...props}
  >
    <ChevronUp class="size-4" />
  </SelectPrimitive.ScrollUpArrow>
}

function SelectScrollDownButton({
  class: klass,
  className,
  ...props
}: StyledProps<SelectPrimitive.ScrollDownArrow.Props>) @{
  <SelectPrimitive.ScrollDownArrow
    data-slot="select-scroll-down"
    className={cn(
      "bottom-0 z-10 flex w-full cursor-default items-center justify-center bg-background py-1 font-base text-foreground",
      className,
      klass,
    )}
    {...props}
  >
    <ChevronDown class="size-4" />
  </SelectPrimitive.ScrollDownArrow>
}

function SelectContent({
  class: klass,
  className,
  children,
  side = "bottom",
  sideOffset = 4,
  align = "center",
  alignOffset = 0,
  alignItemWithTrigger = false,
  ...props
}: StyledProps<SelectPrimitive.Popup.Props> &
  Pick<
    SelectPrimitive.Positioner.Props,
    "align" | "alignOffset" | "side" | "sideOffset" | "alignItemWithTrigger"
  >) @{
  <SelectPrimitive.Portal>
    <SelectPrimitive.Positioner
      side={side}
      sideOffset={sideOffset}
      align={align}
      alignOffset={alignOffset}
      alignItemWithTrigger={alignItemWithTrigger}
      className="isolate z-50"
    >
      <SelectPrimitive.Popup
        data-slot="select-content"
        className={cn(
          "relative z-50 max-h-[min(24rem,var(--available-height))] min-w-(--anchor-width) overflow-x-hidden overflow-y-auto rounded-base border-2 border-border bg-background text-foreground outline-none origin-(--transform-origin) data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2",
          className,
          klass,
        )}
        {...props}
      >
        <SelectScrollUpButton />
        <SelectPrimitive.List data-slot="select-list" className="p-1">
          {children}
        </SelectPrimitive.List>
        <SelectScrollDownButton />
      </SelectPrimitive.Popup>
    </SelectPrimitive.Positioner>
  </SelectPrimitive.Portal>
}

function SelectLabel({
  class: klass,
  className,
  ...props
}: StyledProps<SelectPrimitive.GroupLabel.Props>) @{
  <SelectPrimitive.GroupLabel
    data-slot="select-label"
    className={cn(
      "border-2 border-transparent py-1.5 pr-8 pl-2 text-sm font-base text-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

function SelectItem({
  class: klass,
  className,
  children,
  ...props
}: StyledProps<SelectPrimitive.Item.Props>) @{
  <SelectPrimitive.Item
    data-slot="select-item"
    className={cn(
      "relative flex w-full cursor-default select-none items-center gap-2 rounded-base py-1.5 pr-8 pl-2 text-sm border-2 border-transparent font-base outline-none hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4",
      className,
      klass,
    )}
    {...props}
  >
    <SelectPrimitive.ItemText
      data-slot="select-item-text"
      className="flex flex-1 items-center gap-2 whitespace-nowrap"
    >
      {children}
    </SelectPrimitive.ItemText>
    <SelectPrimitive.ItemIndicator
      data-slot="select-item-indicator"
      render={
        <span className="pointer-events-none absolute right-2 flex size-3.5 items-center justify-center" />
      }
    >
      <Check class="size-4" />
    </SelectPrimitive.ItemIndicator>
  </SelectPrimitive.Item>
}

function SelectSeparator({
  class: klass,
  className,
  ...props
}: StyledProps<SelectPrimitive.Separator.Props>) @{
  <SelectPrimitive.Separator
    data-slot="select-separator"
    className={cn("-mx-1 my-1 h-px bg-border", className, klass)}
    {...props}
  />
}

export {
  Select,
  SelectGroup,
  SelectValue,
  SelectTrigger,
  SelectContent,
  SelectLabel,
  SelectItem,
  SelectSeparator,
  SelectScrollUpButton,
  SelectScrollDownButton,
}
