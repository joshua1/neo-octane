import { TrendingUp } from "@octanejs/lucide"
import { Label, Pie, PieChart, Sector, type PieProps } from "@octanejs/recharts"

import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card.tsrx"
import {
  type ChartConfig,
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
} from "@/components/ui/chart.tsrx"

// PieSectorShapeProps is not re-exported by @octanejs/recharts; derive it
// from the Pie `shape` prop.
type PieSectorShapeProps = Parameters<
  Extract<NonNullable<PieProps["shape"]>, (...args: any[]) => any>
>[0]

export const description = "A donut chart with an active sector"

const chartData = [
  { browser: "chrome", visitors: 275, fill: "var(--color-chrome)" },
  { browser: "safari", visitors: 200, fill: "var(--color-safari)" },
  { browser: "firefox", visitors: 187, fill: "var(--color-firefox)" },
  { browser: "edge", visitors: 173, fill: "var(--color-edge)" },
  { browser: "other", visitors: 90, fill: "var(--color-other)" },
]

const chartConfig = {
  visitors: {
    label: "Visitors",
  },
  chrome: {
    label: "Chrome",
    color: "var(--chart-1)",
  },
  safari: {
    label: "Safari",
    color: "var(--chart-2)",
  },
  firefox: {
    label: "Firefox",
    color: "var(--chart-3)",
  },
  edge: {
    label: "Edge",
    color: "var(--chart-4)",
  },
  other: {
    label: "Other",
    color: "var(--chart-5)",
  },
} satisfies ChartConfig

const ACTIVE_INDEX = 0

export default function ChartPieDonutActive() @{
  <Card class="flex flex-col bg-secondary-background text-foreground">
    <CardHeader class="items-center pb-0">
      <CardTitle>Pie Chart - Donut Active</CardTitle>
      <CardDescription>January - June 2024</CardDescription>
    </CardHeader>
    <CardContent class="flex-1 pb-0">
      <ChartContainer
        config={chartConfig}
        class="mx-auto aspect-square max-h-[250px]"
      >
        <PieChart>
          <ChartTooltip
            cursor={false}
            content={<ChartTooltipContent hideLabel />}
          />
          <Pie
            data={chartData}
            dataKey="visitors"
            nameKey="browser"
            innerRadius={60}
            strokeWidth={5}
            shape={({
              index,
              outerRadius = 0,
              ...props
            }: PieSectorShapeProps) =>
              index === ACTIVE_INDEX ? (
                <Sector {...props} outerRadius={outerRadius + 10} />
              ) : (
                <Sector {...props} outerRadius={outerRadius} />
              )
            }
          />
        </PieChart>
      </ChartContainer>
    </CardContent>
    <CardFooter class="flex-col gap-2 text-sm">
      <div class="flex items-center gap-2 leading-none font-medium">
        Trending up by 5.2% this month <TrendingUp class="h-4 w-4" />
      </div>
      <div class="leading-none">
        Showing total visitors for the last 6 months
      </div>
    </CardFooter>
  </Card>
}
