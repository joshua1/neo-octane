import { Button } from "@/components/ui/button.tsrx"
import {
  Field,
  FieldDescription,
  FieldGroup,
  FieldLabel,
  FieldLegend,
  FieldSet,
} from "@/components/ui/field.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import { Textarea } from "@/components/ui/textarea.tsrx"

export default function FieldDemo() @{
  <form
    class="w-full max-w-md"
    onSubmit={(e: SubmitEvent) => {
      e.preventDefault()
    }}
  >
    <FieldSet>
      <FieldLegend>Contact us</FieldLegend>
      <FieldDescription>
        Fill in the form and we will get back to you.
      </FieldDescription>
      <FieldGroup>
        <Field>
          <FieldLabel for="field-name">Name</FieldLabel>
          <Input id="field-name" placeholder="John Doe" />
        </Field>
        <Field>
          <FieldLabel for="field-email">Email</FieldLabel>
          <Input id="field-email" type="email" placeholder="john@example.com" />
          <FieldDescription>
            We will never share your email with anyone.
          </FieldDescription>
        </Field>
        <Field>
          <FieldLabel for="field-message">Message</FieldLabel>
          <Textarea id="field-message" placeholder="Your message..." />
        </Field>
        <Field orientation="horizontal">
          <Button type="submit">Send message</Button>
          <Button type="button" variant="neutral">
            Cancel
          </Button>
        </Field>
      </FieldGroup>
    </FieldSet>
  </form>
}
