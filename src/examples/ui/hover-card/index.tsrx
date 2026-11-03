import { Button } from "@/components/ui/button.tsrx"
import {
  HoverCard,
  HoverCardContent,
  HoverCardTrigger,
} from "@/components/ui/hover-card.tsrx"

export default function HoverCardDemo() @{
  <HoverCard>
    <HoverCardTrigger render={<Button variant="noShadow" />}>
      Hover
    </HoverCardTrigger>
    <HoverCardContent>
      The compiler-first UI framework.
    </HoverCardContent>
  </HoverCard>
}
