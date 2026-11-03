import {
  NativeSelect,
  NativeSelectOption,
} from "@/components/ui/native-select.tsrx"

export default function NativeSelectDisabledDemo() @{
  <NativeSelect class="w-full max-w-xs" disabled>
    <NativeSelectOption value="">Disabled</NativeSelectOption>
    <NativeSelectOption value="apple">Apple</NativeSelectOption>
    <NativeSelectOption value="banana">Banana</NativeSelectOption>
    <NativeSelectOption value="blueberry">Blueberry</NativeSelectOption>
  </NativeSelect>
}
