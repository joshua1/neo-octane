import { Trash2Icon } from "@octanejs/lucide"

import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogMedia,
  AlertDialogTitle,
  AlertDialogTrigger,
} from "@/components/ui/alert-dialog.tsrx"
import { Button } from "@/components/ui/button.tsrx"

export default function AlertDialogDestructiveDemo() @{
  <AlertDialog>
    <AlertDialogTrigger render={<Button />}>Delete Chat</AlertDialogTrigger>
    <AlertDialogContent size="sm">
      <AlertDialogHeader>
        <AlertDialogMedia class="bg-black text-white">
          <Trash2Icon />
        </AlertDialogMedia>
        <AlertDialogTitle>Delete chat?</AlertDialogTitle>
        <AlertDialogDescription>
          This will permanently delete this chat conversation. View{" "}
          <a href="#" class="underline underline-offset-4">
            Settings
          </a>{" "}
          delete any memories saved during this chat.
        </AlertDialogDescription>
      </AlertDialogHeader>
      <AlertDialogFooter>
        <AlertDialogCancel>Cancel</AlertDialogCancel>
        <AlertDialogAction>Delete</AlertDialogAction>
      </AlertDialogFooter>
    </AlertDialogContent>
  </AlertDialog>
}
