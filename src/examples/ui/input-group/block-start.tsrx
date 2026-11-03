import { InfoIcon } from "@octanejs/lucide"

import {
  InputGroup,
  InputGroupAddon,
  InputGroupInput,
  InputGroupText,
} from "@/components/ui/input-group.tsrx"

export default function InputGroupBlockStartDemo() @{
  <InputGroup class="max-w-sm">
    <InputGroupInput placeholder="John" />
    <InputGroupAddon align="block-start">
      <InputGroupText class="font-heading text-foreground">
        First Name
      </InputGroupText>
      <InfoIcon class="ml-auto" />
    </InputGroupAddon>
  </InputGroup>
}
