import { useState } from "octane"
import { useIsMobile } from "@/hooks/use-mobile"

import { Button } from "@/components/ui/button.tsrx"
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog.tsrx"
import {
  Drawer,
  DrawerContent,
  DrawerDescription,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import { Label } from "@/components/ui/label.tsrx"

import { cn, type ClassValue } from "@/lib/utils"

export default function DrawerResponsiveDemo() @{
  const [open, setOpen] = useState(false)
  const isMobile = useIsMobile()

  <>
    @if (!isMobile) {
      <Dialog open={open} onOpenChange={setOpen}>
        <DialogTrigger render={<Button variant="neutral" />}>
          Edit Profile
        </DialogTrigger>
        <DialogContent class="sm:max-w-[425px]">
          <DialogHeader>
            <DialogTitle>Edit profile</DialogTitle>
            <DialogDescription>
              Make changes to your profile here. Click save when you&apos;re
              done.
            </DialogDescription>
          </DialogHeader>
          <ProfileForm />
        </DialogContent>
      </Dialog>
    } @else {
      <Drawer open={open} onOpenChange={setOpen}>
        <DrawerTrigger render={<Button variant="neutral" />}>
          Edit Profile
        </DrawerTrigger>
        <DrawerContent>
          <DrawerHeader class="text-left">
            <DrawerTitle>Edit profile</DrawerTitle>
            <DrawerDescription>
              Make changes to your profile here. Click save when you&apos;re
              done.
            </DrawerDescription>
          </DrawerHeader>
          <ProfileForm class="p-4" />
        </DrawerContent>
      </Drawer>
    }
  </>
}

function ProfileForm({
  class: klass,
  className,
}: {
  class?: ClassValue
  className?: string
}) @{
  <form class={cn("grid items-start gap-6", className, klass)}>
    <div class="grid gap-3">
      <Label for="email">Email</Label>
      <Input type="email" id="email" defaultValue="shadcn@example.com" />
    </div>
    <div class="grid gap-3">
      <Label for="username">Username</Label>
      <Input id="username" defaultValue="@shadcn" />
    </div>
    <Button type="submit">Save changes</Button>
  </form>
}
