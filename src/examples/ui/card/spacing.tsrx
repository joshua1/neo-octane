import { useState } from "octane"

import { Button } from "@/components/ui/button.tsrx"
import {
  Card,
  CardAction,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import { Label } from "@/components/ui/label.tsrx"
import { ToggleGroup, ToggleGroupItem } from "@/components/ui/toggle-group.tsrx"

const spacingOptions = [
  {
    class: "[--card-spacing:--spacing(4)]",
    label: "16px",
    value: "4",
  },
  {
    class: "[--card-spacing:--spacing(5)]",
    label: "20px",
    value: "5",
  },
  {
    class: "[--card-spacing:--spacing(6)]",
    label: "24px",
    value: "6",
  },
  {
    class: "[--card-spacing:--spacing(8)]",
    label: "32px",
    value: "8",
  },
]

export default function CardSpacingDemo() @{
  const [spacing, setSpacing] = useState("4")
  const selectedSpacing = spacingOptions.find(
    (option) => option.value === spacing,
  )

  <div class="mx-auto grid w-full max-w-sm gap-4">
    <ToggleGroup
      value={[spacing]}
      onValueChange={(value: string[]) => {
        if (value[0]) {
          setSpacing(value[0])
        }
      }}
      size="sm"
      class="justify-center"
    >
      @for (const option of spacingOptions; key option.value) {
        <ToggleGroupItem value={option.value}>
          {option.label as string}
        </ToggleGroupItem>
      }
    </ToggleGroup>
    <Card class={selectedSpacing?.class}>
      <CardHeader>
        <CardTitle>Login to your account</CardTitle>
        <CardDescription>
          Enter your email below to login to your account
        </CardDescription>
        <CardAction>
          <a href="#" class="text-sm underline-offset-4 hover:underline">
            Sign Up
          </a>
        </CardAction>
      </CardHeader>
      <CardContent>
        <form>
          <div class="flex flex-col gap-6">
            <div class="grid gap-2">
              <Label for="email-spacing">Email</Label>
              <Input
                id="email-spacing"
                type="email"
                placeholder="m@example.com"
                required
              />
            </div>
            <div class="grid gap-2">
              <div class="flex items-center">
                <Label for="password-spacing">Password</Label>
                <a
                  href="#"
                  class="ml-auto inline-block text-sm underline-offset-4 hover:underline"
                >
                  Forgot your password?
                </a>
              </div>
              <Input id="password-spacing" type="password" required />
            </div>
          </div>
        </form>
      </CardContent>
      <CardFooter class="flex-col gap-2">
        <Button type="submit" class="w-full">
          Login
        </Button>
        <Button variant="neutral" class="w-full">
          Login with Google
        </Button>
      </CardFooter>
    </Card>
  </div>
}
