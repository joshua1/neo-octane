import { Button } from "@/components/ui/button.tsrx"
import {
  HoverCard,
  HoverCardContent,
  HoverCardTrigger,
} from "@/components/ui/hover-card.tsrx"

const HOVER_CARD_SIDES = ["left", "top", "bottom", "right"] as const

export default function HoverCardSidesDemo() @{
  <div class="flex flex-wrap justify-center gap-2">
    @for (const side of HOVER_CARD_SIDES; key side) {
      <HoverCard>
        <HoverCardTrigger
          delay={100}
          closeDelay={100}
          render={
            <Button
              variant="noShadow"
              class="bg-secondary-background text-foreground capitalize"
            />
          }
        >
          {side as string}
        </HoverCardTrigger>
        <HoverCardContent side={side}>
          <div class="flex flex-col gap-1">
            <h4 class="font-heading">Hover Card</h4>
            <p>
              This hover card appears on the {side as string} side of the
              trigger.
            </p>
          </div>
        </HoverCardContent>
      </HoverCard>
    }
  </div>
}
