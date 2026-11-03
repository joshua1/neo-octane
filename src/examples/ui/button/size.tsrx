import { ArrowUpRightIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"

export default function ButtonSizeDemo() @{
  <div class="flex flex-col items-start gap-4">
    <div class="flex items-center gap-2">
      <Button size="xs">Extra Small</Button>
      <Button size="icon-xs" aria-label="Submit">
        <ArrowUpRightIcon />
      </Button>
    </div>
    <div class="flex items-center gap-2">
      <Button size="sm">Small</Button>
      <Button size="icon-sm" aria-label="Submit">
        <ArrowUpRightIcon />
      </Button>
    </div>
    <div class="flex items-center gap-2">
      <Button>Default</Button>
      <Button size="icon" aria-label="Submit">
        <ArrowUpRightIcon />
      </Button>
    </div>
    <div class="flex items-center gap-2">
      <Button size="lg">Large</Button>
      <Button size="icon-lg" aria-label="Submit">
        <ArrowUpRightIcon />
      </Button>
    </div>
  </div>
}
