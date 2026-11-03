import { ChevronDownIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { ButtonGroup } from "@/components/ui/button-group.tsrx"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu.tsrx"

export default function ButtonGroupWithDropdownDemo() @{
  <ButtonGroup>
    <Button variant="neutral">Update</Button>
    <DropdownMenu>
      <DropdownMenuTrigger
        render={
          <Button variant="neutral" size="icon" aria-label="More options" />
        }
      >
        <ChevronDownIcon />
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end">
        <DropdownMenuItem>Disable</DropdownMenuItem>
        <DropdownMenuItem>Uninstall</DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  </ButtonGroup>
}
