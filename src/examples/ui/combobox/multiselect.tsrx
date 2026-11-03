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

type Framework = (typeof frameworks)[number]

export default function ComboboxWithCheckbox() @{
  const [open, setOpen] = useState(false)
  const [selectedFrameworks, setSelectedFrameworks] = useState<Framework[]>([])

  <Popover open={open} onOpenChange={setOpen}>
    <PopoverTrigger
      render={
        <Button
          variant="noShadow"
          role="combobox"
          aria-expanded={open}
          class="w-fit min-w-[280px] justify-between"
        />
      }
    >
      {
        (selectedFrameworks.length > 0
          ? selectedFrameworks.map((framework) => framework.label).join(", ")
          : "Select frameworks (multi-select)...") as string
      }
      <ChevronsUpDown class="text-foreground" />
    </PopoverTrigger>
    <PopoverContent class="w-[300px] p-0 border-0" align="start">
      <Command class="**:data-[slot=command-input-wrapper]:h-11">
        <CommandInput placeholder="Search framework..." />
        <CommandList>
          <CommandEmpty>No framework found.</CommandEmpty>
          <CommandGroup class="p-2 [&_[cmdk-group-items]]:flex [&_[cmdk-group-items]]:flex-col [&_[cmdk-group-items]]:gap-1">
            @for (const framework of frameworks; key framework.value) {
              <CommandItem
                value={framework.value}
                onSelect={(currentValue) => {
                  setSelectedFrameworks(
                    selectedFrameworks.some((f) => f.value === currentValue)
                      ? selectedFrameworks.filter(
                          (f) => f.value !== currentValue,
                        )
                      : [...selectedFrameworks, framework],
                  )
                }}
              >
                <div
                  class="border-border pointer-events-none size-5 shrink-0 rounded-base border-2 transition-all select-none *:[svg]:opacity-0 data-[selected=true]:*:[svg]:opacity-100"
                  data-selected={selectedFrameworks.some(
                    (f) => f.value === framework.value,
                  )}
                >
                  <CheckIcon class="size-4 text-current" />
                </div>
                {framework.label as string}
              </CommandItem>
            }
          </CommandGroup>
        </CommandList>
      </Command>
    </PopoverContent>
  </Popover>
}
