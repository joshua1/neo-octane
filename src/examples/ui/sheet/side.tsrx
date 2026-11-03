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

const SHEET_SIDES = ["top", "right", "bottom", "left"] as const

const PARAGRAPHS = Array.from({ length: 10 })

export default function SheetSideDemo() @{
  <div class="flex gap-2">
    @for (const side of SHEET_SIDES; key side) {
      <Sheet>
        <SheetTrigger render={<Button variant="noShadow" class="capitalize" />}>
          {side as string}
        </SheetTrigger>
        <SheetContent side={side}>
          <SheetHeader>
            <SheetTitle>Edit profile</SheetTitle>
            <SheetDescription>
              Make changes to your profile here. Click save when you&apos;re
              done.
            </SheetDescription>
          </SheetHeader>
          <div class="overflow-y-auto px-4 text-sm">
            <h4 class="mb-4 text-lg leading-none font-medium">Lorem Ipsum</h4>
            @for (const _ of PARAGRAPHS; index i; key i) {
              <p class="mb-4 leading-normal">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do
                eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
                enim ad minim veniam, quis nostrud exercitation ullamco laboris
                nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
                in reprehenderit in voluptate velit esse cillum dolore eu fugiat
                nulla pariatur. Excepteur sint occaecat cupidatat non proident,
                sunt in culpa qui officia deserunt mollit anim id est laborum.
              </p>
            }
          </div>
          <SheetFooter>
            <Button type="submit">Save changes</Button>
            <SheetClose render={<Button variant="neutral" />}>
              Cancel
            </SheetClose>
          </SheetFooter>
        </SheetContent>
      </Sheet>
    }
  </div>
}
