import { ChevronDownIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import { Card, CardContent } from "@/components/ui/card.tsrx"
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible.tsrx"

export default function CollapsibleBasicDemo() @{
  <Card class="mx-auto w-full max-w-sm">
    <CardContent>
      <Collapsible>
        <CollapsibleTrigger
          render={
            <Button
              variant="noShadow"
              class="group w-full bg-secondary-background text-foreground"
            />
          }
        >
          Product details
          <ChevronDownIcon class="ml-auto transition-transform group-data-panel-open:rotate-180" />
        </CollapsibleTrigger>
        <CollapsibleContent class="mt-2 flex flex-col items-start gap-2 rounded-base border-2 border-border bg-secondary-background p-4 text-sm">
          <div>
            This panel can be expanded or collapsed to reveal additional
            content.
          </div>
          <Button size="sm">Learn More</Button>
        </CollapsibleContent>
      </Collapsible>
    </CardContent>
  </Card>
}
