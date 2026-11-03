import { Button } from "@/components/ui/button.tsrx"
import { Spinner } from "@/components/ui/spinner.tsrx"

export default function SpinnerInButtonDemo() @{
  <div class="flex flex-wrap items-center gap-4">
    <Button disabled>
      <Spinner />
      Please wait
    </Button>
    <Button variant="neutral" disabled>
      <Spinner />
      Please wait
    </Button>
  </div>
}
