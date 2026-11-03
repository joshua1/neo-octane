import { Avatar, AvatarFallback } from "@/components/ui/avatar.tsrx"
import { Bubble, BubbleContent } from "@/components/ui/bubble.tsrx"
import {
  Message,
  MessageAvatar,
  MessageContent,
  MessageFooter,
  MessageHeader,
} from "@/components/ui/message.tsrx"

const thread: {
  author: string
  time: string
  fallback: string
  align?: "end"
  text: string
}[] = [
  {
    author: "Mia",
    time: "10:24 AM",
    fallback: "MI",
    text: "I checked the latest deployment and the build failed while installing dependencies. Can you share the error from the logs?",
  },
  {
    author: "You",
    time: "10:26 AM",
    fallback: "ME",
    align: "end" as const,
    text: "Sure, sending it over now. It looks like a peer dependency issue.",
  },
  {
    author: "Mia",
    time: "10:31 AM",
    fallback: "MI",
    text: "Got it. Pinning the version should fix it, I will push a patch in a minute.",
  },
]

export default function ChatDemo() @{
  <div class="flex w-full flex-col gap-5 rounded-base border-2 border-border bg-secondary-background p-4 shadow-shadow">
    @for (const message of thread; index index; key index) {
      <Message align={message.align}>
        <MessageAvatar>
          <Avatar>
            <AvatarFallback>{message.fallback as string}</AvatarFallback>
          </Avatar>
        </MessageAvatar>
        <MessageContent>
          <MessageHeader>{message.author as string}</MessageHeader>
          <Bubble variant={message.align === "end" ? "default" : "muted"}>
            <BubbleContent>{message.text as string}</BubbleContent>
          </Bubble>
          <MessageFooter>{message.time as string}</MessageFooter>
        </MessageContent>
      </Message>
    }
  </div>
}
