import { ChevronRightIcon, ExternalLinkIcon } from "@octanejs/lucide"

import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item.tsrx"

export default function ItemAsLinkDemo() @{
  <Item class="max-w-md" render={<a href="#" />}>
    <ItemMedia variant="icon">
      <ExternalLinkIcon />
    </ItemMedia>
    <ItemContent>
      <ItemTitle>Visit our documentation</ItemTitle>
      <ItemDescription>
        Learn how to get started with our components.
      </ItemDescription>
    </ItemContent>
    <ItemActions>
      <ChevronRightIcon class="size-4" />
    </ItemActions>
  </Item>
}
