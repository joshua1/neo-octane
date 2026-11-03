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
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const plans = [
  {
    id: "starter",
    title: "Starter (100K tokens/month)",
    description: "For everyday use with basic features.",
  },
  {
    id: "pro",
    title: "Pro (1M tokens/month)",
    description: "For advanced AI usage with more features.",
  },
  {
    id: "enterprise",
    title: "Enterprise (Unlimited tokens)",
    description: "For large teams and heavy usage.",
  },
] as const

const formSchema = type({
  plan: type("string").narrow(
    (plan, ctx) =>
      plan.length >= 1 ||
      ctx.reject({
        message: "You must select a subscription plan to continue.",
      }),
  ),
})

const toastManager = createToastManager()

export default function FormRadioGroupDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      plan: "",
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
        <CardTitle>Subscription Plan</CardTitle>
        <CardDescription>
          See pricing and features for each plan.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-radio-group"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-6"
          >
            <FormField
              control={form.control}
              name="plan"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Plan</FormLabel>
                  <FormDescription>
                    You can upgrade or downgrade your plan at any time.
                  </FormDescription>
                  <FormControl>
                    <RadioGroup
                      name={field.name}
                      value={field.value}
                      onValueChange={field.onInput}
                      class="gap-3"
                    >
                      @for (const plan of plans; key plan.id) {
                        <FormItem
                          class="flex items-start justify-between gap-4 rounded-base border-2 border-border bg-secondary-background p-4"
                        >
                          <div class="grid gap-1.5">
                            <FormLabel>{plan.title as string}</FormLabel>
                            <FormDescription>
                              {plan.description as string}
                            </FormDescription>
                          </div>
                          <FormControl>
                            <RadioGroupItem value={plan.id} />
                          </FormControl>
                        </FormItem>
                      }
                    </RadioGroup>
                  </FormControl>
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
        <Button type="submit" form="form-radio-group">
          Save
        </Button>
      </CardFooter>
    </Card>
  </Toaster>
}
