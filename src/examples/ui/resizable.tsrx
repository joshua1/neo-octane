import {
  ResizableHandle,
  ResizablePanel,
  ResizablePanelGroup,
} from "@/components/ui/resizable.tsrx"

export default function ResizableDemo() @{
  <ResizablePanelGroup
    orientation="horizontal"
    class="rounded-base max-w-md border-2 border-border text-foreground shadow-shadow"
  >
    <ResizablePanel defaultSize={50}>
      <div class="flex h-[200px] items-center justify-center bg-background p-6">
        <span class="font-base">One</span>
      </div>
    </ResizablePanel>
    <ResizableHandle />
    <ResizablePanel defaultSize={50}>
      <ResizablePanelGroup orientation="vertical">
        <ResizablePanel defaultSize={25}>
          <div class="flex h-full items-center justify-center bg-background p-6">
            <span class="font-base">Two</span>
          </div>
        </ResizablePanel>
        <ResizableHandle />
        <ResizablePanel defaultSize={75}>
          <div class="flex h-full items-center justify-center bg-background p-6">
            <span class="font-base">Three</span>
          </div>
        </ResizablePanel>
      </ResizablePanelGroup>
    </ResizablePanel>
  </ResizablePanelGroup>
}
