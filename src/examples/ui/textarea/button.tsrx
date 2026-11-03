import { Button } from "@/components/ui/button.tsrx"
import { Textarea } from "@/components/ui/textarea.tsrx"

export default function TextareaButtonDemo() @{
  <div class="grid w-full max-w-xs gap-2">
    <Textarea placeholder="Type your message here." />
    <Button>Send message</Button>
  </div>
}
