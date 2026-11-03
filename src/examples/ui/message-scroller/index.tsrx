import { RotateCwIcon } from "@octanejs/lucide"

import { Avatar, AvatarFallback } from "@/components/ui/avatar.tsrx"
import { Bubble, BubbleContent } from "@/components/ui/bubble.tsrx"
import { Button } from "@/components/ui/button.tsrx"
import {
  Message,
  MessageAvatar,
  MessageContent,
} from "@/components/ui/message.tsrx"
import {
  MessageScroller,
  MessageScrollerButton,
  MessageScrollerContent,
  MessageScrollerItem,
  MessageScrollerProvider,
  MessageScrollerViewport,
} from "@/components/ui/message-scroller.tsrx"

const messages = [
  { from: "me", text: "Deploying to prod real quick." },
  { from: "them", text: "It's 4:55 PM. On a Friday." },
  { from: "me", text: "Ship it." },
  { from: "them", text: "Did the registry build go through?" },
  { from: "me", text: "Yes, one stale route showed up though." },
  { from: "them", text: "Which one?" },
  { from: "me", text: "The old toast page, still in the sidebar." },
  { from: "them", text: "Remove it and rebuild." },
  { from: "me", text: "Done. Lint and tsc are clean." },
  { from: "them", text: "Charts render fine with recharts 3?" },
  { from: "me", text: "They do. Pushing the fix now." },
  { from: "them", text: "Perfect, that is exactly what I had in mind." },
]

export default function MessageScrollerDemo() @{
  <div class="flex h-[360px] w-full max-w-md flex-col overflow-hidden rounded-base border-2 border-border bg-secondary-background text-foreground">
    <div class="flex items-center gap-3 p-4">
      <div class="flex min-w-0 flex-1 flex-col gap-0.5 text-sm">
        <span class="truncate font-heading">New Chat</span>
        <span class="truncate font-base">How can I help you today?</span>
      </div>
      <Button
        variant="neutral"
        size="icon"
        class="size-9 shadow-none!"
        aria-label="Reset chat"
      >
        <RotateCwIcon />
      </Button>
    </div>
    <div class="h-0.5 w-full shrink-0 bg-border" />
    <MessageScrollerProvider>
      <MessageScroller class="p-4">
        <MessageScrollerViewport>
          <MessageScrollerContent class="gap-4">
            @for (const message of messages; index index; key index) {
              <MessageScrollerItem messageId={`message-${index}`}>
                <Message align={message.from === "me" ? "end" : "start"}>
                  <MessageAvatar>
                    <Avatar>
                      <AvatarFallback>BF</AvatarFallback>
                    </Avatar>
                  </MessageAvatar>
                  <MessageContent>
                    <Bubble
                      variant={message.from === "me" ? "default" : "muted"}
                    >
                      <BubbleContent>{message.text as string}</BubbleContent>
                    </Bubble>
                  </MessageContent>
                </Message>
              </MessageScrollerItem>
            }
          </MessageScrollerContent>
        </MessageScrollerViewport>
        <MessageScrollerButton />
      </MessageScroller>
    </MessageScrollerProvider>
  </div>
}
