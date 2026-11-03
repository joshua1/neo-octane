import {
  NativeSelect,
  NativeSelectOption,
} from "@/components/ui/native-select.tsrx"

export default function NativeSelectDemo() @{
  <NativeSelect class="w-full max-w-xs">
    <NativeSelectOption value="">Select a fruit</NativeSelectOption>
    <NativeSelectOption value="apple">Apple</NativeSelectOption>
    <NativeSelectOption value="banana">Banana</NativeSelectOption>
    <NativeSelectOption value="blueberry">Blueberry</NativeSelectOption>
    <NativeSelectOption value="grapes" disabled>
      Grapes
    </NativeSelectOption>
    <NativeSelectOption value="pineapple">Pineapple</NativeSelectOption>
  </NativeSelect>
}
