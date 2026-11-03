import type { ClassValue } from "clsx"
import {
  createContext,
  descriptorChildren,
  isValidElement,
  useContext,
  useId,
  type OctaneNode,
} from "octane"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import {
  Controller,
  FormProvider,
  useFormContext,
  useFormState,
  type ControllerProps,
  type FieldPath,
  type FieldValues,
} from "@octanejs/hook-form"

import { Label } from "@/components/ui/label.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

const Form = FormProvider

type FormFieldContextValue<
  TFieldValues extends FieldValues = FieldValues,
  TName extends FieldPath<TFieldValues> = FieldPath<TFieldValues>,
> = {
  name: TName
}

const FormFieldContext = createContext<FormFieldContextValue>(
  {} as FormFieldContextValue,
)

function FormField<
  TFieldValues extends FieldValues = FieldValues,
  TName extends FieldPath<TFieldValues> = FieldPath<TFieldValues>,
>({ ...props }: ControllerProps<TFieldValues, TName>) @{
  <FormFieldContext value={{ name: props.name }}>
    <Controller {...props} />
  </FormFieldContext>
}

const useFormField = () => {
  const fieldContext = useContext(FormFieldContext)
  const itemContext = useContext(FormItemContext)
  const { getFieldState } = useFormContext()
  const formState = useFormState({ name: fieldContext.name })
  const fieldState = getFieldState(fieldContext.name, formState)

  if (!fieldContext) {
    throw new Error("useFormField should be used within <FormField>")
  }

  const { id } = itemContext

  return {
    id,
    name: fieldContext.name,
    formItemId: `${id}-form-item`,
    formDescriptionId: `${id}-form-item-description`,
    formMessageId: `${id}-form-item-message`,
    ...fieldState,
  }
}

type FormItemContextValue = {
  id: string
}

const FormItemContext = createContext<FormItemContextValue>(
  {} as FormItemContextValue,
)

type ElementProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

function FormItem({ class: klass, className, ...props }: ElementProps) @{
  const id = useId()

  <FormItemContext value={{ id }}>
    <div
      data-slot="form-item"
      class={cn("grid gap-2", className, klass)}
      {...props}
    />
  </FormItemContext>
}

function FormLabel({ class: klass, className, ...props }: ElementProps) @{
  const { error, formItemId } = useFormField()

  <Label
    data-slot="form-label"
    data-error={!!error}
    class={cn("font-heading", className, klass)}
    for={formItemId}
    {...props}
  />
}

// Like Radix's `Slot`, the control merges its props into the single child
// element (or the element passed to `render`). Octane hands template children
// to a component as a compiled body unless it is marked `descriptorChildren`,
// so the marker is what keeps `isValidElement(children)` working here.
function FormControlImpl({
  class: klass,
  className,
  children,
  render,
  ...props
}: Omit<useRender.ComponentProps<"div">, "className"> & ClassProps) {
  const { error, formItemId, formDescriptionId, formMessageId } = useFormField()

  const renderElement =
    render ?? (isValidElement(children) ? children : undefined)

  return useRender({
    defaultTagName: "div",
    // Binding typing gap: `useRender.ComponentProps` types `render` against
    // `HTMLProps` while `useRender` expects `HTMLAttributes`.
    render: renderElement as useRender.RenderProp<{ slot: string }> | undefined,
    props: mergeProps<"div">(
      {
        id: formItemId,
        "aria-describedby": !error
          ? `${formDescriptionId}`
          : `${formDescriptionId} ${formMessageId}`,
        "aria-invalid": !!error,
        children: renderElement ? undefined : children,
        className: cn(className, klass) || undefined,
      },
      props,
      // The binding types `mergeProps` output as the precise host props while
      // `useRender` takes `Record<string, unknown>`; same object at runtime.
    ) as Record<string, unknown>,
    state: {
      slot: "form-control",
    },
  })
}

const FormControl = descriptorChildren(FormControlImpl)

function FormDescription({ class: klass, className, ...props }: ElementProps) @{
  const { formDescriptionId } = useFormField()

  <p
    data-slot="form-description"
    id={formDescriptionId}
    class={cn("text-sm font-base text-foreground", className, klass)}
    {...props}
  />
}

function FormMessage({ class: klass, className, ...props }: ElementProps) @{
  const { error, formMessageId } = useFormField()
  const body = error ? String(error?.message ?? "") : props.children

  if (!body) {
    return null
  }

  <p
    data-slot="form-message"
    id={formMessageId}
    class={cn("text-sm font-base text-red-500", className, klass)}
    {...props}
  >
    {body}
  </p>
}

export {
  useFormField,
  Form,
  FormItem,
  FormLabel,
  FormControl,
  FormDescription,
  FormMessage,
  FormField,
}
