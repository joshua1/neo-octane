import { Badge } from "@/components/ui/badge.tsrx"
import { Spinner } from "@/components/ui/spinner.tsrx"

export default function SpinnerWithBadgeDemo() @{
  <div class="flex flex-wrap items-center gap-4">
    <Badge>
      <Spinner />
      Syncing
    </Badge>
    <Badge variant="neutral">
      <Spinner />
      Syncing
    </Badge>
  </div>
}
