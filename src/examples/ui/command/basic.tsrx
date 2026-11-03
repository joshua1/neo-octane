import { useState } from "octane"
import { Button } from "@/components/ui/button.tsrx"
import {
  CommandDialog,
  CommandEmpty,
  CommandGroup,
  CommandInput,
  CommandItem,
  CommandList,
} from "@/components/ui/command.tsrx"

export default function CommandBasicDemo() @{
  const [open, setOpen] = useState(false)

  <div class="flex flex-col gap-4">
    <Button onClick={() => setOpen(true)} variant="neutral" class="w-fit">
      Open Menu
    </Button>
    <CommandDialog open={open} onOpenChange={setOpen}>
      <CommandInput placeholder="Type a command or search..." />
      <CommandList>
        <CommandEmpty>No results found.</CommandEmpty>
        <CommandGroup heading="Suggestions">
          <CommandItem>Calendar</CommandItem>
          <CommandItem>Search Emoji</CommandItem>
          <CommandItem>Calculator</CommandItem>
        </CommandGroup>
      </CommandList>
    </CommandDialog>
  </div>
}
