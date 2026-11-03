import { Button } from "@/components/ui/button.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function PopoverAlignDemo() @{
  <div class="flex gap-6">
    <Popover>
      <PopoverTrigger render={<Button variant="noShadow" size="sm" />}>
        Start
      </PopoverTrigger>
      <PopoverContent align="start" class="w-40">
        Aligned to start
      </PopoverContent>
    </Popover>
    <Popover>
      <PopoverTrigger render={<Button variant="noShadow" size="sm" />}>
        Center
      </PopoverTrigger>
      <PopoverContent align="center" class="w-40">
        Aligned to center
      </PopoverContent>
    </Popover>
    <Popover>
      <PopoverTrigger render={<Button variant="noShadow" size="sm" />}>
        End
      </PopoverTrigger>
      <PopoverContent align="end" class="w-40">
        Aligned to end
      </PopoverContent>
    </Popover>
  </div>
}
