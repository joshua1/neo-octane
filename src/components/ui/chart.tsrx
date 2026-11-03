import type { ClassValue } from "clsx"
import * as RechartsPrimitive from "@octanejs/recharts"
import type { NameType, ValueType } from "@octanejs/recharts"

import {
  createContext,
  createElement,
  useContext,
  useId,
  useMemo,
  type OctaneNode,
} from "octane"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

// Format: { THEME_NAME: CSS_SELECTOR }
const THEMES = { light: "" } as const

const INITIAL_DIMENSION = { width: 320, height: 200 } as const
type TooltipValueType = ValueType
type TooltipNameType = NameType

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

export type ChartConfig = Record<
  string,
  {
    label?: OctaneNode
    icon?: (props: Record<string, any>) => OctaneNode
  } & (
    | { color?: string; theme?: never }
    | { color?: never; theme: Record<keyof typeof THEMES, string> }
  )
>

type ChartContextProps = {
  config: ChartConfig
}

const ChartContext = createContext<ChartContextProps | null>(null)

function useChart() {
  const context = useContext(ChartContext)

  if (!context) {
    throw new Error("useChart must be used within a <ChartContainer />")
  }

  return context
}

function ChartContainer({
  id,
  class: klass,
  className,
  children,
  config,
  initialDimension = INITIAL_DIMENSION,
  ...props
}: DivProps & {
  config: ChartConfig
  children: RechartsPrimitive.ResponsiveContainerProps["children"]
  initialDimension?: {
    width: number
    height: number
  }
}) @{
  const uniqueId = useId()
  const chartId = `chart-${id ?? uniqueId.replace(/:/g, "")}`

  <ChartContext value={{ config }}>
    <div
      data-slot="chart"
      data-chart={chartId}
      class={cn(
        "flex aspect-video justify-center text-xs [&_.recharts-cartesian-axis-tick_text]:fill-foreground [&_.recharts-cartesian-grid_line[stroke='#ccc']]:stroke-[#80808080] [&_.recharts-curve.recharts-tooltip-cursor]:stroke-[#80808080] [&_.recharts-dot[stroke='#fff']]:stroke-transparent [&_.recharts-layer]:outline-hidden [&_.recharts-polar-grid_[stroke='#ccc']]:stroke-black [&_.recharts-reference-line_[stroke='#ccc']]:stroke-black [&_.recharts-sector]:outline-hidden [&_.recharts-sector[stroke='#fff']]:stroke-border [&_.recharts-surface]:outline-hidden",
        "[&_.recharts-layer_path]:[fill-opacity:1] [&_.recharts-layer_path]:[stroke-width:2] [&_.recharts-layer_path]:[stroke:var(--color-border)]",
        className,
        klass,
      )}
      {...props}
    >
      <ChartStyle id={chartId} config={config} />
      <RechartsPrimitive.ResponsiveContainer
        initialDimension={initialDimension}
      >
        {children}
      </RechartsPrimitive.ResponsiveContainer>
    </div>
  </ChartContext>
}

// The dynamic chart CSS is injected through createElement: the installed
// tsrx compiler treats any JSX <style> (even with dangerouslySetInnerHTML) as
// a scoped style block and rejects the attribute.
const ChartStyle = ({ id, config }: { id: string; config: ChartConfig }) => {
  const colorConfig = Object.entries(config).filter(
    ([, config]) => config.theme ?? config.color,
  )

  if (!colorConfig.length) {
    return null
  }

  const css = Object.entries(THEMES)
    .map(
      ([theme, prefix]) => `
${prefix} [data-chart=${id}] {
${colorConfig
  .map(([key, itemConfig]) => {
    const color =
      itemConfig.theme?.[theme as keyof typeof itemConfig.theme] ??
      itemConfig.color
    return color ? `  --color-${key}: ${color};` : null
  })
  .join("\n")}
}
`,
    )
    .join("\n")

  return createElement("style", { dangerouslySetInnerHTML: { __html: css } })
}

const ChartTooltip = RechartsPrimitive.Tooltip

