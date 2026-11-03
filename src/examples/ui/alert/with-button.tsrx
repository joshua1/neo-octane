import { CheckCircle2Icon } from "@octanejs/lucide"

import { Alert, AlertTitle } from "@/components/ui/alert.tsrx"
import { Button } from "@/components/ui/button.tsrx"

export default function AlertLongDescriptionDemo() @{
  <Alert class="sm:min-w-[500px]">
    <CheckCircle2Icon />
    <AlertTitle class="max-w-[calc(100%-4rem)] overflow-ellipsis">
      The selected emails have been marked as spam.
    </AlertTitle>
    <Button
      size="sm"
      variant="noShadow"
      class="absolute top-2.5 right-3 h-6 bg-secondary-background text-foreground"
    >
      Undo
    </Button>
  </Alert>
}
