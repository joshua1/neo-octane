import { Spinner } from "@/components/ui/spinner.tsrx"

export default function SpinnerSizeDemo() @{
  <div class="flex items-center gap-6">
    <Spinner class="size-4" />
    <Spinner class="size-6" />
    <Spinner class="size-8" />
  </div>
}
