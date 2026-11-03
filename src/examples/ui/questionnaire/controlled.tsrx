import { useState, type FormEvent } from "octane"

import { Progress, ProgressLabel } from "@/components/ui/progress.tsrx"
import {
  Questionnaire,
  QuestionnaireActions,
  QuestionnaireChoice,
  QuestionnaireChoices,
  QuestionnaireError,
  QuestionnaireItem,
  QuestionnaireNext,
  QuestionnairePrevious,
  QuestionnaireSubmit,
  QuestionnaireTitle,
} from "@/components/ui/questionnaire.tsrx"

const items = [
  {
    name: "role",
    choices: [
      { value: "designer" },
      { value: "developer" },
      { value: "founder" },
    ],
    required: true,
  },
  {
    name: "team",
    choices: [{ value: "solo" }, { value: "small" }, { value: "large" }],
    required: true,
  },
  {
    name: "usage",
    choices: [{ value: "side" }, { value: "work" }, { value: "both" }],
    required: true,
  },
] as const

export default function QuestionnaireControlledDemo() @{
  const [item, setItem] = useState<string>(items[0].name)
  const [submitted, setSubmitted] = useState(false)

  const step = items.findIndex((entry) => entry.name === item) + 1

  function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    setSubmitted(true)
  }

  <div class="flex w-full max-w-md flex-col gap-6">
    <Progress value={(step / items.length) * 100}>
      <ProgressLabel>{"Step " + step + " of " + items.length}</ProgressLabel>
    </Progress>
    <Questionnaire
      items={items}
      item={item}
      onItemChange={setItem}
      onSubmit={handleSubmit}
    >
      <QuestionnaireItem name="role" required>
        <QuestionnaireTitle>What best describes you?</QuestionnaireTitle>
        <QuestionnaireChoices>
          <QuestionnaireChoice value="designer">Designer</QuestionnaireChoice>
          <QuestionnaireChoice value="developer">Developer</QuestionnaireChoice>
          <QuestionnaireChoice value="founder">Founder</QuestionnaireChoice>
        </QuestionnaireChoices>
        <QuestionnaireError />
      </QuestionnaireItem>
      <QuestionnaireItem name="team" required>
        <QuestionnaireTitle>How big is your team?</QuestionnaireTitle>
        <QuestionnaireChoices>
          <QuestionnaireChoice value="solo">Just me</QuestionnaireChoice>
          <QuestionnaireChoice value="small">
            2 to 10 people
          </QuestionnaireChoice>
          <QuestionnaireChoice value="large">
            More than 10 people
          </QuestionnaireChoice>
        </QuestionnaireChoices>
        <QuestionnaireError />
      </QuestionnaireItem>
      <QuestionnaireItem name="usage" required>
        <QuestionnaireTitle>Where will you use it?</QuestionnaireTitle>
        <QuestionnaireChoices>
          <QuestionnaireChoice value="side">Side projects</QuestionnaireChoice>
          <QuestionnaireChoice value="work">At work</QuestionnaireChoice>
          <QuestionnaireChoice value="both">Both</QuestionnaireChoice>
        </QuestionnaireChoices>
        <QuestionnaireError />
      </QuestionnaireItem>
      <QuestionnaireActions>
        <QuestionnairePrevious />
        <QuestionnaireNext />
        <QuestionnaireSubmit />
      </QuestionnaireActions>
    </Questionnaire>
    @if (submitted) {
      <p class="text-sm font-base text-foreground">
        All done, thanks for your answers!
      </p>
    }
  </div>
}
