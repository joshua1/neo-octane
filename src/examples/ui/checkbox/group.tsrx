import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  Field,
  FieldDescription,
  FieldGroup,
  FieldLabel,
  FieldLegend,
  FieldSet,
} from "@/components/ui/field.tsrx"

export default function CheckboxGroupDemo() @{
  <FieldSet>
    <FieldLegend variant="label">Show these items on the desktop:</FieldLegend>
    <FieldDescription>
      Select the items you want to show on the desktop.
    </FieldDescription>
    <FieldGroup class="gap-3">
      <Field orientation="horizontal">
        <Checkbox
          id="finder-pref-hard-disks-checkbox"
          name="finder-pref-hard-disks-checkbox"
          defaultChecked
        />
        <FieldLabel for="finder-pref-hard-disks-checkbox" class="font-base">
          Hard disks
        </FieldLabel>
      </Field>
      <Field orientation="horizontal">
        <Checkbox
          id="finder-pref-external-disks-checkbox"
          name="finder-pref-external-disks-checkbox"
          defaultChecked
        />
        <FieldLabel for="finder-pref-external-disks-checkbox" class="font-base">
          External disks
        </FieldLabel>
      </Field>
      <Field orientation="horizontal">
        <Checkbox
          id="finder-pref-cds-dvds-checkbox"
          name="finder-pref-cds-dvds-checkbox"
        />
        <FieldLabel for="finder-pref-cds-dvds-checkbox" class="font-base">
          CDs, DVDs, and iPods
        </FieldLabel>
      </Field>
      <Field orientation="horizontal">
        <Checkbox
          id="finder-pref-connected-servers-checkbox"
          name="finder-pref-connected-servers-checkbox"
        />
        <FieldLabel
          for="finder-pref-connected-servers-checkbox"
          class="font-base"
        >
          Connected servers
        </FieldLabel>
      </Field>
    </FieldGroup>
  </FieldSet>
}
