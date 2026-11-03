import {
  FileIcon,
  FolderIcon,
  HelpCircleIcon,
  SaveIcon,
  SettingsIcon,
  TrashIcon,
} from "@octanejs/lucide"

import {
  Menubar,
  MenubarContent,
  MenubarGroup,
  MenubarItem,
  MenubarMenu,
  MenubarSeparator,
  MenubarShortcut,
  MenubarTrigger,
} from "@/components/ui/menubar.tsrx"

export default function MenubarWithIconsDemo() @{
  <Menubar class="w-72">
    <MenubarMenu>
      <MenubarTrigger>File</MenubarTrigger>
      <MenubarContent>
        <MenubarItem>
          <FileIcon />
          New File <MenubarShortcut>⌘N</MenubarShortcut>
        </MenubarItem>
        <MenubarItem>
          <FolderIcon />
          Open Folder
        </MenubarItem>
        <MenubarSeparator />
        <MenubarItem>
          <SaveIcon />
          Save <MenubarShortcut>⌘S</MenubarShortcut>
        </MenubarItem>
      </MenubarContent>
    </MenubarMenu>
    <MenubarMenu>
      <MenubarTrigger>More</MenubarTrigger>
      <MenubarContent>
        <MenubarGroup>
          <MenubarItem>
            <SettingsIcon />
            Settings
          </MenubarItem>
          <MenubarItem>
            <HelpCircleIcon />
            Help
          </MenubarItem>
          <MenubarSeparator />
          <MenubarItem>
            <TrashIcon />
            Delete
          </MenubarItem>
        </MenubarGroup>
      </MenubarContent>
    </MenubarMenu>
  </Menubar>
}
