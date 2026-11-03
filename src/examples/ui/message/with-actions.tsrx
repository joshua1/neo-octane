import { CopyIcon, RefreshCwIcon, ThumbsUpIcon } from "@octanejs/lucide"

import { Avatar, AvatarFallback } from "@/components/ui/avatar.tsrx"
import { Bubble, BubbleContent } from "@/components/ui/bubble.tsrx"
import { Button } from "@/components/ui/button.tsrx"
import {
  Message,
  MessageAvatar,
  MessageContent,
} from "@/components/ui/message.tsrx"

export default function MessageWithActionsDemo() @{
  <div class="flex w-full max-w-md flex-col gap-4">
    <Message>
      <MessageAvatar>
        <Avatar>
          <AvatarFallback>AI</AvatarFallback>
        </Avatar>
      </MessageAvatar>
      <MessageContent>
        <Bubble variant="muted">
          <BubbleContent>
            Here is a summary of the changes: the registry was rebuilt, two
            stale routes were removed and the docs were updated.
          </BubbleContent>
        </Bubble>
        <div class="flex items-center gap-1">
          <Button
            variant="neutral"
            size="icon"
            class="size-8 shadow-none! hover:translate-x-0! hover:translate-y-0!"
            aria-label="Copy"
          >
            <CopyIcon />
          </Button>
          <Button
            variant="neutral"
            size="icon"
            class="size-8 shadow-none! hover:translate-x-0! hover:translate-y-0!"
            aria-label="Regenerate"
          >
            <RefreshCwIcon />
          </Button>
          <Button
            variant="neutral"
            size="icon"
            class="size-8 shadow-none! hover:translate-x-0! hover:translate-y-0!"
            aria-label="Like"
          >
            <ThumbsUpIcon />
          </Button>
        </div>
      </MessageContent>
    </Message>
  </div>
}
