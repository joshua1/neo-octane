import { useState } from "octane"
import { format } from "date-fns"

import { Button } from "@/components/ui/button.tsrx"
import { Calendar } from "@/components/ui/calendar.tsrx"
import { Field, FieldLabel } from "@/components/ui/field.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function DatePickerBasicDemo() @{
  const [date, setDate] = useState<Date>()

  <Field class="mx-auto w-44">
    <FieldLabel for="date-picker-simple">Date</FieldLabel>
    <Popover>
      <PopoverTrigger
        render={
          <Button
            variant="noShadow"
            id="date-picker-simple"
            class="justify-start font-base"
          />
        }
      >
        @if (date) {
          {
            format(date, "PPP") as string
          }
        } @else {
          <span>Pick a date</span>
        }
      </PopoverTrigger>
      <PopoverContent class="w-auto border-0! p-0" align="start">
        <Calendar
          mode="single"
          selected={date}
          onSelect={setDate}
          defaultMonth={date}
        />
      </PopoverContent>
    </Popover>
  </Field>
}
