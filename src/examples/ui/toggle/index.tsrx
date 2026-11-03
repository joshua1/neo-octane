import { BoldIcon } from "@octanejs/lucide"

import { Toggle } from "@/components/ui/toggle.tsrx"

export default function ToggleDemo() @{
  <Toggle aria-label="Toggle bold" defaultPressed>
    <BoldIcon />
  </Toggle>
}
