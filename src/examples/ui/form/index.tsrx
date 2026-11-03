import { arktypeResolver } from "@/lib/arktype-resolver"
import { useForm } from "@octanejs/hook-form"
import { type } from "arktype"

import { Button } from "@/components/ui/button.tsrx"
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

const formSchema = type({
  username: type("string").narrow(
    (username, ctx) =>
      username.length >= 2 ||
      ctx.reject({ message: "Username must be at least 2 characters." }),
  ),
})

export default function FormDemo() @{
  const form = useForm<typeof formSchema.infer>({
    resolver: arktypeResolver(formSchema),
    defaultValues: {
      username: "",
    },
  })

  function onSubmit(values: typeof formSchema.infer) {
    console.log(values)
  }

  <Form {...form}>
    <form onSubmit={form.handleSubmit(onSubmit)} class="space-y-8">
      <FormField
        control={form.control}
        name="username"
        render={({ field }) => (
          <FormItem>
            <FormLabel>Username</FormLabel>
            <FormControl>
              <Input placeholder="ekmas" {...field} />
            </FormControl>
            <FormDescription>This is your public display name.</FormDescription>
            <FormMessage />
          </FormItem>
        )}
      />
      <Button type="submit">Submit</Button>
    </form>
  </Form>
}
