import {
  Field,
  FieldDescription,
  FieldLabel,
  FieldLegend,
  FieldSet,
} from "@/components/ui/field.tsrx"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group.tsrx"

export default function RadioGroupInvalidDemo() @{
  <FieldSet class="w-full max-w-xs">
    <FieldLegend variant="label">Notification Preferences</FieldLegend>
    <FieldDescription>
      Choose how you want to receive notifications.
    </FieldDescription>
    <RadioGroup defaultValue="email">
      <Field orientation="horizontal" data-invalid>
        <RadioGroupItem value="email" id="invalid-email" aria-invalid />
        <FieldLabel for="invalid-email" class="font-base">
          Email only
        </FieldLabel>
      </Field>
      <Field orientation="horizontal" data-invalid>
        <RadioGroupItem value="sms" id="invalid-sms" aria-invalid />
        <FieldLabel for="invalid-sms" class="font-base">
          SMS only
        </FieldLabel>
      </Field>
      <Field orientation="horizontal" data-invalid>
        <RadioGroupItem value="both" id="invalid-both" aria-invalid />
        <FieldLabel for="invalid-both" class="font-base">
          Both Email & SMS
        </FieldLabel>
      </Field>
    </RadioGroup>
  </FieldSet>
}
