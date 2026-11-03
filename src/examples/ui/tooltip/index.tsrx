import { Button } from "@/components/ui/button.tsrx"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip.tsrx"

export default function TooltipDemo() @{
  <TooltipProvider>
    <Tooltip>
      <TooltipTrigger render={<Button variant="noShadow" />}>
        Hover
      </TooltipTrigger>
      <TooltipContent>
        <p>Add to library</p>
      </TooltipContent>
    </Tooltip>
  </TooltipProvider>
}
