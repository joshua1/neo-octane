import type { ClassValue } from "clsx"
import { Collapsible as CollapsiblePrimitive } from "@octanejs/base-ui/collapsible"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function Collapsible({
  class: klass,
  className,
  ...props
}: StyledProps<CollapsiblePrimitive.Root.Props>) @{
  <CollapsiblePrimitive.Root
    data-slot="collapsible"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function CollapsibleTrigger({
  class: klass,
  className,
  ...props
}: StyledProps<CollapsiblePrimitive.Trigger.Props>) @{
  <CollapsiblePrimitive.Trigger
    data-slot="collapsible-trigger"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function CollapsibleContent({
  class: klass,
  className,
  ...props
}: StyledProps<CollapsiblePrimitive.Panel.Props>) @{
  <CollapsiblePrimitive.Panel
    data-slot="collapsible-content"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

export { Collapsible, CollapsibleTrigger, CollapsibleContent }
