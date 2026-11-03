import {
  HoverCard,
  HoverCardContent,
  HoverCardTrigger,
} from "@/components/ui/hover-card.tsrx"

export default function HoverCardBasicDemo() @{
  <HoverCard>
    <HoverCardTrigger
      delay={10}
      closeDelay={100}
      href="#"
      class="font-heading underline underline-offset-4"
    >
      Hover Here
    </HoverCardTrigger>
    <HoverCardContent class="flex w-64 flex-col gap-0.5">
      <div class="font-heading">@octanejs</div>
      <div>The compiler-first UI framework.</div>
    </HoverCardContent>
  </HoverCard>
}
