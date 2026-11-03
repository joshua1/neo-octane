import { AlertCircleIcon } from "@octanejs/lucide"

import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert.tsrx"

export default function AlertDestructiveDemo() @{
  <Alert variant="destructive">
    <AlertCircleIcon />
    <AlertTitle>Something went wrong!</AlertTitle>
    <AlertDescription>
      Your session has expired. Please log in again.
    </AlertDescription>
  </Alert>
}
