import { UnderlineIcon } from "@octanejs/lucide"

import { Toggle } from "@/components/ui/toggle.tsrx"

export default function ToggleDisabledDemo() @{
  <Toggle aria-label="Toggle underline" disabled>
    <UnderlineIcon />
  </Toggle>
}
