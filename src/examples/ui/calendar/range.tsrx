import { addDays } from "date-fns"
import type { DateRange } from "@octanejs/day-picker"

import { useState } from "octane"

import { Calendar } from "@/components/ui/calendar.tsrx"

export default function CalendarRangeDemo() @{
  const [dateRange, setDateRange] = useState<DateRange | undefined>({
    from: new Date(new Date().getFullYear(), 0, 12),
    to: addDays(new Date(new Date().getFullYear(), 0, 12), 30),
  })

  <Calendar
    mode="range"
    defaultMonth={dateRange?.from}
    selected={dateRange}
    onSelect={setDateRange}
    numberOfMonths={2}
    disabled={(date: Date) =>
      date > new Date() || date < new Date("1900-01-01")
    }
  />
}
