import { PlusIcon } from "@octanejs/lucide"

import {
  Avatar,
  AvatarBadge,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar.tsrx"

export default function AvatarBadgeWithIconDemo() @{
  <Avatar class="grayscale">
    <AvatarImage src="https://github.com/pranathip.png" alt="@pranathip" />
    <AvatarFallback>PP</AvatarFallback>
    <AvatarBadge>
      <PlusIcon />
    </AvatarBadge>
  </Avatar>
}
