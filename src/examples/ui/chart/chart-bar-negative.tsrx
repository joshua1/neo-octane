import { TrendingUp } from "@octanejs/lucide"
import {
  Bar,
  BarChart,
  CartesianGrid,
  Cell,
  LabelList,
} from "@octanejs/recharts"

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

export const description = "A bar chart with negative values"

const chartData = [
  { month: "January", visitors: 186 },
  { month: "February", visitors: 205 },
  { month: "March", visitors: -207 },
  { month: "April", visitors: 173 },
  { month: "May", visitors: -209 },
  { month: "June", visitors: 214 },
]

const chartConfig = {
  visitors: {
    label: "Visitors",
  },
} satisfies ChartConfig

export default function ChartBarNegative() @{
  <Card class="bg-secondary-background text-foreground">
    <CardHeader>
      <CardTitle>Bar Chart - Negative</CardTitle>
      <CardDescription>January - June 2024</CardDescription>
    </CardHeader>
    <CardContent>
      <ChartContainer config={chartConfig}>
        <BarChart accessibilityLayer data={chartData}>
          <CartesianGrid vertical={false} />
          <ChartTooltip
            cursor={false}
            content={<ChartTooltipContent hideLabel hideIndicator />}
          />
          <Bar
            className="[&_.recharts-text]:fill-foreground"
            dataKey="visitors"
          >
            <LabelList position="top" dataKey="month" fillOpacity={1} />
            @for (const item of chartData; key item.month) {
              <Cell
                fill={item.visitors > 0 ? "var(--chart-1)" : "var(--chart-2)"}
              />
            }
          </Bar>
        </BarChart>
      </ChartContainer>
    </CardContent>
    <CardFooter class="flex-col items-start gap-2 text-sm">
      <div class="flex gap-2 leading-none font-medium">
        Trending up by 5.2% this month <TrendingUp class="h-4 w-4" />
      </div>
      <div class="leading-none">
        Showing total visitors for the last 6 months
      </div>
    </CardFooter>
  </Card>
}
