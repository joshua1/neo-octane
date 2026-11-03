import { ShieldAlertIcon } from "@octanejs/lucide"

import { Alert, AlertTitle } from "@/components/ui/alert.tsrx"

export default function AlertLongTitleDemo() @{
  <Alert>
    <ShieldAlertIcon />
    <AlertTitle>
      This is a very long alert title that demonstrates how the component
      handles extended text content and potentially wraps across multiple lines
    </AlertTitle>
  </Alert>
}
