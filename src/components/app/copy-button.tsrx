import { Check, Clipboard } from "@octanejs/lucide"
import { useState } from "octane"

import { Button } from "@/components/ui/button.tsrx"

export function CopyButton({ text }: { text: string }) @{
  const [isCopied, setIsCopied] = useState(false)

  const copy = async () => {
    await navigator.clipboard.writeText(text)
    setIsCopied(true)

    setTimeout(() => {
      setIsCopied(false)
    }, 1500)
  }

  <Button
    size="icon"
    class="size-9 absolute right-3.5 top-2"
    variant="noShadow"
    onClick={copy}
    aria-label="Copy"
  >
    <span class="sr-only">Copy</span>
    @if (isCopied) {
      <Check />
    } @else {
      <Clipboard />
    }
  </Button>
}
