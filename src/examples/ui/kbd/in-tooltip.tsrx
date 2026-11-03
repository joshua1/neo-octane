import { SaveIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { Kbd } from "@/components/ui/kbd.tsrx"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip.tsrx"

export default function KbdInTooltipDemo() @{
  <TooltipProvider>
    <Tooltip>
      <TooltipTrigger
        render={
          <Button
            variant="neutral"
            size="icon"
            class="shadow-none! hover:translate-x-0! hover:translate-y-0!"
          />
        }
      >
        <SaveIcon />
      </TooltipTrigger>
      <TooltipContent class="pr-1.5">
        <div class="flex items-center gap-2">
          Save Changes <Kbd>S</Kbd>
        </div>
      </TooltipContent>
    </Tooltip>
  </TooltipProvider>
}
