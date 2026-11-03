import { Button } from "@/components/ui/button.tsrx"
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import { Label } from "@/components/ui/label.tsrx"

export default function DialogDemo() @{
  <Dialog>
    <form>
      <DialogTrigger render={<Button />}>Edit Profile</DialogTrigger>
      <DialogContent class="sm:max-w-[425px]">
        <DialogHeader>
          <DialogTitle>Edit profile</DialogTitle>
          <DialogDescription>
            Make changes to your profile here. Click save when you&apos;re done.
          </DialogDescription>
        </DialogHeader>
        <div class="grid gap-4">
          <div class="grid gap-3">
            <Label for="name-1">Name</Label>
            <Input id="name-1" name="name" defaultValue="Pedro Duarte" />
          </div>
          <div class="grid gap-3">
            <Label for="username-1">Username</Label>
            <Input id="username-1" name="username" defaultValue="@octanejs" />
          </div>
        </div>
        <DialogFooter>
          <DialogClose render={<Button variant="neutral" />}>
            Cancel
          </DialogClose>
          <Button type="submit">Save changes</Button>
        </DialogFooter>
      </DialogContent>
    </form>
  </Dialog>
}
