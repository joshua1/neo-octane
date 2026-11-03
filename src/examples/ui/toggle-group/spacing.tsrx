import {
  AlignCenterIcon,
  AlignLeftIcon,
  AlignRightIcon,
} from "@octanejs/lucide"

import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group.tsrx"

export default function ToggleGroupSpacingDemo() @{
  <ToggleGroup spacing={0} defaultValue={["left"]}>
    <ToggleGroupItem value="left" aria-label="Align left">
      <AlignLeftIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="center" aria-label="Align center">
      <AlignCenterIcon />
    </ToggleGroupItem>
    <ToggleGroupItem value="right" aria-label="Align right">
      <AlignRightIcon />
    </ToggleGroupItem>
  </ToggleGroup>
}
