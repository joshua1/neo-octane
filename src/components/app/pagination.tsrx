import { ArrowLeft, ArrowRight } from "@octanejs/lucide"
import { Link } from "@octanejs/tanstack-router"

import { Button } from "@/components/ui/button.tsrx"

type Props = {
  prev?: {
    name: string
    path: string
  }
  next?: {
    name: string
    path: string
  }
}

export default function Pagination({ prev, next }: Props) @{
  let justifyContent

  if (prev && next) {
    justifyContent = "justify-between"
  } else if (prev) {
    justifyContent = "justify-start"
  } else if (next) {
    justifyContent = "justify-end"
  }

  <div class={`${justifyContent} flex w-full items-center`}>
    @if (prev?.name) {
      <Link to={prev.path}>
        <Button class="sm:px-5 px-3.5 py-2 h-[unset] sm:text-sm text-xs">
          <ArrowLeft />
          {prev.name as string}
        </Button>
      </Link>
    }

    @if (next?.name) {
      <Link to={next.path}>
        <Button class="sm:px-5 px-3.5 py-2 h-[unset] sm:text-sm text-xs">
          {next.name as string}
          <ArrowRight />
        </Button>
      </Link>
    }
  </div>
}
