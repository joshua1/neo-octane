import type { OctaneNode } from "octane"

import components from "@/data/components"
import { STARS_EXAMPLES } from "@/data/stars"

import { cn, transformToSlug } from "@/lib/utils"

// The same components sharedComponents maps Tabs* to; imported directly to
// avoid a circular import with mdx-components.
import {
  DocsTabs as Tabs,
  DocsTabsContent as TabsContent,
  DocsTabsList as TabsList,
  DocsTabsTrigger as TabsTrigger,
} from "./docs-tabs.tsrx"

type ExampleComponentType = (props: Record<string, any>) => OctaneNode

function resolveExample(
  component: string,
  example: string | undefined,
  type: "star" | "component",
): ExampleComponentType | undefined {
  if (type === "star") {
    return STARS_EXAMPLES[component as keyof typeof STARS_EXAMPLES] as
      ExampleComponentType | undefined
  }

  const componentData = components.find(
    (c) => transformToSlug(c.name) === component,
  )
  if (!componentData) return undefined

  return (
    example ? componentData.examples?.[example] : componentData.exampleComponent
  ) as ExampleComponentType | undefined
}

export default function ComponentPreview({
  component,
  children,
  example,
  type = "component",
  wrapperClassName,
}: {
  component: string
  children?: OctaneNode
  example?: string
  type?: "star" | "component"
  wrapperClassName?: string
}) @{
  const ExampleComponent = resolveExample(component, example, type)

  if (!ExampleComponent) return null

  <>
    <Tabs defaultValue="preview" class="w-full">
      <TabsList class="grid w-full border-b-0 grid-cols-2">
        <TabsTrigger value="preview">Preview</TabsTrigger>
        <TabsTrigger value="code">Code</TabsTrigger>
      </TabsList>
      <TabsContent value="preview">
        <div
          class={cn(
            "not-prose flex w-full items-center justify-center z-15 relative border-2 mb-5 min-h-[200px] border-border bg-[15px_20px] bg-[linear-gradient(to_right,#8080804D_1px,transparent_1px),linear-gradient(to_bottom,#80808090_1px,transparent_1px)] sm:px-10 px-5 sm:py-20 py-10 shadow-shadow [background-size:40px_40px]",
            wrapperClassName,
            "bg-secondary-background",
          )}
        >
          <ExampleComponent />
        </div>
      </TabsContent>
      <TabsContent value="code">{children}</TabsContent>
    </Tabs>
  </>
}
