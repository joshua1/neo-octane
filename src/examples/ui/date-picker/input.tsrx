import { useState } from "octane"
import { CalendarIcon } from "@octanejs/lucide"

import { Calendar } from "@/components/ui/calendar.tsrx"
import { Field, FieldLabel } from "@/components/ui/field.tsrx"
import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
} from "@/components/ui/input-group.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

function formatDate(date: Date | undefined) {
  if (!date) {
    return ""
  }

  return date.toLocaleDateString("en-US", {
    day: "2-digit",
    month: "long",
    year: "numeric",
  })
}

function isValidDate(date: Date | undefined) {
  if (!date) {
    return false
  }
  return !isNaN(date.getTime())
}

export default function DatePickerInputDemo() @{
  const [open, setOpen] = useState(false)
  const [date, setDate] = useState<Date | undefined>(new Date("2025-06-01"))
  const [month, setMonth] = useState<Date | undefined>(date)
  const [value, setValue] = useState(formatDate(date))

  <Field class="mx-auto w-48">
    <FieldLabel for="date-required">Subscription Date</FieldLabel>
    <InputGroup>
      <InputGroupInput
        id="date-required"
        value={value}
        placeholder="June 01, 2025"
        onInput={(e: InputEvent) => {
          const inputValue = (e.currentTarget as HTMLInputElement).value
          const date = new Date(inputValue)
          setValue(inputValue)
          if (isValidDate(date)) {
            setDate(date)
            setMonth(date)
          }
        }}
        onKeyDown={(e: KeyboardEvent) => {
          if (e.key === "ArrowDown") {
            e.preventDefault()
            setOpen(true)
          }
        }}
      />
      <InputGroupAddon align="inline-end">
        <Popover open={open} onOpenChange={setOpen}>
          <PopoverTrigger
            render={
              <InputGroupButton
                id="date-picker"
                size="icon-xs"
                aria-label="Select date"
              />
            }
          >
            <CalendarIcon />
            <span class="sr-only">Select date</span>
          </PopoverTrigger>
          <PopoverContent
            class="w-auto overflow-hidden border-0! p-0"
            align="end"
            alignOffset={-8}
            sideOffset={10}
          >
            <Calendar
              mode="single"
              selected={date}
              month={month}
              onMonthChange={setMonth}
              onSelect={(date) => {
                setDate(date)
                setValue(formatDate(date))
                setOpen(false)
              }}
            />
          </PopoverContent>
        </Popover>
      </InputGroupAddon>
    </InputGroup>
  </Field>
}
