import type { ClassValue } from "clsx"
import { useEffect, useRef } from "octane"
import {
  ChevronDown,
  ChevronLeft,
  ChevronRight,
  type LucideProps,
} from "@octanejs/lucide"
import {
  DayPicker,
  getDefaultClassNames,
  type ChevronProps,
  type DayButtonProps,
  type DayPickerProps,
  type RootProps,
  type WeekNumberProps,
} from "@octanejs/day-picker"

import { buttonVariants } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

export type CalendarProps = DayPickerProps & ClassProps

// These three are declared at module scope (not as inline arrows inside
// `components`) so each render passes stable component identities.
function CalendarRoot({ className, rootRef, ...props }: RootProps) @{
  <div data-slot="calendar" ref={rootRef} class={cn(className)} {...props} />
}

function CalendarChevron({ className, orientation, ...rest }: ChevronProps) @{
  // day-picker types `style` as `CSSProperties`; lucide accepts a style record.
  const props = rest as LucideProps

  <>
    @if (orientation === "left") {
      <ChevronLeft class={cn("size-4", className)} {...props} />
    } @else {
      @if (orientation === "right") {
        <ChevronRight class={cn("size-4", className)} {...props} />
      } @else {
        <ChevronDown class={cn("size-4", className)} {...props} />
      }
    }
  </>
}

function CalendarWeekNumber({ children, ...props }: WeekNumberProps) @{
  <td {...props}>
    <div class="flex size-9 items-center justify-center text-center">
      {children}
    </div>
  </td>
}

function Calendar({
  class: klass,
  className,
  classNames,
  showOutsideDays = true,
  captionLayout = "label",
  formatters,
  components,
  ...props
}: CalendarProps) @{
  const defaultClassNames = getDefaultClassNames()

  <DayPicker
    showOutsideDays={showOutsideDays}
    className={cn(
      "group/calendar rounded-base border-2 border-border bg-background p-3 font-heading text-foreground shadow-shadow",
      className,
      klass,
    )}
    captionLayout={captionLayout}
    formatters={{
      formatMonthDropdown: (date: Date) =>
        date.toLocaleString("default", { month: "short" }),
      ...formatters,
    }}
    classNames={{
      root: cn("w-fit", defaultClassNames.root),
      months: cn(
        "relative flex flex-col gap-2 sm:flex-row",
        defaultClassNames.months,
      ),
      month: cn("flex w-full flex-col gap-4", defaultClassNames.month),
      nav: cn(
        "absolute inset-x-0 top-0 flex w-full items-center justify-between gap-1",
        defaultClassNames.nav,
      ),
      button_previous: cn(
        buttonVariants({ variant: "noShadow" }),
        "size-7 bg-secondary-background p-0 text-foreground select-none aria-disabled:opacity-50",
        defaultClassNames.button_previous,
      ),
      button_next: cn(
        buttonVariants({ variant: "noShadow" }),
        "size-7 bg-secondary-background p-0 text-foreground select-none aria-disabled:opacity-50",
        defaultClassNames.button_next,
      ),
      month_caption: cn(
        "flex h-7 w-full items-center justify-center px-8",
        defaultClassNames.month_caption,
      ),
      dropdowns: cn(
        "flex h-7 w-full items-center justify-center gap-1.5 text-sm font-heading",
        defaultClassNames.dropdowns,
      ),
      dropdown_root: cn(
        "relative rounded-base border-2 border-border bg-secondary-background",
        defaultClassNames.dropdown_root,
      ),
      dropdown: cn("absolute inset-0 opacity-0", defaultClassNames.dropdown),
      caption_label: cn(
        "font-heading select-none",
        captionLayout === "label"
          ? "text-sm"
          : "flex h-7 items-center gap-1 rounded-base px-2 text-sm [&>svg]:size-3.5",
        defaultClassNames.caption_label,
      ),
      month_grid: cn("w-full border-collapse", defaultClassNames.month_grid),
      weekdays: cn("flex", defaultClassNames.weekdays),
      weekday: cn(
        "w-9 rounded-base text-[0.8rem] font-base text-foreground select-none",
        defaultClassNames.weekday,
      ),
      week: cn("mt-2 flex w-full", defaultClassNames.week),
      week_number_header: cn(
        "w-9 select-none",
        defaultClassNames.week_number_header,
      ),
      week_number: cn(
        "text-[0.8rem] font-base text-foreground select-none",
        defaultClassNames.week_number,
      ),
      day: cn(
        "group/day relative size-9 p-0 text-center text-sm select-none",
        defaultClassNames.day,
      ),
      range_start: cn(defaultClassNames.range_start),
      range_middle: cn(defaultClassNames.range_middle),
      range_end: cn(defaultClassNames.range_end),
      selected: cn(
        props.mode !== "range" && "rounded-base bg-main/50",
        defaultClassNames.selected,
      ),
      today: cn(defaultClassNames.today),
      outside: cn("opacity-50", defaultClassNames.outside),
      disabled: cn("opacity-50", defaultClassNames.disabled),
      hidden: cn("invisible", defaultClassNames.hidden),
      ...classNames,
    }}
    components={{
      Root: CalendarRoot,
      Chevron: CalendarChevron,
      DayButton: CalendarDayButton,
      WeekNumber: CalendarWeekNumber,
      ...components,
    }}
    {...props}
  />
}

function CalendarDayButton({
  class: klass,
  className,
  day,
  modifiers,
  ...props
}: DayButtonProps) @{
  const defaultClassNames = getDefaultClassNames()

  const ref = useRef<HTMLButtonElement | null>(null)
  useEffect(() => {
    if (modifiers.focused) ref.current?.focus()
  }, [modifiers.focused])

  const inRange =
    modifiers.range_start || modifiers.range_middle || modifiers.range_end
  const selectedSingle = modifiers.selected && !inRange

  <button
    ref={ref}
    data-day={day.date.toLocaleDateString()}
    data-selected-single={selectedSingle}
    data-range-start={modifiers.range_start}
    data-range-end={modifiers.range_end}
    data-range-middle={modifiers.range_middle}
    data-today={modifiers.today}
    class={cn(
      buttonVariants({ variant: "noShadow" }),
      "size-9 bg-secondary-background p-0 font-base text-foreground",
      modifiers.today && "bg-transparent",
      (selectedSingle || inRange) && "bg-main text-main-foreground",
      // Days of a range share one border per row: a day drops the border
      // and radius on each side that faces another day of the range, and
      // pads that side by the border width so the number stays centred.
      inRange &&
        "[[data-selected]:not([data-hidden])+td>&]:rounded-l-none [[data-selected]:not([data-hidden])+td>&]:border-l-0 [[data-selected]:not([data-hidden])+td>&]:pl-0.5 [td:has(+[data-selected]:not([data-hidden]))>&]:rounded-r-none [td:has(+[data-selected]:not([data-hidden]))>&]:border-r-0 [td:has(+[data-selected]:not([data-hidden]))>&]:pr-0.5",
      defaultClassNames.day_button,
      className,
      klass,
    )}
    {...props}
  />
}

export { Calendar, CalendarDayButton }
