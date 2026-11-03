import { Input } from "@/components/ui/input.tsrx"
import { Label } from "@/components/ui/label.tsrx"

export default function InputFileDemo() @{
  <div class="grid w-full max-w-64 items-center gap-1.5">
    <Label for="picture">Picture</Label>
    <Input id="picture" type="file" />
  </div>
}
