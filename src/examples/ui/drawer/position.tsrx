import { Button } from "@/components/ui/button.tsrx"
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerDescription,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer.tsrx"

export default function DrawerPositionDemo() @{
  <Drawer swipeDirection="left">
    <DrawerTrigger render={<Button variant="neutral" />}>
      Open Left Drawer
    </DrawerTrigger>
    <DrawerContent>
      <DrawerHeader>
        <DrawerTitle>Move Goal</DrawerTitle>
        <DrawerDescription>Set your daily activity goal.</DrawerDescription>
      </DrawerHeader>
      <div class="flex-1 p-4">
        <div class="size-full rounded-base bg-secondary-background" />
      </div>
      <DrawerFooter>
        <DrawerClose render={<Button />}>Close</DrawerClose>
      </DrawerFooter>
    </DrawerContent>
  </Drawer>
}
