import { GiftIcon } from "@octanejs/lucide"

import { Alert, AlertDescription } from "@/components/ui/alert.tsrx"

export default function AlertLongDescriptionDemo() @{
  <Alert>
    <GiftIcon />
    <AlertDescription>
      This is a very long alert description that demonstrates how the component
      handles extended text content and potentially wraps across multiple lines
    </AlertDescription>
  </Alert>
}
