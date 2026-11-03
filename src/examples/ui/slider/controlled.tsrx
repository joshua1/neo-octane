import { useState } from "octane"

import { Label } from "@/components/ui/label.tsrx"
import { Slider } from "@/components/ui/slider.tsrx"

export default function SliderControlled() @{
  const [value, setValue] = useState([0.3, 0.7])

  <div class="grid w-full gap-3">
    <div class="flex items-center justify-between gap-2">
      <Label for="slider-demo-temperature">Temperature</Label>
      <span class="text-foreground font-base text-sm">{value.join(", ")}</span>
    </div>
    <Slider
      id="slider-demo-temperature"
      value={value}
      onValueChange={(value: number | readonly number[]) =>
        setValue(value as number[])
      }
      min={0}
      max={1}
      step={0.1}
    />
  </div>
}
