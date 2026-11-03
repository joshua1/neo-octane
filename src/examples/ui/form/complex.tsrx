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
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group.tsrx"
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select.tsrx"
import { Switch } from "@/components/ui/switch.tsrx"
import { createToastManager, Toaster } from "@/components/ui/toast.tsrx"

const addons = [
  {
    id: "analytics",
    title: "Analytics",
    description: "Advanced analytics and reporting",
  },
  {
    id: "backup",
    title: "Backup",
    description: "Automated daily backups",
  },
  {
    id: "support",
    title: "Priority Support",
    description: "24/7 premium customer support",
  },
] as const

const billingPeriods = {
  monthly: "Monthly",
  yearly: "Yearly",
}

const formSchema = type({
  plan: type("'basic' | 'pro'").configure({
    message: "Invalid plan selection. Please choose Basic or Pro",
  }),
  billingPeriod: type("string").narrow(
    (value, ctx) =>
      value.length >= 1 ||
      ctx.reject({ message: "Please select a billing period" }),
  ),
  addons: type("string[]")
    .narrow(
      (value, ctx) =>
        value.length >= 1 ||
        ctx.reject({ message: "Please select at least one add-on" }),
    )
    .narrow(
      (value, ctx) =>
        value.length <= 3 ||
        ctx.reject({ message: "You can select up to 3 add-ons" }),
    )
    .narrow(
      (value, ctx) =>
        value.every((addon) => addons.some((a) => a.id === addon)) ||
        ctx.reject({ message: "You selected an invalid add-on" }),
    ),
  emailNotifications: "boolean",
})

const toastManager = createToastManager()

export default function FormComplexDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      plan: "basic",
      billingPeriod: "",
      addons: [],
      emailNotifications: false,
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
    <Card class="w-full max-w-sm">
      <CardHeader class="border-b-2 border-border pb-6">
        <CardTitle>You&apos;re almost there!</CardTitle>
        <CardDescription>
          Choose your subscription plan and billing period.
        </CardDescription>
      </CardHeader>
      <CardContent>
        <Form {...form}>
          <form
            id="form-complex"
            onSubmit={form.handleSubmit(onSubmit)}
            class="grid gap-8"
          >
            <FormField
              control={form.control}
              name="plan"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Subscription Plan</FormLabel>
                  <FormDescription>
                    Choose your subscription plan.
                  </FormDescription>
                  <FormControl>
                    <RadioGroup
                      name={field.name}
                      value={field.value}
                      onValueChange={field.onInput}
                      class="gap-3"
                    >
                      <FormItem class="flex items-start justify-between gap-4 rounded-base border-2 border-border bg-secondary-background p-4">
                        <div class="grid gap-1.5">
                          <FormLabel>Basic</FormLabel>
                          <FormDescription>
                            For individuals and small teams
                          </FormDescription>
                        </div>
                        <FormControl>
                          <RadioGroupItem value="basic" />
                        </FormControl>
                      </FormItem>
                      <FormItem class="flex items-start justify-between gap-4 rounded-base border-2 border-border bg-secondary-background p-4">
                        <div class="grid gap-1.5">
                          <FormLabel>Pro</FormLabel>
                          <FormDescription>
                            For businesses with higher demands
                          </FormDescription>
                        </div>
                        <FormControl>
                          <RadioGroupItem value="pro" />
                        </FormControl>
                      </FormItem>
                    </RadioGroup>
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="billingPeriod"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Billing Period</FormLabel>
                  <Select
                    name={field.name}
                    value={field.value}
                    onValueChange={field.onInput}
                    items={billingPeriods}
                  >
                    <FormControl>
                      <SelectTrigger>
                        <SelectValue placeholder="Select" />
                      </SelectTrigger>
                    </FormControl>
                    <SelectContent>
                      <SelectItem value="monthly">Monthly</SelectItem>
                      <SelectItem value="yearly">Yearly</SelectItem>
                    </SelectContent>
                  </Select>
                  <FormDescription>
                    Choose how often you want to be billed.
                  </FormDescription>
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="addons"
              render={({ field }) => (
                <FormItem>
                  <FormLabel>Add-ons</FormLabel>
                  <FormDescription>
                    Select additional features you&apos;d like to include.
                  </FormDescription>
                  @for (const addon of addons; key addon.id) {
                    <FormItem class="flex items-start gap-3">
                      <FormControl>
                        <Checkbox
                          name={field.name}
                          checked={field.value.includes(addon.id)}
                          onCheckedChange={(checked) => {
                            const newValue = checked
                              ? [...field.value, addon.id]
                              : field.value.filter(
                                  (value) => value !== addon.id,
                                )
                            field.onInput(newValue)
                            field.onBlur()
                          }}
                        />
                      </FormControl>
                      <div class="grid gap-1.5">
                        <FormLabel>{addon.title as string}</FormLabel>
                        <FormDescription>
                          {addon.description as string}
                        </FormDescription>
                      </div>
                    </FormItem>
                  }
                  <FormMessage />
                </FormItem>
              )}
            />
            <FormField
              control={form.control}
              name="emailNotifications"
              render={({ field }) => (
                <FormItem class="flex items-center justify-between gap-4">
                  <div class="grid gap-2">
                    <FormLabel>Email Notifications</FormLabel>
                    <FormDescription>
                      Receive email updates about your subscription
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
      <CardFooter class="border-t-2 border-border pt-6">
        <div class="grid w-full gap-2">
          <Button type="submit" form="form-complex">
            Save Preferences
          </Button>
          <Button type="button" variant="neutral" onClick={() => form.reset()}>
            Reset
          </Button>
        </div>
      </CardFooter>
    </Card>
  </Toaster>
}
