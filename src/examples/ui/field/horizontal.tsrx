import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  Field,
  FieldContent,
  FieldDescription,
  FieldGroup,
  FieldLabel,
} from "@/components/ui/field.tsrx"
import { Switch } from "@/components/ui/switch.tsrx"

export default function FieldHorizontalDemo() @{
  <FieldGroup class="max-w-md">
    <Field orientation="horizontal">
      <FieldContent>
        <FieldLabel for="field-airplane">Airplane Mode</FieldLabel>
        <FieldDescription>
          Turn on airplane mode to disable all connections.
        </FieldDescription>
      </FieldContent>
      <Switch id="field-airplane" />
    </Field>
    <Field orientation="horizontal">
      <Checkbox id="field-newsletter" defaultChecked />
      <FieldContent>
        <FieldLabel for="field-newsletter">Subscribe to newsletter</FieldLabel>
        <FieldDescription>
          Receive weekly updates about new features and promotions.
        </FieldDescription>
      </FieldContent>
    </Field>
  </FieldGroup>
}
