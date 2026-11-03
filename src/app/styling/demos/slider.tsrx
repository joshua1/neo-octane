import { Label } from "@/components/ui/label.tsrx"
import { Slider } from "@/components/ui/slider.tsrx"

export default function SliderDemo() @{
  <div class="grid w-full gap-3 text-foreground">
    <div class="flex items-center justify-between">
      <Label>Volume</Label>
      <span class="text-sm font-base">40%</span>
    </div>
    <Slider defaultValue={[40]} max={100} step={1} />
  </div>
}
