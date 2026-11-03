import { useState } from "octane"
import { format } from "date-fns"
import { Calendar as CalendarIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { Calendar } from "@/components/ui/calendar.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function DatePickerDemo() @{
  const [date, setDate] = useState<Date>()

  <Popover>
    <PopoverTrigger
      render={
        <Button
          variant="noShadow"
          class="w-[280px] justify-start text-left font-base"
        />
      }
    >
      <CalendarIcon />
      @if (date) {
        {
          format(date, "PPP") as string
        }
      } @else {
        <span>Pick a date</span>
      }
    </PopoverTrigger>
    <PopoverContent class="w-auto border-0! p-0">
      <Calendar mode="single" selected={date} onSelect={setDate} autoFocus />
    </PopoverContent>
  </Popover>
}
