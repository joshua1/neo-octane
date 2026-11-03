import { PopcornIcon } from "@octanejs/lucide"

import { Alert, AlertTitle } from "@/components/ui/alert.tsrx"

export default function AlertIconTitleDemo() @{
  <Alert>
    <PopcornIcon />
    <AlertTitle>Let&apos;s try one with icon and title.</AlertTitle>
  </Alert>
}
