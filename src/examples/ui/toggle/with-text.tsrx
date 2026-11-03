import { ItalicIcon } from "@octanejs/lucide"

import { Toggle } from "@/components/ui/toggle.tsrx"

export default function ToggleWithTextDemo() @{
  <Toggle aria-label="Toggle italic">
    <ItalicIcon />
    Italic
  </Toggle>
}
