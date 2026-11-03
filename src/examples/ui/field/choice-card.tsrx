import {
  Field,
  FieldContent,
  FieldDescription,
  FieldLabel,
  FieldLegend,
  FieldSet,
  FieldTitle,
} from "@/components/ui/field.tsrx"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group.tsrx"

const plans = [
  {
    id: "free",
    title: "Free",
    description: "For hobby projects and experiments.",
  },
  {
    id: "pro",
    title: "Pro",
    description: "For professionals and small teams.",
  },
  {
    id: "team",
    title: "Team",
    description: "For growing organizations.",
  },
]

export default function FieldChoiceCardDemo() @{
  <FieldSet class="w-full max-w-sm">
    <FieldLegend variant="label">Subscription plan</FieldLegend>
    <RadioGroup defaultValue="pro">
      @for (const plan of plans; key plan.id) {
        <FieldLabel for={`plan-${plan.id}`}>
          <Field orientation="horizontal">
            <FieldContent>
              <FieldTitle>{plan.title as string}</FieldTitle>
              <FieldDescription>{plan.description as string}</FieldDescription>
            </FieldContent>
            <RadioGroupItem value={plan.id} id={`plan-${plan.id}`} />
          </Field>
        </FieldLabel>
      }
    </RadioGroup>
  </FieldSet>
}
