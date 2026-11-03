import { FolderIcon, PlusIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import {
  Empty,
  EmptyContent,
  EmptyDescription,
  EmptyHeader,
  EmptyMedia,
  EmptyTitle,
} from "@/components/ui/empty.tsrx"

export default function EmptyDemo() @{
  <Empty class="max-w-md">
    <EmptyHeader>
      <EmptyMedia variant="icon">
        <FolderIcon />
      </EmptyMedia>
      <EmptyTitle>No projects yet</EmptyTitle>
      <EmptyDescription>
        You haven&apos;t created any projects yet. Get started by creating your
        first project.
      </EmptyDescription>
    </EmptyHeader>
    <EmptyContent>
      <Button size="sm">
        <PlusIcon />
        Create project
      </Button>
    </EmptyContent>
  </Empty>
}
