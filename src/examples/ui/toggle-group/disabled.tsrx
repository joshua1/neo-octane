import { BoldIcon, ItalicIcon, UnderlineIcon } from "@octanejs/lucide"

import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group.tsrx"

export default function ToggleGroupDisabledDemo() @{
  <ToggleGroup disabled>
    <ToggleGroupItem value="bold" aria-label="Toggle bold">
      <BoldIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="italic" aria-label="Toggle italic">
      <ItalicIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="strikethrough" aria-label="Toggle strikethrough">
      <UnderlineIcon />
    </ToggleGroupItem>
  </ToggleGroup>
}
