import { Alert, AlertDescription } from "@/components/ui/alert.tsrx"

export default function AlertDescriptionOnlyDemo() @{
  <Alert>
    <AlertDescription>
      This one has a description only. No title. No icon.
    </AlertDescription>
  </Alert>
}
