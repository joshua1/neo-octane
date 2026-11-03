import { BellIcon, GitPullRequestIcon, StarIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import {
  Item,
  ItemActions,
  ItemContent,
  ItemDescription,
  ItemGroup,
  ItemMedia,
  ItemTitle,
} from "@/components/ui/item.tsrx"

const items = [
  {
    icon: GitPullRequestIcon,
    title: "Pull request opened",
    description: "Mia opened #128: pin peer dependency versions",
  },
  {
    icon: StarIcon,
    title: "New star",
    description: "Your repository reached 1,000 stars",
  },
  {
    icon: BellIcon,
    title: "Reminder",
    description: "Release notes are due tomorrow",
  },
]

export default function ItemsDemo() @{
  <ItemGroup class="w-full gap-3">
    @for (const item of items; key item.title) {
      <Item class="bg-secondary-background">
        <ItemMedia variant="icon">
          <item.icon />
        </ItemMedia>
        <ItemContent>
          <ItemTitle>{item.title as string}</ItemTitle>
          <ItemDescription>{item.description as string}</ItemDescription>
        </ItemContent>
        <ItemActions>
          <Button variant="noShadow" size="sm">
            View
          </Button>
        </ItemActions>
      </Item>
    }
  </ItemGroup>
}
