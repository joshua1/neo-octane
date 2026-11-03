import type { ClassValue } from "clsx"
import { cva, type VariantProps } from "class-variance-authority"
import type { OctaneNode } from "octane"

import { Label } from "@/components/ui/label.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type ElementProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function FieldSet({ class: klass, className, ...props }: ElementProps) @{
  <fieldset
    data-slot="field-set"
    class={cn(
      "flex flex-col gap-4 has-[>[data-slot=checkbox-group]]:gap-3 has-[>[data-slot=radio-group]]:gap-3",
      className,
      klass,
    )}
    {...props}
  />
}

function FieldLegend({
  class: klass,
  className,
  variant = "legend",
  ...props
}: ElementProps & { variant?: "legend" | "label" }) @{
  <legend
    data-slot="field-legend"
    data-variant={variant}
    class={cn(
      "mb-1.5 font-heading data-[variant=label]:text-sm data-[variant=legend]:text-base",
      className,
      klass,
    )}
    {...props}
  />
}

function FieldGroup({ class: klass, className, ...props }: ElementProps) @{
  <div
    data-slot="field-group"
    class={cn(
      "group/field-group @container/field-group flex w-full flex-col gap-5 data-[slot=checkbox-group]:gap-3 *:data-[slot=field-group]:gap-4",
      className,
      klass,
    )}
    {...props}
  />
}

const fieldVariants = cva(
  "group/field flex w-full gap-2 font-base data-[invalid=true]:text-red-500",
  {
    variants: {
      orientation: {
        vertical: "flex-col *:w-full [&>.sr-only]:w-auto",
        horizontal:
          "flex-row items-center has-[>[data-slot=field-content]]:items-start *:data-[slot=field-label]:flex-auto has-[>[data-slot=field-content]]:[&>[role=checkbox],[role=radio]]:mt-px",
        responsive:
          "flex-col *:w-full @md/field-group:flex-row @md/field-group:items-center @md/field-group:*:w-auto @md/field-group:has-[>[data-slot=field-content]]:items-start @md/field-group:*:data-[slot=field-label]:flex-auto [&>.sr-only]:w-auto @md/field-group:has-[>[data-slot=field-content]]:[&>[role=checkbox],[role=radio]]:mt-px",
      },
    },
    defaultVariants: {
      orientation: "vertical",
    },
  },
)

function Field({
  class: klass,
  className,
  orientation = "vertical",
  ...props
}: ElementProps & VariantProps<typeof fieldVariants>) @{
  <div
    role="group"
    data-slot="field"
    data-orientation={orientation}
    class={cn(fieldVariants({ orientation }), className, klass)}
    {...props}
  />
}

function FieldContent({ class: klass, className, ...props }: ElementProps) @{
  <div
    data-slot="field-content"
    class={cn(
      "group/field-content flex flex-1 flex-col gap-0.5 leading-snug",
      className,
      klass,
    )}
    {...props}
  />
}

function FieldLabel({ class: klass, className, ...props }: ElementProps) @{
  <Label
    data-slot="field-label"
    class={cn(
      "group/field-label peer/field-label flex w-fit gap-2 leading-snug group-data-[disabled=true]/field:opacity-50 has-[>[data-slot=field]]:rounded-base has-[>[data-slot=field]]:border-2 has-[>[data-slot=field]]:border-border has-[>[data-slot=field]]:bg-secondary-background has-[>[data-slot=field]]:has-data-checked:bg-main has-[>[data-slot=field]]:has-data-checked:text-main-foreground has-[>[data-slot=field]]:has-[:focus-visible]:ring-2 has-[>[data-slot=field]]:has-[:focus-visible]:ring-black has-[>[data-slot=field]]:has-[:focus-visible]:ring-offset-2 *:data-[slot=field]:p-2.5",
      "has-[>[data-slot=field]]:w-full has-[>[data-slot=field]]:flex-col",
      className,
      klass,
    )}
    {...props}
  />
}

function FieldTitle({ class: klass, className, ...props }: ElementProps) @{
  <div
    data-slot="field-label"
    class={cn(
      "flex w-fit items-center gap-2 text-sm font-heading group-data-[disabled=true]/field:opacity-50",
      className,
      klass,
    )}
    {...props}
  />
}

function FieldDescription({
  class: klass,
  className,
  ...props
}: ElementProps) @{
  <p
    data-slot="field-description"
    class={cn(
      "text-left text-sm leading-normal font-base text-foreground group-has-data-horizontal/field:text-balance [[data-variant=legend]+&]:-mt-1.5",
      "last:mt-0 nth-last-2:-mt-1",
      "[&>a]:underline [&>a]:underline-offset-4 [&>a:hover]:text-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

function FieldSeparator({
  class: klass,
  className,
  children,
  ...props
}: ElementProps) @{
  <div
    data-slot="field-separator"
    data-content={!!children}
    class={cn(
      "relative -my-2 h-5 text-sm group-data-[variant=outline]/field-group:-mb-2",
      className,
      klass,
    )}
    {...props}
  >
    <div
      role="separator"
      aria-orientation="horizontal"
      class="absolute inset-x-0 top-1/2 border-t-2 border-border"
    />
    @if (children) {
      <span
        class="relative mx-auto block w-fit bg-background px-2 font-base text-foreground"
        data-slot="field-separator-content"
      >
        {children}
      </span>
    }
  </div>
}

function FieldError({
  class: klass,
  className,
  children,
  errors,
  ...props
}: ElementProps & {
  errors?: Array<{ message?: string } | undefined>
}) @{
  // Content resolution: explicit children win,
  // then a single (de-duplicated) error message as text, then a list.
  const uniqueErrors = errors?.length
    ? Array.from(
        new Map(errors.map((error) => [error?.message, error])).values(),
      )
    : []
  const singleMessage =
    uniqueErrors.length == 1 ? uniqueErrors[0]?.message : undefined

  if (
    !children &&
    (uniqueErrors.length === 0 || (uniqueErrors.length == 1 && !singleMessage))
  ) {
    return null
  }

  <div
    role="alert"
    data-slot="field-error"
    class={cn("text-sm font-base text-red-500", className, klass)}
    {...props}
  >
    @if (children) {
      <>{children}</>
    } @else {
      @if (uniqueErrors.length == 1) {
        <>{singleMessage as string}</>
      } @else {
        <ul class="ml-4 flex list-disc flex-col gap-1">
          @for (const error of uniqueErrors; index i; key i) {
            @if (error?.message) {
              <li>{error.message as string}</li>
            }
          }
        </ul>
      }
    }
  </div>
}

export {
  Field,
  FieldLabel,
  FieldDescription,
  FieldError,
  FieldGroup,
  FieldLegend,
  FieldSeparator,
  FieldSet,
  FieldContent,
  FieldTitle,
}
