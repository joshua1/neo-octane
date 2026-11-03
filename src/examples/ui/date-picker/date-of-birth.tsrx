import { useState } from "octane"
import { Button } from "@/components/ui/button.tsrx"
import { Calendar } from "@/components/ui/calendar.tsrx"
import { Field, FieldLabel } from "@/components/ui/field.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function DatePickerDateOfBirthDemo() @{
  const [open, setOpen] = useState(false)
  const [date, setDate] = useState<Date | undefined>(undefined)

  <Field class="mx-auto w-44">
    <FieldLabel for="date-picker-dob">Date of birth</FieldLabel>
    <Popover open={open} onOpenChange={setOpen}>
      <PopoverTrigger
        render={
          <Button
            variant="noShadow"
            id="date-picker-dob"
            class="justify-start font-base"
          />
        }
      >
        {(date ? date.toLocaleDateString() : "Select date") as string}
      </PopoverTrigger>
      <PopoverContent
        class="w-auto overflow-hidden border-0! p-0"
        align="start"
      >
        <Calendar
          mode="single"
          selected={date}
          defaultMonth={date}
          captionLayout="dropdown"
          onSelect={(date) => {
            setDate(date)
            setOpen(false)
          }}
        />
      </PopoverContent>
    </Popover>
  </Field>
}
