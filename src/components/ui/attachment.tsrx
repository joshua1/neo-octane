import type { ClassValue } from "clsx"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { cva, type VariantProps } from "class-variance-authority"

import type { OctaneNode } from "octane"

import { Button } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type DivProps = Record<string, any> & ClassProps & { children?: OctaneNode }
type SpanProps = Record<string, any> & ClassProps & { children?: OctaneNode }

const attachmentVariants = cva(
  "group/attachment relative flex w-fit max-w-full min-w-0 shrink-0 flex-wrap rounded-base border-2 border-border bg-background text-foreground font-base transition-colors focus-within:ring-2 focus-within:ring-black focus-within:ring-offset-2 has-[>a,>button]:hover:bg-secondary-background data-[state=error]:bg-black data-[state=error]:text-white data-[state=idle]:border-dashed",
  {
    variants: {
      size: {
        default:
          "gap-2 text-sm has-data-[slot=attachment-content]:px-2.5 has-data-[slot=attachment-content]:py-2 has-data-[slot=attachment-media]:p-2",
        sm: "gap-2.5 text-xs has-data-[slot=attachment-content]:px-2 has-data-[slot=attachment-content]:py-1.5 has-data-[slot=attachment-media]:p-1.5",
        xs: "gap-1.5 text-xs has-data-[slot=attachment-content]:px-1.5 has-data-[slot=attachment-content]:py-1 has-data-[slot=attachment-media]:p-1",
      },
      orientation: {
        horizontal: "min-w-40 items-center",
        vertical: "w-24 flex-col has-data-[slot=attachment-content]:w-30",
      },
    },
  },
)

function Attachment({
  class: klass,
  className,
  state = "done",
  size = "default",
  orientation = "horizontal",
  ...props
}: DivProps &
  VariantProps<typeof attachmentVariants> & {
    state?: "idle" | "uploading" | "processing" | "error" | "done"
  }) @{
  <div
    data-slot="attachment"
    data-state={state}
    data-size={size}
    data-orientation={orientation}
    class={cn(attachmentVariants({ size, orientation }), className, klass)}
    {...props}
  />
}

const attachmentMediaVariants = cva(
  "relative flex aspect-square w-10 shrink-0 items-center justify-center overflow-hidden rounded-base border-2 border-border bg-secondary-background text-foreground group-data-[orientation=vertical]/attachment:w-full group-data-[size=sm]/attachment:w-8 group-data-[size=xs]/attachment:w-7 group-data-[state=error]/attachment:text-black group-data-[orientation=vertical]/attachment:*:data-[slot=spinner]:size-6! [&_svg]:pointer-events-none [&_svg:not([class*='size-'])]:size-4 group-data-[orientation=vertical]/attachment:[&_svg:not([class*='size-'])]:size-6 group-data-[size=xs]/attachment:[&_svg:not([class*='size-'])]:size-3.5",
  {
    variants: {
      variant: {
        icon: "",
        image:
          "opacity-60 group-data-[state=done]/attachment:opacity-100 group-data-[state=idle]/attachment:opacity-100 *:[img]:aspect-square *:[img]:w-full *:[img]:object-cover",
      },
    },
    defaultVariants: {
      variant: "icon",
    },
  },
)

function AttachmentMedia({
  class: klass,
  className,
  variant = "icon",
  ...props
}: DivProps & VariantProps<typeof attachmentMediaVariants>) @{
  <div
    data-slot="attachment-media"
    data-variant={variant}
    class={cn(attachmentMediaVariants({ variant }), className, klass)}
    {...props}
  />
}

function AttachmentContent({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="attachment-content"
    class={cn(
      "max-w-full min-w-0 flex-1 leading-tight group-data-[orientation=vertical]/attachment:px-1",
      className,
      klass,
    )}
    {...props}
  />
}

function AttachmentTitle({ class: klass, className, ...props }: SpanProps) @{
  <span
    data-slot="attachment-title"
    class={cn(
      "block max-w-full min-w-0 truncate font-heading group-data-[state=processing]/attachment:animate-pulse group-data-[state=uploading]/attachment:animate-pulse",
      className,
      klass,
    )}
    {...props}
  />
}

function AttachmentDescription({
  class: klass,
  className,
  ...props
}: SpanProps) @{
  <span
    data-slot="attachment-description"
    class={cn(
      "mt-0.5 block min-w-0 truncate text-xs text-foreground group-data-[state=error]/attachment:text-white",
      "max-w-full",
      className,
      klass,
    )}
    {...props}
  />
}

function AttachmentActions({ class: klass, className, ...props }: DivProps) @{
  <div
    data-slot="attachment-actions"
    class={cn(
      "relative z-20 flex shrink-0 items-center group-data-[orientation=vertical]/attachment:absolute group-data-[orientation=vertical]/attachment:top-3 group-data-[orientation=vertical]/attachment:right-3 group-data-[orientation=vertical]/attachment:gap-1",
      className,
      klass,
    )}
    {...props}
  />
}

function AttachmentAction({
  class: klass,
  className,
  variant,
  size = "icon",
  ...props
}: Parameters<typeof Button>[0]) @{
  <Button
    data-slot="attachment-action"
    variant={variant ?? "neutral"}
    size={size}
    class={cn(
      "size-6 border-0 bg-transparent text-inherit shadow-none! hover:translate-x-0! hover:translate-y-0!",
      className,
      klass,
    )}
    {...props}
  />
}

function AttachmentTrigger({
  class: klass,
  className,
  render,
  type,
  ...props
}: useRender.ComponentProps<"button"> & ClassProps) {
  // Casts: @octanejs/base-ui types mergeProps() as PropsOf<T> (no index signature) and
  // useRender.ComponentProps["render"] with HTMLProps, neither of which matches useRender's params.
  return useRender({
    defaultTagName: "button",
    props: mergeProps<"button">(
      {
        type: render ? type : (type ?? "button"),
        className: cn("absolute inset-0 z-10 outline-none", className, klass),
      },
      props,
    ) as Record<string, unknown>,
    render: render as useRender.RenderProp<any>,
    state: {
      slot: "attachment-trigger",
    },
  })
}

export {
  Attachment,
  AttachmentMedia,
  AttachmentContent,
  AttachmentTitle,
  AttachmentDescription,
  AttachmentActions,
  AttachmentAction,
  AttachmentTrigger,
}
