import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  Field,
  FieldContent,
  FieldDescription,
  FieldGroup,
  FieldLabel,
} from "@/components/ui/field.tsrx"

export default function CheckboxDescriptionDemo() @{
  <FieldGroup class="mx-auto w-72">
    <Field orientation="horizontal">
      <Checkbox
        id="terms-checkbox-desc"
        name="terms-checkbox-desc"
        defaultChecked
      />
      <FieldContent>
        <FieldLabel for="terms-checkbox-desc">
          Accept terms and conditions
        </FieldLabel>
        <FieldDescription>
          By clicking this checkbox, you agree to the terms and conditions.
        </FieldDescription>
      </FieldContent>
    </Field>
  </FieldGroup>
}
