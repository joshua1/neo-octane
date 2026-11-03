import { SearchIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { ButtonGroup } from "@/components/ui/button-group.tsrx"
import { Input } from "@/components/ui/input.tsrx"

export default function ButtonGroupWithInputDemo() @{
  <ButtonGroup class="w-full max-w-sm">
    <Input placeholder="Search..." />
    <Button variant="neutral" size="icon" aria-label="Search">
      <SearchIcon />
    </Button>
  </ButtonGroup>
}
