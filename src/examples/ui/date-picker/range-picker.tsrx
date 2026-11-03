import { useState } from "octane"
import { addDays, format } from "date-fns"
import { CalendarIcon } from "@octanejs/lucide"
import { type DateRange } from "@octanejs/day-picker"

import { Button } from "@/components/ui/button.tsrx"
import { Calendar } from "@/components/ui/calendar.tsrx"
import { Field, FieldLabel } from "@/components/ui/field.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function DatePickerRangePickerDemo() @{
  const [date, setDate] = useState<DateRange | undefined>({
    from: new Date(new Date().getFullYear(), 0, 20),
    to: addDays(new Date(new Date().getFullYear(), 0, 20), 20),
  })

  <Field class="mx-auto w-60">
    <FieldLabel for="date-picker-range">Date Picker Range</FieldLabel>
    <Popover>
      <PopoverTrigger
        render={
          <Button
            variant="noShadow"
            id="date-picker-range"
            class="justify-start px-2.5 font-base"
          />
        }
      >
        <CalendarIcon />
        @if (date?.from) {
          @if (date.to) {
            <>
              {format(date.from, "LLL dd, y") as string} -{" "}
              {format(date.to, "LLL dd, y") as string}
            </>
          } @else {
            {
              format(date.from, "LLL dd, y") as string
            }
          }
        } @else {
          <span>Pick a date</span>
        }
      </PopoverTrigger>
      <PopoverContent class="w-auto border-0! p-0" align="start">
        <Calendar
          mode="range"
          defaultMonth={date?.from}
          selected={date}
          onSelect={setDate}
          numberOfMonths={2}
        />
      </PopoverContent>
    </Popover>
  </Field>
}
