import {
  ArrowLeftIcon,
  ArrowRightIcon,
  CircleDashedIcon,
} from "@octanejs/lucide"

import { Kbd, KbdGroup } from "@/components/ui/kbd.tsrx"

export default function KbdWithIconDemo() @{
  <KbdGroup>
    <Kbd>
      <CircleDashedIcon />
    </Kbd>
    <Kbd>
      <ArrowLeftIcon />
    </Kbd>
    <Kbd>
      <ArrowRightIcon />
    </Kbd>
  </KbdGroup>
}
