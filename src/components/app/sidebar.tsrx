import { Link, useLocation } from "@octanejs/tanstack-router"

import { MAIN_SIDEBAR } from "@/data/sidebar-links"

import { Badge } from "@/components/ui/badge.tsrx"

import { cn } from "@/lib/utils"

export default function Sidebar() @{
  const pathname = useLocation({ select: (location) => location.pathname })

  <aside class="scrollbar fixed top-[70px] bg-secondary-background h-[calc(100svh-70px)] max-h-[calc(100svh-70px)] w-[250px] overflow-y-auto border-r-4 lg:block hidden border-border">
    @for (const item of MAIN_SIDEBAR; index id; key id) {
      @if (typeof item === "string") {
        <div class="block border-b-4 border-r-4 border-border p-4 text-xl font-heading">
          {item}
        </div>
      } @else {
        <Link
          to={`${item.href}`}
          class={cn(
            "flex items-center justify-between gap-2 border-b-4 border-r-4 border-border px-4 py-2.5 pl-7 text-lg font-base text-foreground/90 hover:bg-main/70 hover:text-main-foreground",
            item.href === pathname &&
              "bg-main text-main-foreground hover:bg-main",
          )}
        >
          {item.text as string}
          @if (item.isNew) {
            <Badge
              variant="neutral"
              class="bg-chart-3 text-main-foreground px-1.5 py-0 text-[10px] font-heading uppercase"
            >
              New
            </Badge>
          }
        </Link>
      }
    }
  </aside>
}
