import { useState, type FormEvent } from "octane"

import {
  Questionnaire,
  QuestionnaireActions,
  QuestionnaireDescription,
  QuestionnaireError,
  QuestionnaireInput,
  QuestionnaireItem,
  QuestionnaireNext,
  QuestionnairePrevious,
  QuestionnaireProgress,
  QuestionnaireSubmit,
  QuestionnaireTitle,
} from "@/components/ui/questionnaire.tsrx"

const items = [
  { name: "name", required: true },
  { name: "email", required: true },
] as const

const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

export default function QuestionnaireValidationDemo() @{
  const [email, setEmail] = useState("")
  const [result, setResult] = useState<{
    name: string
    email: string
  } | null>(null)

  const emailInvalid = email.length > 0 && !EMAIL_PATTERN.test(email)

  function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault()
    const formData = new FormData(event.currentTarget)
    setResult({
      name: String(formData.get("name") ?? ""),
      email: String(formData.get("email") ?? ""),
    })
  }

  <div class="flex w-full max-w-md flex-col gap-4">
    <Questionnaire items={items} onSubmit={handleSubmit}>
      <QuestionnaireProgress />
      <QuestionnaireItem name="name" required>
        <QuestionnaireTitle>What should we call you?</QuestionnaireTitle>
        <QuestionnaireInput
          aria-label="Name"
          placeholder="Your name"
          autoComplete="name"
        />
        <QuestionnaireError>Enter your name to continue.</QuestionnaireError>
      </QuestionnaireItem>
      <QuestionnaireItem name="email" required invalid={emailInvalid}>
        <QuestionnaireTitle>Where can we reach you?</QuestionnaireTitle>
        <QuestionnaireDescription>
          We only use this to send you the results.
        </QuestionnaireDescription>
        <QuestionnaireInput
          type="email"
          aria-label="Email"
          placeholder="you@example.com"
          autoComplete="email"
          onInput={(event: InputEvent) =>
            setEmail((event.currentTarget as HTMLInputElement).value)
          }
        />
        <QuestionnaireError>
          {
            (email
              ? "Enter a valid email address."
              : "Enter your email to continue.") as string
          }
        </QuestionnaireError>
      </QuestionnaireItem>
      <QuestionnaireActions>
        <QuestionnairePrevious />
        <QuestionnaireNext />
        <QuestionnaireSubmit />
      </QuestionnaireActions>
    </Questionnaire>
    @if (result) {
      <p class="text-sm font-base text-foreground">
        {"Thanks " +
          result.name +
          ", we'll be in touch at " +
          result.email +
          "."}
      </p>
    }
  </div>
}
