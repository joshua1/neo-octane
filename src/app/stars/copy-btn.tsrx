import { Check, Copy } from "@octanejs/lucide"
import { useState } from "octane"

import { Button } from "@/components/ui/button.tsrx"
import {
  Tooltip,
  TooltipContent,
  TooltipTrigger,
} from "@/components/ui/tooltip.tsrx"

export default function CopyBtn({ code }: { code: string }) @{
  const [copied, setCopied] = useState(false)

  const handleCopy = () => {
    if (copied) return

    navigator.clipboard.writeText(code)
    setCopied(true)
    setTimeout(() => setCopied(false), 2000)
  }

  <Tooltip>
    <TooltipTrigger render={<Button onClick={handleCopy} variant="noShadow" />}>
      Copy
      @if (copied) {
        <Check class="size-[18px]" />
      } @else {
        <Copy class="size-[18px]" />
      }
    </TooltipTrigger>
    <TooltipContent>
      <p>Copy to clipboard</p>
    </TooltipContent>
  </Tooltip>
}
