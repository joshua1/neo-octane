import { Label } from "@/components/ui/label.tsrx"
import { Switch } from "@/components/ui/switch.tsrx"

export default function SwitchDemo() @{
  <div class="flex items-center space-x-2">
    <Switch id="airplane-mode" />
    <Label for="airplane-mode">Airplane Mode</Label>
  </div>
}
