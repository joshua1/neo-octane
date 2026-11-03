/**
 * Octane questionnaire primitive — public entry.
 * Derived from shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c (questionnaire).
 * License: MIT, (c) 2023 shadcn — see ../LICENSE.upstream.md.
 */
import {
  QuestionnaireChoice as Choice,
  QuestionnaireChoiceInput as ChoiceInput,
  QuestionnaireChoiceLabel as ChoiceLabel,
  QuestionnaireChoices as Choices,
  QuestionnaireChoiceShortcut as ChoiceShortcut,
  QuestionnaireDescription as Description,
  QuestionnaireError as Error,
  QuestionnaireInput as Input,
  QuestionnaireItem as Item,
  QuestionnaireNext as Next,
  QuestionnairePrevious as Previous,
  QuestionnaireProgress as Progress,
  QuestionnaireRoot as Root,
  QuestionnaireSkip as Skip,
  QuestionnaireSubmit as Submit,
  QuestionnaireTitle as Title,
} from "./components.tsrx"

export const Questionnaire = {
  Root,
  Progress,
  Item,
  Title,
  Description,
  Choices,
  Choice,
  ChoiceInput,
  ChoiceLabel,
  ChoiceShortcut,
  Input,
  Error,
  Previous,
  Skip,
  Next,
  Submit,
}

export type {
  QuestionnaireChoiceDefinition,
  QuestionnaireInputType,
  QuestionnaireItemDefinition,
  QuestionnaireItemStatus,
  QuestionnaireShortcutMode,
} from "./types"
