import { ArchiveIcon, InboxIcon, SendIcon } from "@octanejs/lucide"

import {
  Item,
  ItemContent,
  ItemDescription,
  ItemGroup,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item.tsrx"

export default function ItemGroupDemo() @{
  <ItemGroup class="max-w-md">
    <Item>
      <ItemMedia variant="icon">
        <InboxIcon />
      </ItemMedia>
      <ItemContent>
        <ItemTitle>Inbox</ItemTitle>
        <ItemDescription>View all incoming messages.</ItemDescription>
      </ItemContent>
    </Item>
    <Item>
      <ItemMedia variant="icon">
        <SendIcon />
      </ItemMedia>
      <ItemContent>
        <ItemTitle>Sent</ItemTitle>
        <ItemDescription>View all sent messages.</ItemDescription>
      </ItemContent>
    </Item>
    <Item>
      <ItemMedia variant="icon">
        <ArchiveIcon />
      </ItemMedia>
      <ItemContent>
        <ItemTitle>Archive</ItemTitle>
        <ItemDescription>View archived messages.</ItemDescription>
      </ItemContent>
    </Item>
  </ItemGroup>
}
