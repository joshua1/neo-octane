import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select.tsrx"

const fruits = {
  apple: "Apple",
  banana: "Banana",
  blueberry: "Blueberry",
  grapes: "Grapes",
  pineapple: "Pineapple",
}

export default function SelectDemo() @{
  <Select disabled items={fruits}>
    <SelectTrigger class="w-[180px]">
      <SelectValue placeholder="Disabled" />
    </SelectTrigger>
    <SelectContent>
      <SelectItem value="apple">Apple</SelectItem>
      <SelectItem value="banana">Banana</SelectItem>
      <SelectItem value="blueberry">Blueberry</SelectItem>
      <SelectItem value="grapes" disabled>
        Grapes
      </SelectItem>
      <SelectItem value="pineapple">Pineapple</SelectItem>
    </SelectContent>
  </Select>
}
