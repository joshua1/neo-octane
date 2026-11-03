import ChartBarMultiple from "@/examples/ui/chart/chart-bar-multiple.tsrx"

import AlertDemo from "./demos/alert.tsrx"
import ChatDemo from "./demos/chat.tsrx"
import CollapsibleDemo from "./demos/collapsible.tsrx"
import InputGroupDemo from "./demos/input-group.tsrx"
import InputGroupTextareaDemo from "./demos/input-group-textarea.tsrx"
import ItemsDemo from "./demos/items.tsrx"
import ScrollAreaDemo from "./demos/scroll-area.tsrx"
import SettingsDemo from "./demos/settings.tsrx"
import SliderDemo from "./demos/slider.tsrx"

export default function ExampleComponents() @{
  <div class="w-full grid lg:grid-cols-3 sm:grid-cols-2 grid-cols-1 mt-10 gap-5 not-prose">
    <div class="flex flex-col gap-5">
      <SettingsDemo />
      <InputGroupDemo />
      <CollapsibleDemo />
      <SliderDemo />
      <AlertDemo />
      <InputGroupTextareaDemo />
    </div>
    <div class="lg:flex hidden flex-col gap-5">
      <ChatDemo />
      <ItemsDemo />
    </div>
    <div class="flex flex-col gap-5 max-sm:order-first">
      <ChartBarMultiple />
      <div class="max-sm:hidden">
        <ScrollAreaDemo />
      </div>
    </div>
  </div>
}
