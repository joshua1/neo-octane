import { AppWindowIcon, CodeIcon } from "@octanejs/lucide"

import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs.tsrx"

export default function TabsIconsDemo() @{
  <Tabs defaultValue="preview" class="w-fit">
    <TabsList>
      <TabsTrigger value="preview">
        <AppWindowIcon />
        Preview
      </TabsTrigger>
      <TabsTrigger value="code">
        <CodeIcon />
        Code
      </TabsTrigger>
    </TabsList>
  </Tabs>
}
