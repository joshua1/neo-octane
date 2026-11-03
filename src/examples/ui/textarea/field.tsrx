import { Field, FieldDescription, FieldLabel } from "@/components/ui/field.tsrx"
import { Textarea } from "@/components/ui/textarea.tsrx"

export default function TextareaFieldDemo() @{
  <Field class="max-w-xs">
    <FieldLabel for="textarea-message">Message</FieldLabel>
    <FieldDescription>Enter your message below.</FieldDescription>
    <Textarea id="textarea-message" placeholder="Type your message here." />
  </Field>
}
