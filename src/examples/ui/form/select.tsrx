import { arktypeResolver } from "@/lib/arktype-resolver"
import { useForm } from "@octanejs/hook-form"
import { type } from "arktype"

import { Button } from "@/components/ui/button.tsrx"
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card.tsrx"
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form.tsrx"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectSeparator,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const spokenLanguages = [
  { label: "English", value: "en" },
  { label: "Spanish", value: "es" },
  { label: "French", value: "fr" },
  { label: "German", value: "de" },
  { label: "Italian", value: "it" },
  { label: "Chinese", value: "zh" },
  { label: "Japanese", value: "ja" },
] as const

const languageItems = [{ label: "Auto", value: "auto" }, ...spokenLanguages]

const formSchema = type({
  language: type("string")
    .narrow(
      (language, ctx) =>
        language.length >= 1 ||
        ctx.reject({ message: "Please select your spoken language." }),
    )
    .narrow(
      (language, ctx) =>
        language !== "auto" ||
        ctx.reject({
          message:
            "Auto-detection is not allowed. Please select a specific language.",
        }),
    ),
})

const toastManager = createToastManager()

export default function FormSelectDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      language: "",
    },
  })

  function onSubmit(data: typeof formSchema.infer) {
    toastManager.add({
      title: "You submitted the following values:",
      description: (
        <code class="mt-2 block w-full overflow-x-auto rounded-base border-2 border-border bg-secondary-background p-3 text-xs whitespace-pre">
          {JSON.stringify(data, null, 2) as string}
        </code>
      ),
    })
  }

  <Toaster toastManager={toastManager}>
    <Card class="w-full sm:max-w-lg">
      <CardHeader>
        <CardTitle>Language Preferences</CardTitle>
        <CardDescription>
          Select your preferred spoken language.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-select"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-6"
          >
            <FormField
              control={form.control}
              name="language"
              render={({ field }) => (
                <FormItem class="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
                  <div class="grid gap-2">
                    <FormLabel>Spoken Language</FormLabel>
                    <FormDescription>
                      For best results, select the language you speak.
                    </FormDescription>
                    <FormMessage />
                  </div>
                  <Select
                    name={field.name}
                    value={field.value}
                    onValueChange={field.onInput}
                    items={languageItems}
                  >
                    <FormControl>
                      <SelectTrigger class="min-w-[120px] sm:w-auto">
                        <SelectValue placeholder="Select" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent alignItemWithTrigger>
                      <SelectItem value="auto">Auto</SelectItem>
                      <SelectSeparator />
                      @for (const language of spokenLanguages; key language.value) {
                        <SelectItem
                          value={language.value}
                        >
                          {language.label as string}
                        </SelectItem>
                      }
                    </SelectContent>
                  </Select>
                </FormItem>
              )}
            />
          </form>
        </Form>
      </CardContent>
      <CardFooter class="gap-2">
        <Button type="button" variant="neutral" onClick={() => form.reset()}>
          Reset
        </Button>
        <Button type="submit" form="form-select">
          Save
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
