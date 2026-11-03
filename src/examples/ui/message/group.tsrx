import { Avatar, AvatarFallback } from "@/components/ui/avatar.tsrx"
import { Bubble, BubbleContent } from "@/components/ui/bubble.tsrx"
import {
  Message,
  MessageAvatar,
  MessageContent,
  MessageGroup,
} from "@/components/ui/message.tsrx"

export default function MessageGroupDemo() @{
  <div class="flex w-full max-w-md flex-col gap-6">
    <MessageGroup>
      <Message>
        <MessageAvatar>
          <Avatar>
            <AvatarFallback>BF</AvatarFallback>
          </Avatar>
        </MessageAvatar>
        <MessageContent>
          <Bubble variant="muted">
            <BubbleContent>I checked the registry addresses.</BubbleContent>
          </Bubble>
        </MessageContent>
      </Message>
      <Message>
        <MessageAvatar>
          <Avatar>
            <AvatarFallback>EK</AvatarFallback>
          </Avatar>
        </MessageAvatar>
        <MessageContent>
          <Bubble variant="muted">
            <BubbleContent>
              The component and example JSON now live under the UI registry.
            </BubbleContent>
          </Bubble>
        </MessageContent>
      </Message>
    </MessageGroup>
    <MessageGroup>
      <Message align="end">
        <MessageContent>
          <Bubble>
            <BubbleContent>Nice, that is what we wanted.</BubbleContent>
          </Bubble>
        </MessageContent>
      </Message>
      <Message align="end">
        <MessageContent>
          <Bubble>
            <BubbleContent>Ship it.</BubbleContent>
          </Bubble>
        </MessageContent>
      </Message>
    </MessageGroup>
  </div>
}
