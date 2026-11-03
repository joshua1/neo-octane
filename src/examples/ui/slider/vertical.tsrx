import { Slider } from "@/components/ui/slider.tsrx"

export default function VerticalSliderDemo() @{
  <Slider defaultValue={[25]} max={100} step={1} orientation="vertical" />
}
