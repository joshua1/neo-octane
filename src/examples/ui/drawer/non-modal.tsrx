import { Button } from "@/components/ui/button.tsrx"
import {
  Drawer,
  DrawerClose,
  DrawerContent,
  DrawerFooter,
  DrawerHeader,
  DrawerTitle,
  DrawerTrigger,
} from "@/components/ui/drawer.tsrx"

export default function DrawerNonModalDemo() @{
  <Drawer modal={false} disablePointerDismissal swipeDirection="right">
    <DrawerTrigger render={<Button variant="neutral" />}>
      Non Modal
    </DrawerTrigger>
    <DrawerContent>
      <DrawerHeader>
        <DrawerTitle>Non Modal Drawer</DrawerTitle>
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
