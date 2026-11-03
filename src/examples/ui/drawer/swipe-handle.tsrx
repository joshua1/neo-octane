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

export default function DrawerSwipeHandleDemo() @{
  <Drawer showSwipeHandle>
    <DrawerTrigger render={<Button variant="neutral" />}>
      Open Drawer
    </DrawerTrigger>
    <DrawerContent>
      <DrawerHeader>
        <DrawerTitle>Drawer</DrawerTitle>
        <DrawerDescription>Drawer with a swipe handle.</DrawerDescription>
      </DrawerHeader>
      <div class="flex-1 p-4">
        <div class="rounded-base bg-secondary-background group-data-[swipe-axis=x]/drawer-popup:size-full group-data-[swipe-axis=y]/drawer-popup:h-80 group-data-[swipe-axis=y]/drawer-popup:w-full" />
      </div>
      <DrawerFooter>
        <DrawerClose render={<Button />}>Close</DrawerClose>
      </DrawerFooter>
    </DrawerContent>
  </Drawer>
}
