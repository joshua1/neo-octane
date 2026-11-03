/**
 * Octane questionnaire primitive (use-questionnaire-input).
 * Derived from shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c (questionnaire).
 * License: MIT, (c) 2023 shadcn — see ../LICENSE.upstream.md.
 * Notes: per-keystroke answer updates run from the native `onInput` handler (consumer `onInput` runs first and may `preventDefault()` to skip the update). A consumer `onChange` passes through as the native commit `change` event.
 */
import * as Octane from "octane"

import { composeRefs } from "../use-render"
import { useQuestionnaireItemContext } from "./context"
import type { QuestionnaireInputProps, QuestionnaireInputState } from "./types"
import { getAnswerKeyShortcuts, hasInputValue } from "./utils"

type UseQuestionnaireInputParameters = Pick<
  QuestionnaireInputProps,
  "defaultValue" | "disabled" | "onInput" | "ref" | "type" | "value"
>

function useQuestionnaireInput({
  defaultValue,
  disabled: inputDisabled = false,
  onInput,
  ref,
  type = "text",
  value: controlledValue,
}: UseQuestionnaireInputParameters) {
  const {
    disabled: itemDisabled,
    invalid,
    name: itemName,
    registerAnswerControl,
    registerAnswerSelection,
    resetVersion,
    selectedAnswerIds,
    setAnswerDefault,
    setAnswerSelectionFromInteraction,
    syncControlledAnswerSelection,
  } = useQuestionnaireItemContext("Questionnaire.Input")
  const answerId = Octane.useId()
  const inputRef = Octane.useRef<HTMLInputElement | null>(null)
  const initialDefaultFilledRef = Octane.useRef(hasInputValue(defaultValue))
  const controlled = controlledValue !== undefined
  const defaultFilled = hasInputValue(defaultValue)
  const controlledFilled = hasInputValue(controlledValue)
  const [uncontrolledFilled, setUncontrolledFilled] =
    Octane.useState(defaultFilled)
  const disabled = itemDisabled || inputDisabled
  const filled = controlled ? controlledFilled : uncontrolledFilled
  const selected = selectedAnswerIds.includes(answerId)

  Octane.useLayoutEffect(
    () => registerAnswerSelection(answerId, initialDefaultFilledRef.current),
    [answerId, registerAnswerSelection],
  )
  Octane.useLayoutEffect(
    () => setAnswerDefault(answerId, defaultFilled),
    [defaultFilled, answerId, setAnswerDefault],
  )

  Octane.useLayoutEffect(() => {
    const input = inputRef.current

    if (!input) {
      return
    }

    return registerAnswerControl({
      disabled,
      element: input,
      id: answerId,
      type: "input",
    })
  }, [disabled, answerId, registerAnswerControl])

  Octane.useLayoutEffect(() => {
    if (controlled) {
      syncControlledAnswerSelection(answerId, controlledFilled)
      return
    }

    if (resetVersion > 0) {
      setUncontrolledFilled(defaultFilled)
    }
  }, [
    controlled,
    controlledFilled,
    controlledValue,
    defaultFilled,
    answerId,
    resetVersion,
    syncControlledAnswerSelection,
  ])

  Octane.useLayoutEffect(() => {
    const input = inputRef.current

    if (!input || !controlled) {
      return
    }

    input.defaultValue = String(controlledValue)
  }, [controlled, controlledValue])

  // Per-keystroke edits on a text input fire the native `input` event, so the
  // answer state tracks `onInput`.
  function handleInput(event: Octane.InputEvent<HTMLInputElement>) {
    onInput?.(event)

    if (event.defaultPrevented) {
      return
    }

    const nextFilled = event.currentTarget.value.trim().length > 0

    if (controlled) {
      return
    }

    setUncontrolledFilled(nextFilled)
    setAnswerSelectionFromInteraction(answerId, nextFilled)
  }

  const state: QuestionnaireInputState = {
    disabled,
    filled,
    invalid,
  }
  const setInputRef = Octane.useCallback(
    (element: HTMLInputElement | null) => {
      inputRef.current = element
      composeRefs(ref)?.(element)
    },
    [ref],
  )

  return {
    inputProps: {
      "aria-invalid": invalid || undefined,
      "aria-keyshortcuts": getAnswerKeyShortcuts(
        null,
        !disabled && filled && selected,
      ),
      defaultValue: controlled ? undefined : defaultValue,
      disabled,
      form: selected ? undefined : "",
      id: answerId,
      name: selected ? itemName : undefined,
      onInput: handleInput,
      ref: setInputRef,
      type,
      value: controlled ? controlledValue : undefined,
    },
    state,
  }
}

export { useQuestionnaireInput }
