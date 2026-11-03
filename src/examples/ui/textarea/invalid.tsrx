import { Field, FieldDescription, FieldLabel } from "@/components/ui/field.tsrx"
import { Textarea } from "@/components/ui/textarea.tsrx"

export default function TextareaInvalidDemo() @{
  <Field data-invalid class="max-w-xs">
    <FieldLabel for="textarea-invalid">Message</FieldLabel>
    <Textarea
      id="textarea-invalid"
      placeholder="Type your message here."
      aria-invalid
    />
    <FieldDescription>Please enter a valid message.</FieldDescription>
  </Field>
}
