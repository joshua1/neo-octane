import { Checkbox } from "@/components/ui/checkbox.tsrx"
import { Field, FieldGroup, FieldLabel } from "@/components/ui/field.tsrx"

export default function CheckboxInvalidStateDemo() @{
  <FieldGroup class="mx-auto w-56">
    <Field orientation="horizontal" data-invalid>
      <Checkbox
        id="terms-checkbox-invalid"
        name="terms-checkbox-invalid"
        aria-invalid
      />
      <FieldLabel for="terms-checkbox-invalid">
        Accept terms and conditions
      </FieldLabel>
    </Field>
  </FieldGroup>
}
