import {
  Field,
  FieldContent,
  FieldDescription,
  FieldLabel,
} from "@/components/ui/field.tsrx"
import { Switch } from "@/components/ui/switch.tsrx"

export default function SwitchInvalidDemo() @{
  <Field orientation="horizontal" class="max-w-sm" data-invalid>
    <FieldContent>
      <FieldLabel for="switch-terms">Accept terms and conditions</FieldLabel>
      <FieldDescription>
        You must accept the terms and conditions to continue.
      </FieldDescription>
    </FieldContent>
    <Switch id="switch-terms" aria-invalid />
  </Field>
}
