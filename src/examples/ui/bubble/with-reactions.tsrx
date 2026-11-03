import { HeartIcon, ThumbsUpIcon } from "@octanejs/lucide"

import {
  Bubble,
  BubbleContent,
  BubbleReactions,
} from "@/components/ui/bubble.tsrx"

export default function BubbleWithReactionsDemo() @{
  <div class="flex w-full max-w-sm flex-col gap-8">
    <Bubble variant="muted">
      <BubbleContent>
        The new landing page is live. Thanks everyone for the hard work!
      </BubbleContent>
      <BubbleReactions align="start">
        <HeartIcon class="size-3.5" />
        <span class="text-xs">12</span>
      </BubbleReactions>
    </Bubble>
    <Bubble align="end">
      <BubbleContent>Great job team, that was a big one.</BubbleContent>
      <BubbleReactions side="top">
        <ThumbsUpIcon class="size-3.5" />
        <span class="text-xs">3</span>
      </BubbleReactions>
    </Bubble>
  </div>
}
