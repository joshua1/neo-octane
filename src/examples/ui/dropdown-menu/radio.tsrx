import { useState } from "octane"
import { Button } from "@/components/ui/button.tsrx"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuLabel,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu.tsrx"

export default function DropdownMenuRadioGroupDemo() @{
  const [position, setPosition] = useState("bottom")

  <DropdownMenu>
    <DropdownMenuTrigger render={<Button variant="noShadow" />}>
      Radio Group
    </DropdownMenuTrigger>
    <DropdownMenuContent align="start" class="w-56">
      <DropdownMenuLabel inset>Panel Position</DropdownMenuLabel>
      <DropdownMenuGroup>
        <DropdownMenuRadioGroup value={position} onValueChange={setPosition}>
          <DropdownMenuRadioItem value="top">Top</DropdownMenuRadioItem>
          <DropdownMenuRadioItem value="bottom">Bottom</DropdownMenuRadioItem>
          <DropdownMenuRadioItem value="right" disabled>
            Right
          </DropdownMenuRadioItem>
        </DropdownMenuRadioGroup>
      </DropdownMenuGroup>
    </DropdownMenuContent>
  </DropdownMenu>
}
