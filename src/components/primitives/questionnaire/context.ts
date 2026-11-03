/**
 * Octane questionnaire primitive (context).
 * Derived from shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c (questionnaire).
 * License: MIT, (c) 2023 shadcn — see ../LICENSE.upstream.md.
 * Notes: Contexts are rendered as `<Context value>` (no `.Provider`).
 */
import * as Octane from "octane"

import type {
  QuestionnaireChoiceContextValue,
  QuestionnaireContextValue,
  QuestionnaireItemContextValue,
} from "./types"

const QuestionnaireChoiceContext =
  Octane.createContext<QuestionnaireChoiceContextValue | null>(null)
const QuestionnaireContext =
  Octane.createContext<QuestionnaireContextValue | null>(null)
const QuestionnaireItemContext =
  Octane.createContext<QuestionnaireItemContextValue | null>(null)

function useQuestionnaireContext(component: string) {
  const context = Octane.useContext(QuestionnaireContext)

  if (!context) {
    throw new Error(
      `${component} must be used within a Questionnaire.Root component.`,
    )
  }

  return context
}

function useQuestionnaireChoiceContext(component: string) {
  const context = Octane.useContext(QuestionnaireChoiceContext)

  if (!context) {
    throw new Error(
      `${component} must be used within a Questionnaire.Choice component.`,
    )
  }

  return context
}

function useQuestionnaireItemContext(component: string) {
  const context = Octane.useContext(QuestionnaireItemContext)

  if (!context) {
    throw new Error(
      `${component} must be used within a Questionnaire.Item component.`,
    )
  }

  return context
}

export {
  QuestionnaireChoiceContext,
  QuestionnaireContext,
  QuestionnaireItemContext,
  useQuestionnaireChoiceContext,
  useQuestionnaireContext,
  useQuestionnaireItemContext,
}
