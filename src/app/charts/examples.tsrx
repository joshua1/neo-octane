import type { OctaneNode } from "octane"

import { type ChartExample, charts } from "@/data/charts"

import { Pre } from "@/components/app/pre.tsrx"
import { Button } from "@/components/ui/button.tsrx"
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogTrigger,
} from "@/components/ui/dialog.tsrx"

/** Looks up the named charts, dropping any that are missing (as the original's `if (!chart) return null`). */
function pick(...names: string[]): ChartExample[] {
  return names
    .map((name) => charts.find((chart) => chart.name === name))
    .filter((chart): chart is ChartExample => !!chart)
}

const OVERVIEW = pick(
  "ChartAreaStacked",
  "ChartBarMultiple",
  "ChartPieDonutText",
)

const AREA = pick(
  "ChartAreaDefault",
  "ChartAreaLinear",
  "ChartAreaStep",
  "ChartAreaStackedExpand",
  "ChartAreaLegend",
  "ChartAreaIcons",
  "ChartAreaAxes",
)
const AREA_WIDE = pick("ChartAreaInteractive")

const BAR = pick(
  "ChartBarDefault",
  "ChartBarHorizontal",
  "ChartBarMultiple",
  "ChartBarLabel",
  "ChartBarLabelCustom",
  "ChartBarMixed",
  "ChartBarStacked",
  "ChartBarActive",
  "ChartBarNegative",
)
const BAR_WIDE = pick("ChartBarInteractive")

const LINE = pick(
  "ChartLineDefault",
  "ChartLineLinear",
  "ChartLineStep",
  "ChartLineMultiple",
  "ChartLineDots",
  "ChartLineDotsCustom",
  "ChartLineDotsColors",
  "ChartLineLabel",
  "ChartLineLabelCustom",
)
const LINE_WIDE = pick("ChartLineInteractive")

const PIE = pick(
  "ChartPieSimple",
  "ChartPieLabel",
  "ChartPieLabelCustom",
  "ChartPieLabelList",
  "ChartPieLegend",
  "ChartPieDonut",
  "ChartPieDonutActive",
  "ChartPieDonutText",
  "ChartPieStacked",
)

const TOOLTIP = pick(
  "ChartTooltipDefault",
  "ChartTooltipIndicatorLine",
  "ChartTooltipIndicatorNone",
  "ChartTooltipLabelCustom",
  "ChartTooltipLabelFormatter",
  "ChartTooltipLabelNone",
  "ChartTooltipFormatter",
  "ChartTooltipIcons",
  "ChartTooltipAdvanced",
)

/** Renders a list of charts, each with its copy dialog. */
function ChartList({ items }: { items: ChartExample[] }) @{
  <>
    @for (const chart of items; key chart.name) {
      <ChartComponent chart={chart}>
        <chart.component />
      </ChartComponent>
    }
  </>
}

export default function Examples() @{
  <div>
    <div class="grid flex-1 gap-12">
      <h2 class="sr-only">Examples</h2>
      <div
        id="examples"
        class="grid flex-1 scroll-mt-20 items-start gap-10 md:grid-cols-2 md:gap-6 lg:grid-cols-3 xl:gap-10"
      >
        <ChartList items={OVERVIEW} />
      </div>
      <div
        id="area-chart"
        class="grid flex-1 scroll-mt-20 items-start gap-10 md:grid-cols-2 md:gap-6 lg:grid-cols-3 xl:gap-10"
      >
        <ChartList items={AREA} />
        <div class="md:col-span-2 lg:col-span-3">
          <ChartList items={AREA_WIDE} />
        </div>
      </div>
      <div
        id="bar-chart"
        class="grid flex-1 scroll-mt-20 items-start gap-10 md:grid-cols-2 md:gap-6 lg:grid-cols-3 xl:gap-10"
      >
        <ChartList items={BAR} />
        <div class="md:col-span-2 lg:col-span-3">
          <ChartList items={BAR_WIDE} />
        </div>
      </div>
      <div
        id="line-chart"
        class="grid flex-1 scroll-mt-20 items-start gap-10 md:grid-cols-2 md:gap-6 lg:grid-cols-3 xl:gap-10"
      >
        <ChartList items={LINE} />
        <div class="md:col-span-2 lg:col-span-3">
          <ChartList items={LINE_WIDE} />
        </div>
      </div>
      <div
        id="pie-chart"
        class="grid flex-1 scroll-mt-20 items-start gap-10 md:grid-cols-2 md:gap-6 lg:grid-cols-3 xl:gap-10"
      >
        <ChartList items={PIE} />
      </div>
      <div
        id="tooltip"
        class="chart-wrapper grid flex-1 scroll-mt-20 items-start gap-10 md:grid-cols-2 md:gap-6 lg:grid-cols-3 xl:gap-10"
      >
        <ChartList items={TOOLTIP} />
      </div>
    </div>
  </div>
}

function ChartComponent({
  children,
  chart,
}: {
  children: OctaneNode
  chart: ChartExample
}) @{
  const { code, name } = chart

  <div>
    {children}
    <Dialog>
      <DialogTrigger render={<Button class="mt-5 w-full" />}>
        Copy
      </DialogTrigger>
      <DialogContent class="max-w-full">
        <DialogHeader>
          <DialogTitle>{name as string}</DialogTitle>
        </DialogHeader>
        <Pre
          wrapperClassName="w-full max-w-full text-white overflow-x-auto"
          __rawstring__={code}
        >
          {code as string}
        </Pre>
      </DialogContent>
    </Dialog>
  </div>
}
