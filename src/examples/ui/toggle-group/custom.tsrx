import { useState } from "octane"

import { Field, FieldDescription, FieldLabel } from "@/components/ui/field.tsrx"
import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group.tsrx"

export default function ToggleGroupCustomDemo() @{
  const [fontWeight, setFontWeight] = useState("normal")

  <Field class="max-w-xs">
    <FieldLabel>Font Weight</FieldLabel>
    <ToggleGroup
      value={[fontWeight]}
      onValueChange={(value: string[]) => setFontWeight(value[0])}
      variant="outline"
      spacing={2}
      size="lg"
    >
      <ToggleGroupItem
        value="light"
        aria-label="Light"
        class="flex size-16 flex-col items-center justify-center rounded-base"
      >
        <span class="text-2xl leading-none font-light">Aa</span>
        <span class="text-xs text-foreground">Light</span>
      </ToggleGroupItem>
      <ToggleGroupItem
        value="normal"
        aria-label="Normal"
        class="flex size-16 flex-col items-center justify-center rounded-base"
      >
        <span class="text-2xl leading-none font-normal">Aa</span>
        <span class="text-xs text-foreground">Normal</span>
      </ToggleGroupItem>
      <ToggleGroupItem
        value="medium"
        aria-label="Medium"
        class="flex size-16 flex-col items-center justify-center rounded-base"
      >
        <span class="text-2xl leading-none font-medium">Aa</span>
        <span class="text-xs text-foreground">Medium</span>
      </ToggleGroupItem>
      <ToggleGroupItem
        value="bold"
        aria-label="Bold"
        class="flex size-16 flex-col items-center justify-center rounded-base"
      >
        <span class="text-2xl leading-none font-bold">Aa</span>
        <span class="text-xs text-foreground">Bold</span>
      </ToggleGroupItem>
    </ToggleGroup>
    <FieldDescription>
      Use{" "}
      <code class="rounded-base bg-secondary-background px-1 py-0.5 font-mono">
        {"font-" + fontWeight}
      </code>{" "}
      to set the font weight.
    </FieldDescription>
  </Field>
}
