import { CircleFadingPlusIcon } from "@octanejs/lucide"

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

export default function AlertDialogMediaDemo() @{
  <AlertDialog>
    <AlertDialogTrigger render={<Button variant="neutral" />}>
      Share Project
    </AlertDialogTrigger>
    <AlertDialogContent>
      <AlertDialogHeader>
        <AlertDialogMedia>
          <CircleFadingPlusIcon />
        </AlertDialogMedia>
        <AlertDialogTitle>Share this project?</AlertDialogTitle>
        <AlertDialogDescription>
          Anyone with the link will be able to view and edit this project.
        </AlertDialogDescription>
      </AlertDialogHeader>
      <AlertDialogFooter>
        <AlertDialogCancel>Cancel</AlertDialogCancel>
        <AlertDialogAction>Share</AlertDialogAction>
      </AlertDialogFooter>
    </AlertDialogContent>
  </AlertDialog>
}
