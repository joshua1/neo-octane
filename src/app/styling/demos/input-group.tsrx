import { SearchIcon } from "@octanejs/lucide"

import {
  InputGroup,
  InputGroupAddon,
  InputGroupInput,
} from "@/components/ui/input-group.tsrx"
import { Kbd } from "@/components/ui/kbd.tsrx"

export default function InputGroupDemo() @{
  <InputGroup class="w-full">
    <InputGroupInput placeholder="Search components..." />
    <InputGroupAddon>
      <SearchIcon />
    </InputGroupAddon>
    <InputGroupAddon align="inline-end">
      <Kbd>⌘K</Kbd>
    </InputGroupAddon>
  </InputGroup>
}
