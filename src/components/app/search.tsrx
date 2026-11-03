import { Search as SearchIcon } from "@octanejs/lucide"
import { useNavigate } from "@octanejs/tanstack-router"
import { useCallback, useEffect, useState } from "octane"

import { COMPONENTS_LINKS, GETTING_STARTED_LINKS } from "@/data/sidebar-links"

import { Button } from "@/components/ui/button.tsrx"
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
} from "@/components/ui/command.tsrx"

export default function Search() @{
  const DOCS_LINKS = [
    {
      heading: "Getting started",
      links: [...GETTING_STARTED_LINKS],
    },
    {
      heading: "Components",
      links: [...COMPONENTS_LINKS],
    },
  ]

  const navigate = useNavigate()

  const [open, setOpen] = useState(false)

  useEffect(() => {
    const down = (e: KeyboardEvent) => {
      if (e.key === "k" && (e.metaKey || e.ctrlKey)) {
        e.preventDefault()
        setOpen((open) => !open)
      }
    }
    document.addEventListener("keydown", down)
    return () => document.removeEventListener("keydown", down)
  }, [])

  const runCommand = useCallback((command: () => unknown) => {
    setOpen(false)
    command()
  }, [])

  <>
    <Button
      onClick={() => setOpen(true)}
      class="relative bg-secondary-background shadow-nav hover:translate-x-[4px]! hover:translate-y-[4px]! hover:shadow-none px-3 pr-3 xl:pr-16 shrink-0 xl:w-[unset] w-9 h-9 text-base"
    >
      <span class="flex text-sm items-center gap-1">
        <SearchIcon class="xl:!size-4 !size-5 shrink-0" />
        <span class="xl:inline hidden">Search</span>
      </span>

      <span class="absolute xl:flex hidden items-center justify-center text-black border text-xs px-1 border-black rounded-base bg-main h-6 right-2 top-1">
        ⌘ K
      </span>
    </Button>
    <CommandDialog
      title="Search documentation"
      open={open}
      onOpenChange={setOpen}
    >
      <CommandInput placeholder="Search documentation..." />
      <CommandList class="command-scrollbar **:data-[slot=command-item]:py-1.5!">
        <CommandEmpty>No results found.</CommandEmpty>
        @for (const { heading, links } of DOCS_LINKS; index i; key heading) {
          <>
            <CommandGroup heading={heading}>
              @for (const { text, href } of links; key href) {
                <CommandItem
                  value={text}
                  onSelect={() => {
                    runCommand(() => navigate({ to: href }))
                  }}
                >
                  {text as string}
                </CommandItem>
              }
            </CommandGroup>
            @if (i < 2) {
              <CommandSeparator />
            }
          </>
        }
      </CommandList>
    </CommandDialog>
  </>
}
