import {
  Field,
  FieldDescription,
  FieldError,
  FieldLabel,
} from "@/components/ui/field.tsrx"
import { Input } from "@/components/ui/input.tsrx"

export default function FieldWithErrorDemo() @{
  <Field data-invalid class="max-w-sm">
    <FieldLabel for="field-username">Username</FieldLabel>
    <Input
      id="field-username"
      defaultValue="ab"
      aria-invalid
      class="border-red-500"
    />
    <FieldDescription>Pick a unique username.</FieldDescription>
    <FieldError
      errors={[
        { message: "Username must be at least 3 characters." },
        { message: "Username is already taken." },
      ]}
    />
  </Field>
}
