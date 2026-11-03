import { SaveIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { Kbd } from "@/components/ui/kbd.tsrx"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip.tsrx"

export default function TooltipWithKeyboardShortcutDemo() @{
  <TooltipProvider>
    <Tooltip>
      <TooltipTrigger render={<Button variant="noShadow" size="icon" />}>
        <SaveIcon />
      </TooltipTrigger>
      <TooltipContent>
        Save Changes <Kbd>S</Kbd>
      </TooltipContent>
    </Tooltip>
  </TooltipProvider>
}
