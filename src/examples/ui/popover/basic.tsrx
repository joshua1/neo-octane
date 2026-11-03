import { Button } from "@/components/ui/button.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverDescription,
  PopoverHeader,
  PopoverTitle,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function PopoverBasicDemo() @{
  <Popover>
    <PopoverTrigger render={<Button variant="noShadow" class="w-fit" />}>
      Open Popover
    </PopoverTrigger>
    <PopoverContent align="start">
      <PopoverHeader>
        <PopoverTitle>Dimensions</PopoverTitle>
        <PopoverDescription>
          Set the dimensions for the layer.
        </PopoverDescription>
      </PopoverHeader>
    </PopoverContent>
  </Popover>
}