function ChartTooltipContent({
  active,
  payload,
  class: klass,
  className,
  indicator = "dot",
  hideLabel = false,
  hideIndicator = false,
  label,
  labelFormatter,
  labelClassName,
  formatter,
  color,
  nameKey,
  labelKey,
}: RechartsPrimitive.TooltipProps<TooltipValueType, TooltipNameType> &
  DivProps & {
    hideLabel?: boolean
    hideIndicator?: boolean
    indicator?: "line" | "dot" | "dashed"
    nameKey?: string
    labelKey?: string
  } & Omit<
    RechartsPrimitive.DefaultTooltipContentProps<
      TooltipValueType,
      TooltipNameType
    >,
    "accessibilityLayer"
  >) {
  const { config } = useChart()

  const tooltipLabel = useMemo(() => {
    if (hideLabel || !payload?.length) {
      return null
    }

    const [item] = payload
    const key = `${labelKey ?? item?.dataKey ?? item?.name ?? "value"}`
    const itemConfig = getPayloadConfigFromPayload(config, item, key)
    const value =
      !labelKey && typeof label === "string"
        ? (config[label]?.label ?? label)
        : itemConfig?.label

    if (labelFormatter) {
      return (
        <div class={cn("font-heading", labelClassName)}>
          {labelFormatter(value, payload)}
        </div>
      )
    }

    if (!value) {
      return null
    }

    return <div class={cn("font-base", labelClassName)}>{value}</div>
  }, [
    label,
    labelFormatter,
    payload,
    hideLabel,
    labelClassName,
    config,
    labelKey,
  ])

  if (!active || !payload?.length) {
    return null
  }

  const nestLabel = payload.length === 1 && indicator !== "dot"
  const items = payload.filter((item) => item.type !== "none")

  return (
    <div
      class={cn(
        "border-border bg-secondary-background grid min-w-[8rem] items-start gap-1.5 rounded-lg border-2 px-2.5 py-1.5 text-xs shadow-xl",
        className,
        klass,
      )}
    >
      {!nestLabel ? tooltipLabel : null}
      <div class="grid gap-1.5">
        @for (const item of items; index index; key index) {
          const key = `${nameKey ?? item.name ?? item.dataKey ?? "value"}`
          const itemConfig = getPayloadConfigFromPayload(config, item, key)
          const indicatorColor = color ?? item.payload?.fill ?? item.color
          const Icon = itemConfig?.icon

          <div
            class={cn(
              "flex w-full flex-wrap items-stretch gap-2 [&>svg]:h-2.5 [&>svg]:w-2.5 [&>svg]:text-foreground",
              indicator === "dot" && "items-center",
            )}
          >
            @if (formatter && item?.value !== undefined && item.name) {
              <>{formatter(item.value, item.name, item, index, item.payload)}</>
            } @else {
              <>
                @if (Icon) {
                  <Icon />
                } @else if (!hideIndicator) {
                  <div
                    class={cn("shrink-0 rounded-[2px] bg-(--color-bg)", {
                      "size-3.5 border border-border": indicator === "dot",
                      "w-2 border border-border": indicator === "line",
                      "w-0 border-[1.5px] border-dashed bg-transparent":
                        indicator === "dashed",
                      "my-0.5": nestLabel && indicator === "dashed",
                    })}
                    style={
                      {
                        "--color-bg": indicatorColor,
                        ...(indicator === "dashed" && {
                          "--color-border": indicatorColor,
                        }),
                      } as Record<string, string>
                    }
                  />
                }
                <div
                  class={cn(
                    "flex flex-1 justify-between leading-none",
                    nestLabel ? "items-end" : "items-center",
                  )}
                >
                  <div class="grid gap-1.5">
                    {nestLabel ? tooltipLabel : null}
                    <span class="text-foreground">
                      {itemConfig?.label ?? item.name}
                    </span>
                  </div>
                  @if (item.value != null) {
                    <span class="font-mono font-medium text-foreground tabular-nums">
                      {
                        (typeof item.value === "number"
                          ? item.value.toLocaleString()
                          : String(item.value)) as string
                      }
                    </span>
                  }
                </div>
              </>
            }
          </div>
        }
      </div>
    </div>
  )
}

const ChartLegend = RechartsPrimitive.Legend

function ChartLegendContent({
  class: klass,
  className,
  hideIcon = false,
  payload,
  verticalAlign = "bottom",
  nameKey,
}: DivProps & {
  hideIcon?: boolean
  nameKey?: string
} & RechartsPrimitive.DefaultLegendContentProps) {
  const { config } = useChart()

  if (!payload?.length) {
    return null
  }

  const items = payload.filter((item) => item.type !== "none")

  return (
    <div
      class={cn(
        "flex items-center justify-center gap-4",
        verticalAlign === "top" ? "pb-3" : "pt-3",
        className,
        klass,
      )}
    >
      @for (const item of items; index index; key index) {
        const key = `${nameKey ?? item.dataKey ?? "value"}`
        const itemConfig = getPayloadConfigFromPayload(config, item, key)
        const Icon = itemConfig?.icon

        <div
          class={cn(
            "flex items-center gap-1.5 [&>svg]:h-3 [&>svg]:w-3 [&>svg]:text-foreground",
          )}
        >
          @if (Icon && !hideIcon) {
            <Icon />
          } @else {
            <div
              class="h-3 w-3 shrink-0 rounded-[2px] border-2 border-border"
              style={{
                backgroundColor: item.color,
              }}
            />
          }
          {itemConfig?.label}
        </div>
      }
    </div>
  )
}

// Helper to extract item config from a payload.
function getPayloadConfigFromPayload(
  config: ChartConfig,
  payload: unknown,
  key: string,
) {
  if (typeof payload !== "object" || payload === null) {
    return undefined
  }

  const payloadPayload =
    "payload" in payload &&
    typeof payload.payload === "object" &&
    payload.payload !== null
      ? payload.payload
      : undefined

  let configLabelKey: string = key

  if (
    key in payload &&
    typeof payload[key as keyof typeof payload] === "string"
  ) {
    configLabelKey = payload[key as keyof typeof payload] as string
  } else if (
    payloadPayload &&
    key in payloadPayload &&
    typeof payloadPayload[key as keyof typeof payloadPayload] === "string"
  ) {
    configLabelKey = payloadPayload[
      key as keyof typeof payloadPayload
    ] as string
  }

  return configLabelKey in config ? config[configLabelKey] : config[key]
}

export {
  ChartContainer,
  ChartTooltip,
  ChartTooltipContent,
  ChartLegend,
  ChartLegendContent,
  ChartStyle,
}
