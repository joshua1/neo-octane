import { MinusIcon, PlusIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { ButtonGroup } from "@/components/ui/button-group.tsrx"

export default function ButtonGroupVerticalDemo() @{
  <ButtonGroup orientation="vertical" aria-label="Zoom controls">
    <Button variant="neutral" size="icon" aria-label="Zoom in">
      <PlusIcon />
    </Button>
    <Button variant="neutral" size="icon" aria-label="Zoom out">
      <MinusIcon />
    </Button>
  </ButtonGroup>
}
