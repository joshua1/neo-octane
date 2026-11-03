import type { ClassValue } from "clsx"
import { Accordion as AccordionPrimitive } from "@octanejs/base-ui/accordion"
import { ChevronDown } from "@octanejs/lucide"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

function Accordion({
  class: klass,
  className,
  ...props
}: StyledProps<AccordionPrimitive.Root.Props>) @{
  <AccordionPrimitive.Root
    data-slot="accordion"
    className={cn(className, klass) || undefined}
    {...props}
  />
}

function AccordionItem({
  class: klass,
  className,
  ...props
}: StyledProps<AccordionPrimitive.Item.Props>) @{
  <AccordionPrimitive.Item
    data-slot="accordion-item"
    className={cn(
      "rounded-base overflow-hidden border-2 border-b border-border shadow-shadow",
      className,
      klass,
    )}
    {...props}
  />
}

function AccordionTrigger({
  class: klass,
  className,
  children,
  ...props
}: StyledProps<AccordionPrimitive.Trigger.Props>) @{
  <AccordionPrimitive.Header className="flex">
    <AccordionPrimitive.Trigger
      data-slot="accordion-trigger"
      className={cn(
        "flex flex-1 items-center justify-between text-left text-base text-main-foreground border-border focus-visible:ring-[3px] bg-main p-4 font-heading transition-all [&[data-panel-open]>svg]:rotate-180 data-panel-open:rounded-b-none data-panel-open:border-b-2 disabled:pointer-events-none disabled:opacity-50 data-disabled:pointer-events-none data-disabled:opacity-50",
        className,
        klass,
      )}
      {...props}
    >
      {children}
      <ChevronDown class="pointer-events-none size-5 shrink-0 transition-transform duration-200" />
    </AccordionPrimitive.Trigger>
  </AccordionPrimitive.Header>
}

function AccordionContent({
  class: klass,
  className,
  children,
  ...props
}: StyledProps<AccordionPrimitive.Panel.Props>) @{
  <AccordionPrimitive.Panel
    data-slot="accordion-content"
    className="h-(--accordion-panel-height) overflow-hidden rounded-b-base bg-secondary-background text-sm font-base transition-[height] duration-200 ease-out data-starting-style:h-0 data-ending-style:h-0"
    {...props}
  >
    <div class={cn("p-4", className, klass)}>{children}</div>
  </AccordionPrimitive.Panel>
}

export { Accordion, AccordionItem, AccordionTrigger, AccordionContent }
