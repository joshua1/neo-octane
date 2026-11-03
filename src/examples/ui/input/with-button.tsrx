import { Button } from "@/components/ui/button.tsrx"
import { Input } from "@/components/ui/input.tsrx"

export default function InputWithButtonDemo() @{
  <div class="flex w-full max-w-sm items-center space-x-2">
    <Input type="email" placeholder="Email" />
    <Button variant="noShadow" type="submit">
      Subscribe
    </Button>
  </div>
}
