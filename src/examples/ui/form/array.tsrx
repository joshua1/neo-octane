import { arktypeResolver } from "@/lib/arktype-resolver"
import { XIcon } from "@octanejs/lucide"
import { useFieldArray, useForm } from "@octanejs/hook-form"
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
  InputGroup,
  InputGroupAddon,
  InputGroupButton,
  InputGroupInput,
} from "@/components/ui/input-group.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const formSchema = type({
  emails: type({
    address: type("string.email").configure({
      message: "Enter a valid email address.",
    }),
  })
    .array()
    .narrow(
      (emails, ctx) =>
        emails.length >= 1 ||
        ctx.reject({ message: "Add at least one email address." }),
    )
    .narrow(
      (emails, ctx) =>
        emails.length <= 5 ||
        ctx.reject({ message: "You can add up to 5 email addresses." }),
    ),
})

const toastManager = createToastManager()

export default function FormArrayDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      emails: [{ address: "" }, { address: "" }],
    },
  })

  const { fields, append, remove } = useFieldArray({
    control: form.control,
    name: "emails",
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
      <CardHeader class="border-b-2 border-border pb-6">
        <CardTitle>Contact Emails</CardTitle>
        <CardDescription>Manage your contact email addresses.</CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-array"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-4"
          >
            <div class="grid gap-2">
              <FormLabel>Email Addresses</FormLabel>
              <p class="text-sm font-base text-foreground">
                Add up to 5 email addresses where we can contact you.
              </p>
            </div>
            @for (const item of fields; index index; key item.id) {
              <FormField
                control={form.control}
                name={`emails.${index}.address` as const}
                render={({ field }) => (
                  <FormItem>
                    <FormLabel class="sr-only">
                      {"Email " + (index + 1)}
                    </FormLabel>
                    <InputGroup>
                      <FormControl>
                        <InputGroupInput
                          {...field}
                          placeholder="name@example.com"
                          type="email"
                          autoComplete="email"
                        />
                      </FormControl>
                      @if (fields.length > 1) {
                        <InputGroupAddon align="inline-end">
                          <InputGroupButton
                            type="button"
                            size="icon-xs"
                            onClick={() => remove(index)}
                            aria-label={`Remove email ${index + 1}`}
                          >
                            <XIcon />
                          </InputGroupButton>
                        </InputGroupAddon>
                      }
                    </InputGroup>
                    <FormMessage />
                  </FormItem>
                )}
              />
            }
            <Button
              type="button"
              variant="neutral"
              size="sm"
              class="justify-self-start"
              onClick={() => append({ address: "" })}
              disabled={fields.length >= 5}
            >
              Add Email Address
            </Button>
            @if (form.formState.errors.emails?.root) {
              <p class="text-sm font-base text-red-500">
                {form.formState.errors.emails.root.message as string}
              </p>
            }
          </form>
        </Form>
      </CardContent>
      <CardFooter class="gap-2 border-t-2 border-border pt-6">
        <Button type="button" variant="neutral" onClick={() => form.reset()}>
          Reset
        </Button>
        <Button type="submit" form="form-array">
          Save
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
