import { BookmarkCheckIcon } from "@octanejs/lucide"

import { Alert, AlertDescription } from "@/components/ui/alert.tsrx"

export default function AlertIconDescriptionDemo() @{
  <Alert>
    <BookmarkCheckIcon />
    <AlertDescription>
      This one has an icon and a description only. No title.
    </AlertDescription>
  </Alert>
}
