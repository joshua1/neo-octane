import { useState } from "octane"

import { Progress } from "@/components/ui/progress.tsrx"
import { Slider } from "@/components/ui/slider.tsrx"

export default function ProgressControlledDemo() @{
  const [value, setValue] = useState(50)

  <div class="flex w-full max-w-sm flex-col gap-4">
    <Progress value={value} class="w-full" />
    <Slider
      value={value}
      onValueChange={(value: number | readonly number[]) =>
        setValue(value as number)
      }
      min={0}
      max={100}
      step={1}
    />
  </div>
}
