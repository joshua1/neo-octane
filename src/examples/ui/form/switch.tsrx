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
import { Switch } from "@/components/ui/switch.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const formSchema = type({
  // `.configure` rather than `ctx.reject`: ArkType replaces a reject message
  // on a boolean narrowed to `true` with its own "must be true" message.
  twoFactor: type("boolean")
    .narrow((twoFactor): boolean => twoFactor === true)
    .configure({
      message: "It is highly recommended to enable two-factor authentication.",
    }),
})

const toastManager = createToastManager()

export default function FormSwitchDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      twoFactor: false,
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
        <CardTitle>Security Settings</CardTitle>
        <CardDescription>
          Manage your account security preferences.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-switch"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-6"
          >
            <FormField
              control={form.control}
              name="twoFactor"
              render={({ field }) => (
                <FormItem class="flex items-center justify-between gap-4">
                  <div class="grid gap-2">
                    <FormLabel>Multi-factor authentication</FormLabel>
                    <FormDescription>
                      Enable multi-factor authentication to secure your account.
                    </FormDescription>
                    <FormMessage />
                  </div>
                  <FormControl>
                    <Switch
                      name={field.name}
                      checked={field.value}
                      onCheckedChange={field.onInput}
                    />
                  </FormControl>
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
        <Button type="submit" form="form-switch">
          Save
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
