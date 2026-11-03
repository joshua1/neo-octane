import { ChevronsUpDown } from "@octanejs/lucide"
import { useState } from "octane"

import { Button } from "@/components/ui/button.tsrx"
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible.tsrx"

export default function CollapsibleDemo() @{
  const [isOpen, setIsOpen] = useState(false)

  <Collapsible open={isOpen} onOpenChange={setIsOpen} class="w-full space-y-2">
    <div class="rounded-base flex items-center justify-between space-x-4 border-2 border-border text-foreground bg-secondary-background px-4 py-2">
      <h4 class="text-sm font-heading">@octanejs published 3 packages</h4>
      <CollapsibleTrigger
        render={
          <Button
            variant="noShadow"
            size="sm"
            class="w-9 bg-secondary-background text-foreground p-0"
          />
        }
      >
        <ChevronsUpDown class="size-4" />
        <span class="sr-only">Toggle</span>
      </CollapsibleTrigger>
    </div>
    <div class="rounded-base border-2 border-border bg-secondary-background px-4 py-3 font-mono font-base text-foreground text-sm">
      @octanejs/base-ui
    </div>
    <CollapsibleContent class="space-y-2 text-foreground font-base">
      <div class="rounded-base border-2 border-border bg-secondary-background px-4 py-3 font-mono text-sm">
        @octanejs/shadcn
      </div>
      <div class="rounded-base border-2 border-border bg-secondary-background px-4 py-3 font-mono text-sm">
        @octanejs/lucide
      </div>
    </CollapsibleContent>
  </Collapsible>
}
