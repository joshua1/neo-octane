import { BoldIcon, ItalicIcon, UnderlineIcon } from "@octanejs/lucide"

import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group.tsrx"

export default function ToggleGroupVerticalDemo() @{
  <ToggleGroup multiple orientation="vertical" defaultValue={["italic"]}>
    <ToggleGroupItem value="bold" aria-label="Toggle bold">
      <BoldIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="italic" aria-label="Toggle italic">
      <ItalicIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="underline" aria-label="Toggle underline">
      <UnderlineIcon />
    </ToggleGroupItem>
  </ToggleGroup>
}
