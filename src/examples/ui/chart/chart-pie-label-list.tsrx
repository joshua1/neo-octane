import { TrendingUp } from "@octanejs/lucide"
import { LabelList, Pie, PieChart } from "@octanejs/recharts"

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

export const description = "A pie chart with a label list"

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

export default function ChartPieLabelList() @{
  <Card class="flex flex-col bg-secondary-background text-foreground">
    <CardHeader class="items-center pb-0">
      <CardTitle>Pie Chart - Label List</CardTitle>
      <CardDescription>January - June 2024</CardDescription>
    </CardHeader>
    <CardContent class="flex-1 pb-0">
      <ChartContainer
        config={chartConfig}
        class="[&_.recharts-text]:fill-main-foreground mx-auto aspect-square max-h-[250px]"
      >
        <PieChart>
          <ChartTooltip
            content={<ChartTooltipContent nameKey="visitors" hideLabel />}
          />
          <Pie data={chartData} dataKey="visitors">
            <LabelList
              dataKey="browser"
              className="fill-main-foreground"
              stroke="none"
              fontSize={12}
              formatter={(value) =>
                chartConfig[value as keyof typeof chartConfig]?.label
              }
            />
          </Pie>
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
