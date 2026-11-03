import { Label } from "@/components/ui/label.tsrx"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group.tsrx"

export default function RadioGroupDemo() @{
  <RadioGroup defaultValue="comfortable">
    <div class="flex items-center space-x-2">
      <RadioGroupItem value="default" id="r1" />
      <Label for="r1">Default</Label>
    </div>
    <div class="flex items-center space-x-2">
      <RadioGroupItem value="comfortable" id="r2" />
      <Label for="r2">Comfortable</Label>
    </div>
    <div class="flex items-center space-x-2">
      <RadioGroupItem value="compact" id="r3" />
      <Label for="r3">Compact</Label>
    </div>
  </RadioGroup>
}
