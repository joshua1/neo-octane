import { SendIcon } from "@octanejs/lucide"

import {
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupText,
  InputGroupTextarea,
} from "@/components/ui/input-group.tsrx"

export default function InputGroupTextareaDemo() @{
  <InputGroup class="max-w-md">
    <InputGroupTextarea placeholder="Ask anything..." />
    <InputGroupAddon align="block-end" class="border-t-2 border-border">
      <InputGroupText>Markdown supported</InputGroupText>
      <InputGroupButton
        variant="default"
        size="icon-sm"
        class="ml-auto"
        aria-label="Send"
      >
        <SendIcon />
      </InputGroupButton>
    </InputGroupAddon>
  </InputGroup>
}
