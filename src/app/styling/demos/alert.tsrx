import { CheckCircle2Icon } from "@octanejs/lucide"

import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert.tsrx"

export default function AlertDemo() @{
  <Alert class="bg-secondary-background">
    <CheckCircle2Icon />
    <AlertTitle>Success! Your changes have been saved</AlertTitle>
    <AlertDescription>
      This is an alert with icon, title and description.
    </AlertDescription>
  </Alert>
}
