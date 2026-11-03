import { Button } from "@/components/ui/button.tsrx"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip.tsrx"

const TOOLTIP_SIDES = ["left", "top", "bottom", "right"] as const

export default function TooltipSideDemo() @{
  <TooltipProvider>
    <div class="flex flex-wrap justify-center gap-2">
      @for (const side of TOOLTIP_SIDES; key side) {
        <Tooltip>
          <TooltipTrigger
            render={<Button variant="noShadow" class="w-fit capitalize" />}
          >
            {side as string}
          </TooltipTrigger>
          <TooltipContent side={side}>
            <p>Add to library</p>
          </TooltipContent>
        </Tooltip>
      }
    </div>
  </TooltipProvider>
}
