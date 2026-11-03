import { Tabs, TabsList, TabsTrigger } from "@/components/ui/tabs.tsrx"

export default function TabsVerticalDemo() @{
  <Tabs defaultValue="account" orientation="vertical" class="w-fit">
    <TabsList>
      <TabsTrigger value="account">Account</TabsTrigger>
      <TabsTrigger value="password">Password</TabsTrigger>
      <TabsTrigger value="notifications">Notifications</TabsTrigger>
    </TabsList>
  </Tabs>
}
