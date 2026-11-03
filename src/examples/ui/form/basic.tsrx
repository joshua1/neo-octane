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
import { Input } from "@/components/ui/input.tsrx"
import {
  InputGroup,
  InputGroupAddon,
  InputGroupText,
  InputGroupTextarea,
} from "@/components/ui/input-group.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const formSchema = type({
  title: type("string")
    .narrow(
      (title, ctx) =>
        title.length >= 5 ||
        ctx.reject({ message: "Bug title must be at least 5 characters." }),
    )
    .narrow(
      (title, ctx) =>
        title.length <= 32 ||
        ctx.reject({ message: "Bug title must be at most 32 characters." }),
    ),
  description: type("string")
    .narrow(
      (description, ctx) =>
        description.length >= 20 ||
        ctx.reject({ message: "Description must be at least 20 characters." }),
    )
    .narrow(
      (description, ctx) =>
        description.length <= 100 ||
        ctx.reject({ message: "Description must be at most 100 characters." }),
    ),
})

const toastManager = createToastManager()

export default function FormBasicDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      title: "",
      description: "",
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
        <CardTitle>Bug Report</CardTitle>
        <CardDescription>
          Help us improve by reporting bugs you encounter.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-basic"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-6"
          >
            <FormField
              control={form.control}
              name="title"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Bug Title</FormLabel>
                  <FormControl>
                    <Input
                      {...field}
                      placeholder="Login button not working on mobile"
                      autoComplete="off"
                    />
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="description"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Description</FormLabel>
                  <InputGroup>
                    <FormControl>
                      <InputGroupTextarea
                        {...field}
                        placeholder="I'm having an issue with the login button on mobile."
                        rows={6}
                        class="min-h-24 resize-none"
                      />
                    </FormControl>
                    <InputGroupAddon align="block-end">
                      <InputGroupText class="tabular-nums">
                        {field.value.length + "/100 characters"}
                      </InputGroupText>
                    </InputGroupAddon>
                  </InputGroup>
                  <FormDescription>
                    Include steps to reproduce, expected behavior, and what
                    actually happened.
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
        <Button type="submit" form="form-basic">
          Submit
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
