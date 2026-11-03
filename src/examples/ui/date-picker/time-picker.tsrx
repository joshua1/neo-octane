import { useState } from "octane"
import { format } from "date-fns"
import { ChevronDownIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { Calendar } from "@/components/ui/calendar.tsrx"
import { Field, FieldGroup, FieldLabel } from "@/components/ui/field.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function DatePickerTimePickerDemo() @{
  const [open, setOpen] = useState(false)
  const [date, setDate] = useState<Date | undefined>(undefined)

  <FieldGroup class="mx-auto max-w-xs flex-row">
    <Field>
      <FieldLabel for="date-picker-optional">Date</FieldLabel>
      <Popover open={open} onOpenChange={setOpen}>
        <PopoverTrigger
          render={
            <Button
              variant="noShadow"
              id="date-picker-optional"
              class="w-32 justify-between font-base"
            />
          }
        >
          {(date ? format(date, "PPP") : "Select date") as string}
          <ChevronDownIcon />
        </PopoverTrigger>
        <PopoverContent
          class="w-auto overflow-hidden border-0! p-0"
          align="start"
        >
          <Calendar
            mode="single"
            selected={date}
            captionLayout="dropdown"
            defaultMonth={date}
            onSelect={(date) => {
              setDate(date)
              setOpen(false)
            }}
          />
        </PopoverContent>
      </Popover>
    </Field>
    <Field class="w-32">
      <FieldLabel for="time-picker-optional">Time</FieldLabel>
      <Input
        type="time"
        id="time-picker-optional"
        step="1"
        defaultValue="10:30:00"
        class="appearance-none [&::-webkit-calendar-picker-indicator]:hidden [&::-webkit-calendar-picker-indicator]:appearance-none"
      />
    </Field>
  </FieldGroup>
}
