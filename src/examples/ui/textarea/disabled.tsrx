import { Field, FieldLabel } from "@/components/ui/field.tsrx"
import { Textarea } from "@/components/ui/textarea.tsrx"

export default function TextareaDisabledDemo() @{
  <Field data-disabled class="max-w-xs">
    <FieldLabel for="textarea-disabled">Message</FieldLabel>
    <Textarea
      id="textarea-disabled"
      placeholder="Type your message here."
      disabled
    />
  </Field>
}
