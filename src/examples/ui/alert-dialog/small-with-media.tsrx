import { BluetoothIcon } from "@octanejs/lucide"

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

export default function AlertDialogSmallWithMediaDemo() @{
  <AlertDialog>
    <AlertDialogTrigger render={<Button variant="neutral" />}>
      Show Dialog
    </AlertDialogTrigger>
    <AlertDialogContent size="sm">
      <AlertDialogHeader>
        <AlertDialogMedia>
          <BluetoothIcon />
        </AlertDialogMedia>
        <AlertDialogTitle>Allow accessory to connect?</AlertDialogTitle>
        <AlertDialogDescription>
          Do you want to allow the USB accessory to connect to this device?
        </AlertDialogDescription>
      </AlertDialogHeader>
      <AlertDialogFooter>
        <AlertDialogCancel size="sm">Don&apos;t allow</AlertDialogCancel>
        <AlertDialogAction size="sm">Allow</AlertDialogAction>
      </AlertDialogFooter>
    </AlertDialogContent>
  </AlertDialog>
}
