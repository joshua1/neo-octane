import { BoldIcon, ItalicIcon } from "@octanejs/lucide"

import { Toggle } from "@/components/ui/toggle.tsrx"

export default function ToggleOutlineDemo() @{
  <div class="flex items-center gap-2">
    <Toggle variant="outline" aria-label="Toggle bold" defaultPressed>
      <BoldIcon />
      Bold
    </Toggle>
    <Toggle variant="outline" aria-label="Toggle italic">
      <ItalicIcon />
      Italic
    </Toggle>
  </div>
}
