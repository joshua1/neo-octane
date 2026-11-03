import { useState } from "octane"
import { CheckIcon, ChevronsUpDown } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

import { cn } from "@/lib/utils"

const frameworks = [
  {
    value: "next.js",
    label: "Next.js",
  },
  {
    value: "sveltekit",
    label: "SvelteKit",
  },
  {
    value: "nuxt.js",
    label: "Nuxt.js",
  },
  {
    value: "remix",
    label: "Remix",
  },
  {
    value: "astro",
    label: "Astro",
  },
]

export default function FrameworkCombobox() @{
  const [open, setOpen] = useState(false)
  const [value, setValue] = useState("")

  <Popover open={open} onOpenChange={setOpen}>
    <PopoverTrigger
      render={
        <Button
          variant="noShadow"
          role="combobox"
          aria-expanded={open}
          class="w-full justify-between md:max-w-[200px]"
        />
      }
    >
      {
        (value
          ? frameworks.find((framework) => framework.value === value)?.label
          : "Select framework...") as string
      }
      <ChevronsUpDown />
    </PopoverTrigger>
    <PopoverContent class="w-(--anchor-width) border-0 p-0">
      <Command class="**:data-[slot=command-input-wrapper]:h-11">
        <CommandInput placeholder="Search framework..." />
        <CommandList class="p-1">
          <CommandEmpty>No framework found.</CommandEmpty>
          <CommandGroup>
            @for (const framework of frameworks; key framework.value) {
              <CommandItem
                value={framework.value}
                onSelect={(currentValue) => {
                  setValue(currentValue === value ? "" : currentValue)
                  setOpen(false)
                }}
              >
                {framework.label as string}
                <CheckIcon
                  class={cn(
                    "ml-auto",
                    value === framework.value ? "opacity-100" : "opacity-0",
                  )}
                />
              </CommandItem>
            }
          </CommandGroup>
        </CommandList>
      </Command>
    </PopoverContent>
  </Popover>
}
