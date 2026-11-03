import { RotateCwIcon } from "@octanejs/lucide"

import { useState } from "octane"

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
  useMessageScroller,
} from "@/components/ui/message-scroller.tsrx"

type ChatMessage = { from: "me" | "them"; text: string }

const initialMessages: ChatMessage[] = [
  { from: "them", text: "Hey, are you around?" },
  { from: "me", text: "Yes, what is up?" },
  { from: "them", text: "I need a review on the message scroller." },
]

const replies = [
  "Sounds good to me.",
  "Can you double check the build output?",
  "Done, everything looks clean.",
  "Let us ship it then.",
  "Pushing now.",
]

function AddMessageButton({ onAdd }: { onAdd: () => void }) @{
  const { scrollToEnd } = useMessageScroller()

  <Button
    onClick={() => {
      onAdd()
      requestAnimationFrame(() => scrollToEnd({ behavior: "smooth" }))
    }}
  >
    Add message
  </Button>
}

export default function MessageScrollerAddMessagesDemo() @{
  const [messages, setMessages] = useState(initialMessages)

  function addMessage() {
    setMessages((current: ChatMessage[]): ChatMessage[] => {
      const last = current[current.length - 1]
      const added = current.length - initialMessages.length

      return [
        ...current,
        {
          from: last?.from === "me" ? "them" : "me",
          text: replies[added % replies.length],
        },
      ]
    })
  }

  <MessageScrollerProvider>
    <div class="flex w-full max-w-md flex-col gap-4">
      <div class="flex h-[360px] w-full flex-col overflow-hidden rounded-base border-2 border-border bg-secondary-background text-foreground">
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
            onClick={() => setMessages(initialMessages)}
          >
            <RotateCwIcon />
          </Button>
        </div>
        <div class="h-0.5 w-full shrink-0 bg-border" />
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
      </div>
      <div class="flex justify-end">
        <AddMessageButton onAdd={addMessage} />
      </div>
    </div>
  </MessageScrollerProvider>
}
