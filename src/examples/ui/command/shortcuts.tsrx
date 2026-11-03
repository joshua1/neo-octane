import { useState } from "octane"
import { CreditCardIcon, SettingsIcon, UserIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
  CommandShortcut,
} from "@/components/ui/command.tsrx"

export default function CommandShortcutsDemo() @{
  const [open, setOpen] = useState(false)

  <div class="flex flex-col gap-4">
    <Button onClick={() => setOpen(true)} variant="neutral" class="w-fit">
      Open Menu
    </Button>
    <CommandDialog open={open} onOpenChange={setOpen}>
      <CommandInput placeholder="Type a command or search..." />
      <CommandList>
        <CommandEmpty>No results found.</CommandEmpty>
        <CommandGroup heading="Settings">
          <CommandItem>
            <UserIcon />
            <span>Profile</span>
            <CommandShortcut>⌘P</CommandShortcut>
          </CommandItem>
          <CommandItem>
            <CreditCardIcon />
            <span>Billing</span>
            <CommandShortcut>⌘B</CommandShortcut>
          </CommandItem>
          <CommandItem>
            <SettingsIcon />
            <span>Settings</span>
            <CommandShortcut>⌘S</CommandShortcut>
          </CommandItem>
        </CommandGroup>
      </CommandList>
    </CommandDialog>
  </div>
}
