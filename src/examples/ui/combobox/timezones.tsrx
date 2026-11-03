import { useMemo, useState } from "octane"
import { CheckIcon, ChevronDownIcon, PlusCircleIcon } from "@octanejs/lucide"

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

const timezones = [
  {
    label: "Americas",
    timezones: [
      { value: "America/New_York", label: "(GMT-5) New York" },
      { value: "America/Los_Angeles", label: "(GMT-8) Los Angeles" },
      { value: "America/Chicago", label: "(GMT-6) Chicago" },
      { value: "America/Toronto", label: "(GMT-5) Toronto" },
      { value: "America/Vancouver", label: "(GMT-8) Vancouver" },
      { value: "America/Sao_Paulo", label: "(GMT-3) São Paulo" },
    ],
  },
  {
    label: "Europe",
    timezones: [
      { value: "Europe/London", label: "(GMT+0) London" },
      { value: "Europe/Paris", label: "(GMT+1) Paris" },
      { value: "Europe/Berlin", label: "(GMT+1) Berlin" },
      { value: "Europe/Rome", label: "(GMT+1) Rome" },
      { value: "Europe/Madrid", label: "(GMT+1) Madrid" },
      { value: "Europe/Amsterdam", label: "(GMT+1) Amsterdam" },
    ],
  },
  {
    label: "Asia/Pacific",
    timezones: [
      { value: "Asia/Tokyo", label: "(GMT+9) Tokyo" },
      { value: "Asia/Shanghai", label: "(GMT+8) Shanghai" },
      { value: "Asia/Singapore", label: "(GMT+8) Singapore" },
      { value: "Asia/Dubai", label: "(GMT+4) Dubai" },
      { value: "Australia/Sydney", label: "(GMT+11) Sydney" },
      { value: "Asia/Seoul", label: "(GMT+9) Seoul" },
    ],
  },
] as const

type Timezone = (typeof timezones)[number]
// `@for` can't infer an item type from a union of `as const` tuples, so the
// inner loop iterates this widened (still readonly) view.
type TimezoneList = ReadonlyArray<Timezone["timezones"][number]>

export default function TimezoneCombobox() @{
  const [open, setOpen] = useState(false)
  const [value, setValue] = useState("America/New_York")

  const selectedGroup = useMemo(
    () =>
      timezones.find((group) =>
        group.timezones.some((tz) => tz.value === value),
      ),
    [value],
  )

  const selectedTimezoneLabel = useMemo(() => {
    if (!selectedGroup) return undefined
    for (const tz of selectedGroup.timezones) {
      if (tz.value === value) {
        return tz.label
      }
    }
    return undefined
  }, [value, selectedGroup])

  <Popover open={open} onOpenChange={setOpen}>
    <PopoverTrigger
      render={
        <Button
          variant="noShadow"
          class="h-12 w-full justify-between px-2.5 md:max-w-[200px]"
        />
      }
    >
      @if (selectedTimezoneLabel) {
        <div class="flex flex-col items-start gap-0.5">
          <span class="text-xs font-normal">
            {selectedGroup?.label as string}
          </span>
          <span>{selectedTimezoneLabel as string}</span>
        </div>
      } @else {
        {
          ;("Select timezone")
        }
      }
      <ChevronDownIcon />
    </PopoverTrigger>
    <PopoverContent class="p-0 border-0" align="start">
      <Command class="**:data-[slot=command-input-wrapper]:h-11">
        <CommandInput placeholder="Search timezone..." />
        <CommandList class="scroll-pb-12">
          <CommandEmpty>No timezone found.</CommandEmpty>
          @for (const region of timezones; key region.label) {
            <CommandGroup class="p-2" heading={region.label}>
              @for (
                const timezone of region.timezones as TimezoneList;
                key timezone.value
              ) {
                <CommandItem
                  value={timezone.value}
                  onSelect={(currentValue) => {
                    setValue(
                      currentValue as Timezone["timezones"][number]["value"],
                    )
                    setOpen(false)
                  }}
                >
                  {timezone.label as string}
                  <CheckIcon
                    class="ml-auto opacity-0 data-[selected=true]:opacity-100"
                    data-selected={value === timezone.value}
                  />
                </CommandItem>
              }
            </CommandGroup>
          }
          <CommandGroup class="bg-background border-t-2 p-2 border-t-border sticky bottom-0">
            <CommandItem>
              <PlusCircleIcon />
              Create timezone
            </CommandItem>
          </CommandGroup>
        </CommandList>
      </Command>
    </PopoverContent>
  </Popover>
}
