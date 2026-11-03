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
import { Textarea } from "@/components/ui/textarea.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const formSchema = type({
  about: type("string")
    .narrow(
      (about, ctx) =>
        about.length >= 10 ||
        ctx.reject({ message: "Please provide at least 10 characters." }),
    )
    .narrow(
      (about, ctx) =>
        about.length <= 200 ||
        ctx.reject({ message: "Please keep it under 200 characters." }),
    ),
})

const toastManager = createToastManager()

export default function FormTextareaDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      about: "",
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
    <Card class="w-full sm:max-w-md">
      <CardHeader>
        <CardTitle>Personalization</CardTitle>
        <CardDescription>
          Customize your experience by telling us more about yourself.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-textarea"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-6"
          >
            <FormField
              control={form.control}
              name="about"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>More about you</FormLabel>
                  <FormControl>
                    <Textarea
                      {...field}
                      placeholder="I'm a software engineer..."
                      class="min-h-[120px]"
                    />
                  </FormControl>
                  <FormDescription>
                    Tell us more about yourself. This will be used to help us
                    personalize your experience.
                  </FormDescription>
                  <FormMessage />
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
        <Button type="submit" form="form-textarea">
          Save
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
