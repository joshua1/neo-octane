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

export default function DrawerWithScrollableContent() @{
  <Drawer swipeDirection="right">
    <DrawerTrigger render={<Button />}>Scrollable Content</DrawerTrigger>
    <DrawerContent>
      <DrawerHeader>
        <DrawerTitle>Move Goal</DrawerTitle>
        <DrawerDescription>Set your daily activity goal.</DrawerDescription>
      </DrawerHeader>
      <div class="overflow-y-auto px-4 text-sm">
        <h4 class="mb-4 text-lg leading-none font-heading">Lorem Ipsum</h4>
        @for (
          const index of Array.from({ length: 10 }, (_, i) => i);
          key index
        ) {
          <p class="mb-4 leading-normal">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
            ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
            aliquip ex ea commodo consequat. Duis aute irure dolor in
            reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
            pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
            culpa qui officia deserunt mollit anim id est laborum.
          </p>
        }
      </div>
      <DrawerFooter>
        <Button>Submit</Button>
        <DrawerClose render={<Button variant="neutral" />}>Cancel</DrawerClose>
      </DrawerFooter>
    </DrawerContent>
  </Drawer>
}
