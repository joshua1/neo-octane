import { useState } from "octane"
import { Check, ChevronsUpDown } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
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

function ComboboxDemo() @{
  const [open, setOpen] = useState(false)
  const [value, setValue] = useState("")
  const triggerLabel = value
    ? frameworks.find((framework) => framework.value === value)?.label
    : "Select framework..."

  <Popover open={open} onOpenChange={setOpen}>
    <PopoverTrigger
      render={
        <Button
          variant="noShadow"
          role="combobox"
          aria-expanded={open}
          class="w-[200px] justify-between"
        />
      }
    >
      {(triggerLabel ?? "") as string}
      <ChevronsUpDown class="ml-2 size-4 shrink-0" />
    </PopoverTrigger>
    <PopoverContent class="w-[200px] border-0! p-0 font-base">
      <Command>
        <CommandInput placeholder="Search framework..." />
        <CommandEmpty>No framework found.</CommandEmpty>
        <CommandGroup>
          @for (const framework of frameworks; key framework.value) {
            <CommandItem
              value={framework.value}
              onSelect={(currentValue: string) => {
                setValue(currentValue === value ? "" : currentValue)
                setOpen(false)
              }}
            >
              <Check
                class={cn(
                  "mr-2 size-4",
                  value === framework.value ? "opacity-100" : "opacity-0",
                )}
              />
              {framework.label as string}
            </CommandItem>
          }
        </CommandGroup>
      </Command>
    </PopoverContent>
  </Popover>
}

export { ComboboxDemo }
