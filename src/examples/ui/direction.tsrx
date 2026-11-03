import { ArrowRightIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { DirectionProvider } from "@/components/ui/direction.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function DirectionDemo() @{
  <DirectionProvider direction="rtl">
    <div dir="rtl" class="flex flex-col items-start gap-4">
      <Popover>
        <PopoverTrigger render={<Button variant="neutral" />}>
          افتح القائمة
          <ArrowRightIcon />
        </PopoverTrigger>
        <PopoverContent side="inline-end" align="start">
          <p class="text-sm font-base">
            This popover opens on the inline end side. In RTL that is the left,
            because the provider tells Base UI which direction to use.
          </p>
        </PopoverContent>
      </Popover>
    </div>
  </DirectionProvider>
}
