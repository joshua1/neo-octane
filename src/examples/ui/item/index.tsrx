import { BadgeCheckIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item.tsrx"

export default function ItemDemo() @{
  <Item class="max-w-md">
    <ItemMedia variant="icon">
      <BadgeCheckIcon />
    </ItemMedia>
    <ItemContent>
      <ItemTitle>Basic Item</ItemTitle>
      <ItemDescription>
        A simple item with title and description.
      </ItemDescription>
    </ItemContent>
    <ItemActions>
      <Button variant="noShadow" size="sm">
        Action
      </Button>
    </ItemActions>
  </Item>
}
