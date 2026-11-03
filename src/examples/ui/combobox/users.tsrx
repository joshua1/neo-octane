import { useMemo, useState } from "octane"
import { CheckIcon, ChevronsUpDown, PlusCircleIcon } from "@octanejs/lucide"

import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar.tsrx"
import { Button } from "@/components/ui/button.tsrx"
import {
  Command,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandSeparator,
} from "@/components/ui/command.tsrx"
import {
  Popover,
  PopoverContent,
  PopoverTrigger,
} from "@/components/ui/popover.tsrx"

import { cn } from "@/lib/utils"

const users = [
  {
    id: "1",
    username: "shadcn",
  },
  {
    id: "2",
    username: "leerob",
  },
  {
    id: "3",
    username: "evilrabbit",
  },
] as const

export default function UserCombobox() @{
  const [open, setOpen] = useState(false)
  const [value, setValue] = useState("1")

  const selectedUser = useMemo(
    () => users.find((user) => user.id === value),
    [value],
  )

  <Popover open={open} onOpenChange={setOpen}>
    <PopoverTrigger
      render={
        <Button
          variant="noShadow"
          role="combobox"
          aria-expanded={open}
          class="w-full justify-between px-2 md:max-w-[200px]"
        />
      }
    >
      @if (selectedUser) {
        <div class="flex items-center gap-2">
          <Avatar class="size-5">
            <AvatarImage
              src={`https://github.com/${selectedUser.username}.png`}
            />
            <AvatarFallback>
              {selectedUser.username[0] as string}
            </AvatarFallback>
          </Avatar>
          {selectedUser.username as string}
        </div>
      } @else {
        {
          ;("Select user...")
        }
      }
      <ChevronsUpDown class="text-foreground" />
    </PopoverTrigger>
    <PopoverContent class="w-(--anchor-width) border-0 p-0">
      <Command class="**:data-[slot=command-input-wrapper]:h-11">
        <CommandInput placeholder="Search user..." />
        <CommandList class="p-1">
          <CommandEmpty>No user found.</CommandEmpty>
          <CommandGroup class="[&_[cmdk-group-items]]:flex [&_[cmdk-group-items]]:flex-col [&_[cmdk-group-items]]:gap-1">
            @for (const user of users; key user.id) {
              <CommandItem
                value={user.id}
                onSelect={(currentValue) => {
                  setValue(currentValue === value ? "" : currentValue)
                  setOpen(false)
                }}
              >
                <Avatar class="size-5">
                  <AvatarImage
                    src={`https://github.com/${user.username}.png`}
                  />
                  <AvatarFallback>{user.username[0] as string}</AvatarFallback>
                </Avatar>
                {user.username as string}
                <CheckIcon
                  class={cn(
                    "ml-auto",
                    value === user.id ? "opacity-100" : "opacity-0",
                  )}
                />
              </CommandItem>
            }
          </CommandGroup>
          <CommandSeparator />
          <CommandGroup>
            <CommandItem>
              <PlusCircleIcon />
              Create user
            </CommandItem>
          </CommandGroup>
        </CommandList>
      </Command>
    </PopoverContent>
  </Popover>
}
