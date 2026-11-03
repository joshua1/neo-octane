import { PencilIcon, ShareIcon, TrashIcon } from "@octanejs/lucide"

import {
  ContextMenu,
  ContextMenuContent,
  ContextMenuGroup,
  ContextMenuItem,
  ContextMenuSeparator,
  ContextMenuTrigger,
} from "@/components/ui/context-menu.tsrx"

export default function ContextMenuDestructiveDemo() @{
  <ContextMenu>
    <ContextMenuTrigger class="flex aspect-video w-full max-w-xs items-center justify-center rounded-base border-2 border-dashed border-border text-sm font-base">
      <span class="hidden pointer-fine:inline-block">Right click here</span>
      <span class="hidden pointer-coarse:inline-block">Long press here</span>
    </ContextMenuTrigger>
    <ContextMenuContent>
      <ContextMenuGroup>
        <ContextMenuItem>
          <PencilIcon />
          Edit
        </ContextMenuItem>
        <ContextMenuItem>
          <ShareIcon />
          Share
        </ContextMenuItem>
      </ContextMenuGroup>
      <ContextMenuSeparator />
      <ContextMenuGroup>
        <ContextMenuItem variant="destructive">
          <TrashIcon />
          Delete
        </ContextMenuItem>
      </ContextMenuGroup>
    </ContextMenuContent>
  </ContextMenu>
}
