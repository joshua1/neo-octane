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
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const formSchema = type({
  username: type("string")
    .narrow(
      (username, ctx) =>
        username.length >= 3 ||
        ctx.reject({ message: "Username must be at least 3 characters." }),
    )
    .narrow(
      (username, ctx) =>
        username.length <= 10 ||
        ctx.reject({ message: "Username must be at most 10 characters." }),
    )
    .narrow(
      (username, ctx) =>
        /^[a-zA-Z0-9_]+$/.test(username) ||
        ctx.reject({
          message:
            "Username can only contain letters, numbers, and underscores.",
        }),
    ),
})

const toastManager = createToastManager()

export default function FormInputDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      username: "",
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
        <CardTitle>Profile Settings</CardTitle>
        <CardDescription>
          Update your profile information below.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-input"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-6"
          >
            <FormField
              control={form.control}
              name="username"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Username</FormLabel>
                  <FormControl>
                    <Input
                      {...field}
                      placeholder="shadcn"
                      autoComplete="username"
                    />
                  </FormControl>
                  <FormDescription>
                    This is your public display name. Must be between 3 and 10
                    characters. Must only contain letters, numbers, and
                    underscores.
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
        <Button type="submit" form="form-input">
          Save
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
