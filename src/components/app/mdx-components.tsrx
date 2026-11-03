import { CircleAlert } from "@octanejs/lucide"
import { Link } from "@octanejs/tanstack-router"
import type { OctaneNode } from "octane"

import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert.tsrx"
import {
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow,
} from "@/components/ui/table.tsrx"

import { cn } from "@/lib/utils"

import ComponentPreview from "./component-preview.tsrx"
import {
  DocsTabs,
  DocsTabsContent,
  DocsTabsList,
  DocsTabsTrigger,
} from "./docs-tabs.tsrx"
import { Pre } from "./pre.tsrx"
import ShadcnCliCommand from "./shadcn-cli-command.tsrx"

type HostProps = Record<string, any> & {
  class?: string
  className?: string
  children?: OctaneNode
}

function Warning({
  description,
  class: klass,
  className,
  ...props
}: HostProps & { description: string }) @{
  <Alert
    class={cn(
      "not-prose bg-secondary-background sm:has-[>svg]:gap-x-4 has-[>svg]:gap-x-3 sm:gap-y-2.5 gap-y-1.5 sm:[&>svg]:size-5 [&>svg]:size-4",
      className,
      klass,
    )}
    {...props}
  >
    <CircleAlert />
    <AlertTitle class="sm:text-lg sm:leading-5">Warning</AlertTitle>
    <AlertDescription class="sm:text-base">{description}</AlertDescription>
  </Alert>
}

/**
 * `<Link href>` inside the docs. next/link took any href; the router Link
 * takes a path plus a separate hash, and external or hash-only links stay
 * plain anchors.
 */
function MdxLink({ href, ...props }: HostProps & { href: string }) @{
  const hashIndex = href.indexOf("#")
  const path = hashIndex === -1 ? href : href.slice(0, hashIndex)
  const hash = hashIndex === -1 ? undefined : href.slice(hashIndex + 1)
  const isInternal = path.startsWith("/") && !path.startsWith("//")

  @if (isInternal) {
    <Link to={path} hash={hash} {...props} />
  } @else {
    <a href={href} {...props} />
  }
}

function Installation({
  children,
  component,
}: {
  children?: OctaneNode
  component: string
}) @{
  <DocsTabs defaultValue="cli" class="w-full">
    <DocsTabsList class="grid w-full grid-cols-2 border-b-0">
      <DocsTabsTrigger value="cli">Shadcn CLI</DocsTabsTrigger>
      <DocsTabsTrigger value="manual">Manual</DocsTabsTrigger>
    </DocsTabsList>
    <DocsTabsContent value="cli">
      <ShadcnCliCommand component={component} />
    </DocsTabsContent>
    <DocsTabsContent value="manual">{children}</DocsTabsContent>
  </DocsTabs>
}

function DocsTableRow({ class: klass, className, ...props }: HostProps) @{
  <TableRow
    class={cn("bg-secondary-background", className, klass)}
    {...props}
  />
}

/**
 * Components available to every docs .mdx document. velite compiled the
 * documents to function bodies run through `new Function`; @octanejs/mdx
 * compiles them to octane component modules, so the map is passed straight
 * to the document: `<Doc components={sharedComponents} />`.
 */
export const sharedComponents = {
  Tabs: DocsTabs,
  TabsList: DocsTabsList,
  TabsTrigger: DocsTabsTrigger,
  TabsContent: DocsTabsContent,
  Warning,
  Link: MdxLink,
  pre: Pre,
  ShadcnCliCommand,
  ComponentPreview,
  Installation,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableHeader,
  TableRow: DocsTableRow,
}
