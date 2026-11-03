import { MaximizeIcon, MinimizeIcon } from "@octanejs/lucide"

import { useState } from "octane"

import { Button } from "@/components/ui/button.tsrx"
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from "@/components/ui/card.tsrx"
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible.tsrx"
import { Field, FieldGroup, FieldLabel } from "@/components/ui/field.tsrx"
import { Input } from "@/components/ui/input.tsrx"

export default function CollapsibleSettingsPanelDemo() @{
  const [isOpen, setIsOpen] = useState(false)

  <Card class="mx-auto w-full max-w-xs">
    <CardHeader>
      <CardTitle>Radius</CardTitle>
      <CardDescription>Set the corner radius of the element.</CardDescription>
    </CardHeader>
    <CardContent>
      <Collapsible
        open={isOpen}
        onOpenChange={setIsOpen}
        class="flex items-start gap-2"
      >
        <FieldGroup class="grid w-full grid-cols-2 gap-2">
          <Field>
            <FieldLabel for="radius-top-left" class="sr-only">
              Radius top left
            </FieldLabel>
            <Input id="radius-top-left" placeholder="0" defaultValue={0} />
          </Field>
          <Field>
            <FieldLabel for="radius-top-right" class="sr-only">
              Radius top right
            </FieldLabel>
            <Input id="radius-top-right" placeholder="0" defaultValue={0} />
          </Field>
          <CollapsibleContent class="col-span-full grid grid-cols-subgrid gap-2">
            <Field>
              <FieldLabel for="radius-bottom-left" class="sr-only">
                Radius bottom left
              </FieldLabel>
              <Input id="radius-bottom-left" placeholder="0" defaultValue={0} />
            </Field>
            <Field>
              <FieldLabel for="radius-bottom-right" class="sr-only">
                Radius bottom right
              </FieldLabel>
              <Input
                id="radius-bottom-right"
                placeholder="0"
                defaultValue={0}
              />
            </Field>
          </CollapsibleContent>
        </FieldGroup>
        <CollapsibleTrigger
          render={
            <Button
              variant="noShadow"
              size="icon"
              class="bg-secondary-background text-foreground"
            />
          }
        >
          @if (isOpen) {
            <MinimizeIcon />
          } @else {
            <MaximizeIcon />
          }
        </CollapsibleTrigger>
      </Collapsible>
    </CardContent>
  </Card>
}
