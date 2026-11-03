import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  Field,
  FieldContent,
  FieldDescription,
  FieldGroup,
  FieldLabel,
} from "@/components/ui/field.tsrx"
import { Switch } from "@/components/ui/switch.tsrx"

export default function SettingsDemo() @{
  <FieldGroup class="w-full rounded-base border-2 border-border bg-secondary-background p-4 text-foreground">
    <Field orientation="horizontal">
      <FieldContent>
        <FieldLabel for="styling-notifications">Notifications</FieldLabel>
        <FieldDescription>
          Get notified when someone mentions you.
        </FieldDescription>
      </FieldContent>
      <Switch id="styling-notifications" defaultChecked />
    </Field>
    <Field orientation="horizontal">
      <FieldContent>
        <FieldLabel for="styling-sounds">Sounds</FieldLabel>
        <FieldDescription>Play a sound for new messages.</FieldDescription>
      </FieldContent>
      <Switch id="styling-sounds" />
    </Field>
    <Field orientation="horizontal">
      <Checkbox id="styling-newsletter" defaultChecked />
      <FieldContent>
        <FieldLabel for="styling-newsletter">
          Subscribe to newsletter
        </FieldLabel>
        <FieldDescription>
          Receive weekly updates about new components.
        </FieldDescription>
      </FieldContent>
    </Field>
  </FieldGroup>
}
