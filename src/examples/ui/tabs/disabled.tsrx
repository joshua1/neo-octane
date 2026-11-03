import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs.tsrx"

export default function TabsDisabledDemo() @{
  <Tabs defaultValue="home" class="w-fit">
    <TabsList>
      <TabsTrigger value="home">Home</TabsTrigger>
      <TabsTrigger value="settings" disabled>
        Disabled
      </TabsTrigger>
    </TabsList>
  </Tabs>
}
