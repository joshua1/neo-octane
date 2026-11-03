import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select.tsrx"

const items = Array.from({ length: 100 }, (_, i) => ({
  value: `item-${i}`,
  label: `Item ${i}`,
}))

export default function SelectDemo() @{
  <Select items={items}>
    <SelectTrigger class="w-[180px]">
      <SelectValue placeholder="Large List" />
    </SelectTrigger>
    <SelectContent>
      @for (const item of items; key item.value) {
        <SelectItem value={item.value}>{item.label as string}</SelectItem>
      }
    </SelectContent>
  </Select>
}
