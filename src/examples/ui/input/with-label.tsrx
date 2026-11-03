import { Input } from "@/components/ui/input.tsrx"
import { Label } from "@/components/ui/label.tsrx"

export default function InputWithLabelDemo() @{
  <div class="grid max-w-[200px] items-center gap-1.5">
    <Label for="email">Email</Label>
    <Input type="email" id="email" placeholder="Email" />
  </div>
}
