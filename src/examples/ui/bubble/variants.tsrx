import { Bubble, BubbleContent } from "@/components/ui/bubble.tsrx"

export default function BubbleVariantsDemo() @{
  <div class="flex w-full max-w-sm flex-col gap-4">
    <Bubble>
      <BubbleContent>Default bubbles use the main color.</BubbleContent>
    </Bubble>
    <Bubble variant="secondary">
      <BubbleContent>Secondary bubbles sit on a white surface.</BubbleContent>
    </Bubble>
    <Bubble variant="muted">
      <BubbleContent>Muted bubbles blend into the background.</BubbleContent>
    </Bubble>
    <Bubble variant="destructive">
      <BubbleContent>Destructive bubbles flag failed actions.</BubbleContent>
    </Bubble>
  </div>
}
