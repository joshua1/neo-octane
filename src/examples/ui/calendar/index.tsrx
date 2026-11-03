import { useState } from "octane"

import { Calendar } from "@/components/ui/calendar.tsrx"

export default function CalendarDemo() @{
  const [date, setDate] = useState<Date | undefined>(new Date())

  <Calendar mode="single" selected={date} onSelect={setDate} />
}
