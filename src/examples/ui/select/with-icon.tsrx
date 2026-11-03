import {
  ChartBarIcon,
  ChartLineIcon,
  ChartPieIcon,
  CircleDashed,
} from "@octanejs/lucide"

import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select.tsrx"

const charts = [
  {
    value: "line",
    label: (
      <>
        <ChartLineIcon />
        Line
      </>
    ),
  },
  {
    value: "bar",
    label: (
      <>
        <ChartBarIcon />
        Bar
      </>
    ),
  },
  {
    value: "pie",
    label: (
      <>
        <ChartPieIcon />
        Pie
      </>
    ),
  },
]

export default function SelectDemo() @{
  <Select items={charts}>
    <SelectTrigger class="w-[180px]">
      <SelectValue
        placeholder={
          <>
            <CircleDashed />
            With Icon
          </>
        }
      />
    </SelectTrigger>
    <SelectContent>
      @for (const chart of charts; key chart.value) {
        <SelectItem value={chart.value}>{chart.label}</SelectItem>
      }
    </SelectContent>
  </Select>
}
