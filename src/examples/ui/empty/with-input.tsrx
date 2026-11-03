import { Button } from "@/components/ui/button.tsrx"
import {
  Empty,
  EmptyContent,
  EmptyDescription,
  EmptyHeader,
  EmptyTitle,
} from "@/components/ui/empty.tsrx"
import { Input } from "@/components/ui/input.tsrx"

export default function EmptyWithInputDemo() @{
  <Empty class="max-w-md">
    <EmptyHeader>
      <EmptyTitle>404 - Not Found</EmptyTitle>
      <EmptyDescription>
        The page you&apos;re looking for doesn&apos;t exist. Try searching for
        what you need below.
      </EmptyDescription>
    </EmptyHeader>
    <EmptyContent>
      <div class="flex w-full items-center gap-2">
        <Input placeholder="Try searching for pages..." />
        <Button variant="noShadow" size="sm">
          Search
        </Button>
      </div>
      <EmptyDescription>
        Need help? <a href="#">Contact support</a>
      </EmptyDescription>
    </EmptyContent>
  </Empty>
}
