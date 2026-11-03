import { Button } from "@/components/ui/button.tsrx"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip.tsrx"

export default function TooltipDisabledButtonDemo() @{
  <TooltipProvider>
    <Tooltip>
      <TooltipTrigger render={<span class="inline-block w-fit" />}>
        <Button variant="noShadow" disabled>
          Disabled
        </Button>
      </TooltipTrigger>
      <TooltipContent>
        <p>This feature is currently unavailable</p>
      </TooltipContent>
    </Tooltip>
  </TooltipProvider>
}
