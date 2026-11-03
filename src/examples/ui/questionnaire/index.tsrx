import { useState, type FormEvent } from "octane"

import {
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
} from "@/components/ui/questionnaire.tsrx"

const items = [
  {
    name: "framework",
    choices: [{ value: "next" }, { value: "vite" }, { value: "astro" }],
    required: true,
  },
  {
    name: "features",
    choices: [{ value: "docs" }, { value: "registry" }, { value: "themes" }],
  },
  {
    name: "feedback",
  },
] as const

export default function QuestionnaireDemo() @{
  const [answers, setAnswers] = useState<Record<
    string,
    string | string[]
  > | null>(null)

  function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    const formData = new FormData(event.currentTarget)
    setAnswers({
      framework: String(formData.get("framework") ?? ""),
      features: formData.getAll("features").map(String),
      feedback: String(formData.get("feedback") ?? ""),
    })
  }

  <div class="flex w-full max-w-md flex-col gap-4">
    <div class="w-full">
      <Questionnaire items={items} shortcuts="letters" onSubmit={handleSubmit}>
        <QuestionnaireProgress />
        <QuestionnaireItem name="framework" required>
          <QuestionnaireTitle>Which framework do you use?</QuestionnaireTitle>
          <QuestionnaireDescription>
            Pick the one you use most of the time.
          </QuestionnaireDescription>
          <QuestionnaireChoices>
            <QuestionnaireChoice value="next">
              Next.js
              <QuestionnaireChoiceDescription>
                App router with server components
              </QuestionnaireChoiceDescription>
            </QuestionnaireChoice>
            <QuestionnaireChoice value="vite">
              Vite
              <QuestionnaireChoiceDescription>
                Single page application
              </QuestionnaireChoiceDescription>
            </QuestionnaireChoice>
            <QuestionnaireChoice value="astro">
              Astro
              <QuestionnaireChoiceDescription>
                Content focused sites
              </QuestionnaireChoiceDescription>
            </QuestionnaireChoice>
          </QuestionnaireChoices>
          <QuestionnaireError />
        </QuestionnaireItem>
        <QuestionnaireItem name="features" multiple>
          <QuestionnaireTitle>
            What do you use from the library?
          </QuestionnaireTitle>
          <QuestionnaireDescription>
            Select all that apply, or skip this question.
          </QuestionnaireDescription>
          <QuestionnaireChoices>
            <QuestionnaireChoice value="docs">
              Documentation
            </QuestionnaireChoice>
            <QuestionnaireChoice value="registry">Registry</QuestionnaireChoice>
            <QuestionnaireChoice value="themes">Themes</QuestionnaireChoice>
          </QuestionnaireChoices>
          <QuestionnaireError />
        </QuestionnaireItem>
        <QuestionnaireItem name="feedback">
          <QuestionnaireTitle>Anything else?</QuestionnaireTitle>
          <QuestionnaireDescription>
            Tell us what you would like to see next.
          </QuestionnaireDescription>
          <QuestionnaireInput
            aria-label="Feedback"
            placeholder="Type your answer..."
          />
          <QuestionnaireError />
        </QuestionnaireItem>
        <QuestionnaireActions>
          <QuestionnairePrevious />
          <QuestionnaireSkip />
          <QuestionnaireNext />
          <QuestionnaireSubmit />
        </QuestionnaireActions>
      </Questionnaire>
    </div>
    @if (answers) {
      <pre class="w-full overflow-x-auto rounded-base border-2 border-border bg-secondary-background p-4 text-xs font-base">
        {JSON.stringify(answers, null, 2) as string}
      </pre>
    }
  </div>
}
