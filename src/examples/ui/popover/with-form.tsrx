import { Button } from "@/components/ui/button.tsrx"
import { Field, FieldGroup, FieldLabel } from "@/components/ui/field.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverDescription,
  PopoverHeader,
  PopoverTitle,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

export default function PopoverWithFormDemo() @{
  <Popover>
    <PopoverTrigger render={<Button variant="noShadow" />}>
      Open Popover
    </PopoverTrigger>
    <PopoverContent class="w-64" align="start">
      <PopoverHeader>
        <PopoverTitle>Dimensions</PopoverTitle>
        <PopoverDescription>
          Set the dimensions for the layer.
        </PopoverDescription>
      </PopoverHeader>
      <FieldGroup class="gap-4">
        <Field orientation="horizontal">
          <FieldLabel for="width" class="w-1/2">
            Width
          </FieldLabel>
          <Input id="width" defaultValue="100%" />
        </Field>
        <Field orientation="horizontal">
          <FieldLabel for="height" class="w-1/2">
            Height
          </FieldLabel>
          <Input id="height" defaultValue="25px" />
        </Field>
      </FieldGroup>
    </PopoverContent>
  </Popover>
}
