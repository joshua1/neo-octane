import {
  Tabs,
  TabsContent,
  TabsList,
  TabsTrigger,
} from "@/components/ui/tabs.tsrx"

import { cn } from "@/lib/utils"

type TabsProps = Parameters<typeof Tabs>[0]
type TabsListProps = Parameters<typeof TabsList>[0]
type TabsTriggerProps = Parameters<typeof TabsTrigger>[0]
type TabsContentProps = Parameters<typeof TabsContent>[0]

/**
 * The square, full-width tabs used across the docs: previews, installation
 * blocks and package-manager commands. Kept separate from mdx-components so
 * pages outside the docs can use them without pulling in every example.
 */
export function DocsTabs({ class: klass, className, ...props }: TabsProps) @{
  <Tabs
    class={cn(
      "w-full shadow-shadow [p+&]:mt-5 [ul+&]:mt-5 [ol+&]:mt-5",
      className,
      klass,
    )}
    {...props}
  />
}

export function DocsTabsList({
  class: klass,
  className,
  ...props
}: TabsListProps) @{
  <TabsList
    class={cn(
      "w-full overflow-x-hidden rounded-none sm:h-12 h-10 p-0 bg-secondary-background",
      className,
      klass,
    )}
    {...props}
  />
}

export function DocsTabsTrigger({
  class: klass,
  className,
  ...props
}: TabsTriggerProps) @{
  <TabsTrigger
    class={cn(
      "h-full border-0 border-r-2 z-10 border-r-border rounded-none sm:text-base data-active:text-main-foreground text-foreground last:border-r-0",
      className,
      klass,
    )}
    {...props}
  />
}

export function DocsTabsContent({
  class: klass,
  className,
  ...props
}: TabsContentProps) @{
  <TabsContent class={cn("mt-0 rounded-none", className, klass)} {...props} />
}
