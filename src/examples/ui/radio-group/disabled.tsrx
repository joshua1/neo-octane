import { Field, FieldLabel } from "@/components/ui/field.tsrx"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group.tsrx"

export default function RadioGroupDisabledDemo() @{
  <RadioGroup defaultValue="option2" class="w-fit">
    <Field orientation="horizontal" data-disabled>
      <RadioGroupItem value="option1" id="disabled-1" disabled />
      <FieldLabel for="disabled-1" class="font-base">
        Disabled
      </FieldLabel>
    </Field>
    <Field orientation="horizontal">
      <RadioGroupItem value="option2" id="disabled-2" />
      <FieldLabel for="disabled-2" class="font-base">
        Option 2
      </FieldLabel>
    </Field>
    <Field orientation="horizontal">
      <RadioGroupItem value="option3" id="disabled-3" />
      <FieldLabel for="disabled-3" class="font-base">
        Option 3
      </FieldLabel>
    </Field>
  </RadioGroup>
}
