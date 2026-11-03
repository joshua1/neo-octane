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

export default function DrawerDemo() @{
  <Drawer>
    <DrawerTrigger render={<Button />}>Open</DrawerTrigger>
    <DrawerContent>
      <div class="mx-auto w-[300px]">
        <DrawerHeader>
          <DrawerTitle>Are you absolutely sure?</DrawerTitle>
          <DrawerDescription>This action cannot be undone.</DrawerDescription>
        </DrawerHeader>
        <DrawerFooter class="grid grid-cols-2">
          <Button variant="noShadow">Submit</Button>
          <DrawerClose
            render={
              <Button
                class="bg-secondary-background text-foreground"
                variant="noShadow"
              />
            }
          >
            Cancel
          </DrawerClose>
        </DrawerFooter>
      </div>
    </DrawerContent>
  </Drawer>
}
