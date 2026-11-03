import type { ClassValue } from "clsx"
import { CheckIcon } from "@octanejs/lucide"
import type { ComponentProps, OctaneNode } from "octane"
import type { VariantProps } from "class-variance-authority"

import { Questionnaire as QuestionnairePrimitive } from "@/components/primitives/questionnaire/index.ts"
import { buttonVariants } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type StyledProps<P> = Omit<P, "className"> & ClassProps

type ButtonVariantProps = Pick<
  VariantProps<typeof buttonVariants>,
  "size" | "variant"
>

function Questionnaire({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Root>>) @{
  <QuestionnairePrimitive.Root
    data-slot="questionnaire"
    className={cn("flex w-full min-w-0 flex-col gap-6", className, klass)}
    {...props}
  />
}

function QuestionnaireProgress({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Progress>>) @{
  <QuestionnairePrimitive.Progress
    data-slot="questionnaire-progress"
    className={cn(
      "min-h-[1lh] w-fit min-w-[14ch] text-xs font-base text-foreground tabular-nums",
      className,
      klass,
    )}
    {...props}
  />
}

function QuestionnaireItem({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Item>>) @{
  <QuestionnairePrimitive.Item
    data-slot="questionnaire-item"
    className={cn(
      "flex min-w-0 flex-col gap-5 border-0 p-0 outline-none",
      className,
      klass,
    )}
    {...props}
  />
}

function QuestionnaireTitle({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Title>>) @{
  <QuestionnairePrimitive.Title
    data-slot="questionnaire-title"
    className={cn(
      "text-base leading-snug font-heading text-foreground text-pretty [&:not(:has(~[data-slot=questionnaire-description]))]:mb-4",
      className,
      klass,
    )}
    {...props}
  />
}

function QuestionnaireDescription({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Description>>) @{
  <QuestionnairePrimitive.Description
    data-slot="questionnaire-description"
    className={cn(
      "text-sm font-base text-pretty text-foreground",
      className,
      klass,
    )}
    {...props}
  />
}

function QuestionnaireChoices({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Choices>>) @{
  <QuestionnairePrimitive.Choices
    data-slot="questionnaire-choices"
    className={cn(
      "group/questionnaire-choices grid min-w-0 gap-3",
      className,
      klass,
    )}
    {...props}
  />
}

function QuestionnaireChoice({
  children,
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Choice>>) @{
  <QuestionnairePrimitive.Choice
    data-slot="questionnaire-choice"
    className={cn(
      "group/questionnaire-choice relative flex min-h-11 cursor-pointer items-start gap-3 rounded-base border-2 border-border bg-secondary-background px-4 py-3 text-start text-sm font-base text-foreground transition-colors outline-none select-none has-[>input:focus-visible]:ring-2 has-[>input:focus-visible]:ring-black has-[>input:focus-visible]:ring-offset-2 data-checked:bg-background",
      "data-disabled:pointer-events-none data-disabled:cursor-not-allowed data-disabled:opacity-50",
      className,
      klass,
    )}
    {...props}
  >
    <QuestionnairePrimitive.ChoiceInput
      data-slot="questionnaire-choice-input"
      className="absolute inset-0 z-10 size-full cursor-pointer opacity-0"
    />
    <span
      aria-hidden="true"
      data-slot="questionnaire-choice-indicator"
      class="pointer-events-none relative flex size-4 shrink-0 translate-y-[--spacing(0.45)] items-center justify-center rounded-base border-2 border-border bg-secondary-background text-main-foreground group-has-data-[slot=questionnaire-choice-description]/questionnaire-choice:translate-y-0.5 group-data-[type=radio]/questionnaire-choice:rounded-full group-data-checked/questionnaire-choice:bg-main group-data-checked/questionnaire-choice:group-data-[type=radio]/questionnaire-choice:bg-transparent"
    >
      <span
        data-slot="questionnaire-choice-indicator-dot"
        class="hidden size-2 rounded-full bg-current group-data-[type=checkbox]/questionnaire-choice:hidden group-data-checked/questionnaire-choice:block"
      />
      <CheckIcon
        data-slot="questionnaire-choice-indicator-check"
        class="hidden size-3.5 group-data-[type=radio]/questionnaire-choice:hidden group-data-checked/questionnaire-choice:block"
      />
    </span>
    <QuestionnairePrimitive.ChoiceLabel
      data-slot="questionnaire-choice-label"
      className="flex min-w-0 flex-1 flex-col gap-0.5 leading-snug"
    >
      {children}
    </QuestionnairePrimitive.ChoiceLabel>
    <QuestionnairePrimitive.ChoiceShortcut
      data-slot="questionnaire-choice-shortcut"
      className="pointer-events-none ms-auto hidden size-5 shrink-0 items-center justify-center rounded-full border-2 border-border bg-secondary-background text-xs leading-none font-base text-foreground group-data-checked/questionnaire-choice:bg-background group-data-[shortcut]/questionnaire-choice:inline-flex"
    />
  </QuestionnairePrimitive.Choice>
}

function QuestionnaireChoiceDescription({
  class: klass,
  className,
  ...props
}: Record<string, any> & ClassProps & { children?: OctaneNode }) @{
  <span
    data-slot="questionnaire-choice-description"
    class={cn("text-foreground", className, klass)}
    {...props}
  />
}

function QuestionnaireInput({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Input>>) @{
  <div
    data-slot="questionnaire-input-wrapper"
    class="group/questionnaire-input relative w-full min-w-0"
  >
    <QuestionnairePrimitive.Input
      data-slot="questionnaire-input"
      className={cn(
        "flex h-10 min-h-10 w-full min-w-0 rounded-base border-2 border-border bg-secondary-background px-3 py-2 text-base font-base text-foreground focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black focus-visible:ring-offset-2 disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 sm:min-h-0 md:text-sm",
        "selection:bg-main selection:text-main-foreground placeholder:text-foreground/50",
        className,
        klass,
      )}
      {...props}
    />
  </div>
}

function QuestionnaireError({
  class: klass,
  className,
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Error>>) @{
  <QuestionnairePrimitive.Error
    data-slot="questionnaire-error"
    className={cn("mt-2 text-sm font-base text-red-500", className, klass)}
    {...props}
  />
}

function QuestionnaireActions({
  class: klass,
  className,
  ...props
}: Record<string, any> & ClassProps & { children?: OctaneNode }) @{
  <div
    data-slot="questionnaire-actions"
    class={cn(
      "grid min-h-11 w-full grid-cols-[minmax(0,1fr)_auto_auto] items-center gap-2 sm:min-h-8",
      className,
      klass,
    )}
    {...props}
  />
}

function QuestionnairePrevious({
  children,
  class: klass,
  className,
  size = "sm",
  variant = "neutral",
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Previous>> &
  ButtonVariantProps) @{
  <QuestionnairePrimitive.Previous
    data-slot="questionnaire-previous"
    data-size={size}
    data-variant={variant}
    className={cn(
      buttonVariants({ size, variant }),
      "col-start-1 row-start-1 min-h-11 justify-self-start sm:min-h-0",
      className,
      klass,
    )}
    {...props}
  >
    {children ?? "Previous"}
  </QuestionnairePrimitive.Previous>
}

function QuestionnaireSkip({
  children,
  class: klass,
  className,
  size = "sm",
  variant = "neutral",
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Skip>> &
  ButtonVariantProps) @{
  <QuestionnairePrimitive.Skip
    data-slot="questionnaire-skip"
    data-size={size}
    data-variant={variant}
    className={cn(
      buttonVariants({ size, variant }),
      "col-start-2 row-start-1 min-h-11 justify-self-end sm:min-h-0",
      className,
      klass,
    )}
    {...props}
  >
    {children ?? "Skip"}
  </QuestionnairePrimitive.Skip>
}

function QuestionnaireNext({
  children,
  class: klass,
  className,
  size = "sm",
  variant = "default",
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Next>> &
  ButtonVariantProps) @{
  <QuestionnairePrimitive.Next
    data-slot="questionnaire-next"
    data-size={size}
    data-variant={variant}
    className={cn(
      buttonVariants({ size, variant }),
      "col-start-3 row-start-1 min-h-11 justify-self-end sm:min-h-0",
      className,
      klass,
    )}
    {...props}
  >
    {children ?? "Next"}
  </QuestionnairePrimitive.Next>
}

function QuestionnaireSubmit({
  children,
  class: klass,
  className,
  size = "sm",
  variant = "default",
  ...props
}: StyledProps<ComponentProps<typeof QuestionnairePrimitive.Submit>> &
  ButtonVariantProps) @{
  <QuestionnairePrimitive.Submit
    data-slot="questionnaire-submit"
    data-size={size}
    data-variant={variant}
    className={cn(
      buttonVariants({ size, variant }),
      "col-start-3 row-start-1 min-h-11 justify-self-end sm:min-h-0",
      className,
      klass,
    )}
    {...props}
  >
    {children ?? "Submit"}
  </QuestionnairePrimitive.Submit>
}

export {
  Questionnaire,
  QuestionnaireActions,
  QuestionnaireChoice,
  QuestionnaireChoiceDescription,
  QuestionnaireChoices,
  QuestionnaireDescription,
  QuestionnaireError,
  QuestionnaireInput,
  QuestionnaireItem,
  QuestionnaireNext,
  QuestionnairePrevious,
  QuestionnaireProgress,
  QuestionnaireSkip,
  QuestionnaireSubmit,
  QuestionnaireTitle,
}
