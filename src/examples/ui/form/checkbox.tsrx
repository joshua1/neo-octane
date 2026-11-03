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
import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from "@/components/ui/form.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const tasks = [
  {
    id: "push",
    label: "Push notifications",
  },
  {
    id: "email",
    label: "Email notifications",
  },
] as const

const formSchema = type({
  responses: "boolean",
  tasks: type("string[]")
    .narrow(
      (value, ctx) =>
        value.length >= 1 ||
        ctx.reject({
          message: "Please select at least one notification type.",
        }),
    )
    .narrow(
      (value, ctx) =>
        value.every((task) => tasks.some((t) => t.id === task)) ||
        ctx.reject({ message: "Invalid notification type selected." }),
    ),
})

const toastManager = createToastManager()

export default function FormCheckboxDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      responses: true,
      tasks: [],
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
        <CardTitle>Notifications</CardTitle>
        <CardDescription>Manage your notification preferences.</CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-checkbox"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-8"
          >
            <FormField
              control={form.control}
              name="responses"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Responses</FormLabel>
                  <FormDescription>
                    Get notified for requests that take time, like research or
                    image generation.
                  </FormDescription>
                  <FormItem class="flex items-center gap-2">
                    <FormControl>
                      <Checkbox
                        name={field.name}
                        checked={field.value}
                        onCheckedChange={field.onInput}
                        disabled
                      />
                    </FormControl>
                    <FormLabel class="font-base">Push notifications</FormLabel>
                  </FormItem>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="tasks"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Tasks</FormLabel>
                  <FormDescription>
                    Get notified when tasks you&apos;ve created have updates.
                  </FormDescription>
                  @for (const task of tasks; key task.id) {
                    <FormItem class="flex items-center gap-2">
                      <FormControl>
                        <Checkbox
                          name={field.name}
                          checked={field.value.includes(task.id)}
                          onCheckedChange={(checked) => {
                            const newValue = checked
                              ? [...field.value, task.id]
                              : field.value.filter((value) => value !== task.id)
                            field.onInput(newValue)
                          }}
                        />
                      </FormControl>
                      <FormLabel class="font-base">
                        {task.label as string}
                      </FormLabel>
                    </FormItem>
                  }
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
        <Button type="submit" form="form-checkbox">
          Save
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
