import { Field, FieldLabel } from "@/components/ui/field.tsrx"
import { Switch } from "@/components/ui/switch.tsrx"

export default function SwitchDisabledDemo() @{
  <Field orientation="horizontal" data-disabled class="w-fit">
    <Switch id="switch-disabled-unchecked" disabled />
    <FieldLabel for="switch-disabled-unchecked">Disabled</FieldLabel>
  </Field>
}
