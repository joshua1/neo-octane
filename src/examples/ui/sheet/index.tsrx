import { Button } from "@/components/ui/button.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import { Label } from "@/components/ui/label.tsrx"
import {
  Sheet,
  SheetClose,
  SheetContent,
  SheetDescription,
  SheetFooter,
  SheetHeader,
  SheetTitle,
  SheetTrigger,
} from "@/components/ui/sheet.tsrx"

export default function SheetDemo() @{
  <Sheet>
    <SheetTrigger render={<Button />}>Open</SheetTrigger>
    <SheetContent>
      <SheetHeader>
        <SheetTitle>Edit profile</SheetTitle>
        <SheetDescription>
          Make changes to your profile here. Click save when you&apos;re done.
        </SheetDescription>
      </SheetHeader>
      <div class="grid flex-1 auto-rows-min gap-6 px-4">
        <div class="grid gap-3">
          <Label for="sheet-demo-name">Name</Label>
          <Input id="sheet-demo-name" defaultValue="Pedro Duarte" />
        </div>
        <div class="grid gap-3">
          <Label for="sheet-demo-username">Username</Label>
          <Input id="sheet-demo-username" defaultValue="@octanejs" />
        </div>
      </div>
      <SheetFooter>
        <Button type="submit">Save changes</Button>
        <SheetClose render={<Button variant="neutral" />}>Close</SheetClose>
      </SheetFooter>
    </SheetContent>
  </Sheet>
}
