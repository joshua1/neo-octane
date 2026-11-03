import { ChevronsUpDown, Terminal } from "@octanejs/lucide"

import { Marquee } from "@/components/primitives/marquee.tsrx"

import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion.tsrx"
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert.tsrx"
import {
  Breadcrumb,
  BreadcrumbItem,
  BreadcrumbLink,
  BreadcrumbList,
  BreadcrumbPage,
  BreadcrumbSeparator,
} from "@/components/ui/breadcrumb.tsrx"
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
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel.tsrx"
import { Checkbox } from "@/components/ui/checkbox.tsrx"
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import {
  InputOTP,
  InputOTPGroup,
  InputOTPSeparator,
  InputOTPSlot,
} from "@/components/ui/input-otp.tsrx"
import { Label } from "@/components/ui/label.tsrx"
import { RadioGroup, RadioGroupItem } from "@/components/ui/radio-group.tsrx"
import {
  ResizableHandle,
  ResizablePanel,
  ResizablePanelGroup,
} from "@/components/ui/resizable.tsrx"
import { ScrollArea } from "@/components/ui/scroll-area.tsrx"
import { Slider } from "@/components/ui/slider.tsrx"

import { cn, type ClassValue } from "@/lib/utils"

export default function HeroComponents({
  class: klass,
  className,
  reverse,
}: {
  class?: ClassValue
  className?: string
  reverse?: boolean
}) @{
  <div
    aria-hidden="true"
    class={cn(
      "h-full w-[340px] absolute top-[70px] pointer-events-none overflow-y-hidden",
      className,
      klass,
    )}
  >
    <Marquee
      direction="up"
      reverse={reverse}
      class="flex flex-col w-full max-w-full h-full overflow-hidden pr-3 [&>*]:gap-[20px]"
    >
      <CardExample />
      <AlertExample />
      <AccordionExample />
      <InputOTPExample />
      <ResizableExample />
      <ScrollAreaExample />
      <SliderExample />
      <BreadcrumbExample />
      <RadioGroupExample />
      <CheckboxExample />
      <CarouselExample />
      <CollapsibleExample />
    </Marquee>
  </div>
}

function CardExample() @{
  <Card class="w-full bg-main text-main-foreground max-w-sm">
    <CardHeader>
      <CardTitle>Login to your account</CardTitle>
      <CardDescription>
        Enter your email below to login to your account
      </CardDescription>
    </CardHeader>
    <CardContent>
      <form>
        <div class="flex flex-col gap-6">
          <div class="grid gap-2">
            <Label for="email">Email</Label>
            <Input
              id="email"
              type="email"
              placeholder="m@example.com"
              required
              tabIndex={-1}
            />
          </div>
          <div class="grid gap-2">
            <div class="flex items-center">
              <Label for="password">Password</Label>
              <a
                href="#"
                class="ml-auto inline-block text-sm underline-offset-4 hover:underline"
                tabIndex={-1}
              >
                Forgot your password?
              </a>
            </div>
            <Input id="password" type="password" required tabIndex={-1} />
          </div>
        </div>
      </form>
    </CardContent>
    <CardFooter class="flex-col gap-2">
      <Button variant="neutral" type="submit" class="w-full" tabIndex={-1}>
        Login
      </Button>
      <Button class="w-full" tabIndex={-1}>
        Login with Google
      </Button>
      <div class="mt-4 text-center text-sm">
        Don&apos;t have an account?{" "}
        <a href="#" class="underline underline-offset-4" tabIndex={-1}>
          Sign up
        </a>
      </div>
    </CardFooter>
  </Card>
}

function AlertExample() @{
  <Alert>
    <Terminal />
    <AlertTitle>Alert</AlertTitle>
    <AlertDescription>
      You can add components and dependencies to your app using the cli.
    </AlertDescription>
  </Alert>
}

function AccordionExample() @{
  <Accordion class="w-full">
    <AccordionItem class="max-w-full" value="item-1">
      <AccordionTrigger tabIndex={-1}>Is it accessible?</AccordionTrigger>
      <AccordionContent>
        Yes. It adheres to the WAI-ARIA design pattern.
      </AccordionContent>
    </AccordionItem>
  </Accordion>
}

function InputOTPExample() @{
  <div class="bg-main w-full flex-col border-2 border-border shadow-shadow py-4 flex items-center justify-center rounded-base">
    <p class="mb-4 text-lg text-main-foreground font-heading">
      Your OTP code is:
    </p>

    <InputOTP inert maxLength={6}>
      <InputOTPGroup>
        @for (const index of [0, 1, 2]; key index) {
          <InputOTPSlot index={index} tabIndex={-1} />
        }
      </InputOTPGroup>
      <InputOTPSeparator />
      <InputOTPGroup>
        @for (const index of [3, 4, 5]; key index) {
          <InputOTPSlot index={index} tabIndex={-1} />
        }
      </InputOTPGroup>
    </InputOTP>
  </div>
}

function ResizableExample() @{
  <ResizablePanelGroup
    orientation="horizontal"
    inert
    class="rounded-base max-w-md max-h-[200px] min-h-[200px] border-2 border-border text-foreground shadow-shadow"
  >
    <ResizablePanel tabIndex={-1} defaultSize={50}>
      <div class="flex h-full items-center justify-center bg-background p-6">
        <span class="font-base">One</span>
      </div>
    </ResizablePanel>
    <ResizableHandle />
    <ResizablePanel tabIndex={-1} defaultSize={50}>
      <ResizablePanelGroup orientation="vertical">
        <ResizablePanel tabIndex={-1} defaultSize={25}>
          <div class="flex h-full items-center justify-center bg-background p-6">
            <span class="font-base">Two</span>
          </div>
        </ResizablePanel>
        <ResizableHandle />
        <ResizablePanel tabIndex={-1} defaultSize={75}>
          <div class="flex h-full items-center justify-center bg-background p-6">
            <span class="font-base">Three</span>
          </div>
        </ResizablePanel>
      </ResizablePanelGroup>
    </ResizablePanel>
  </ResizablePanelGroup>
}

function ScrollAreaExample() @{
  <ScrollArea
    tabIndex={-1}
    inert
    class="rounded-base h-[150px] w-full text-foreground border-2 border-border bg-background p-4 shadow-shadow"
  >
    Jokester began sneaking into the castle in the middle of the night and
    leaving jokes all over the place: under the king&apos;s pillow, in his soup,
    even in the royal toilet. The king was furious, but he couldn&apos;t seem to
    stop Jokester. And then, one day, the people of the kingdom discovered that
    the jokes left by Jokester were so funny that they couldn&apos;t help but
    laugh. And once they started laughing, they couldn&apos;t stop.
  </ScrollArea>
}

function SliderExample() @{
  <div class="bg-main w-full border-2 border-border shadow-shadow p-4 py-6 flex items-center justify-center rounded-base">
    <Slider defaultValue={[33]} max={100} step={1} tabIndex={-1} inert />
  </div>
}

function BreadcrumbExample() @{
  <div class="bg-main w-full border-2 border-border shadow-shadow p-4 flex items-center justify-center rounded-base">
    <Breadcrumb>
      <BreadcrumbList class="gap-1 sm:gap-1 text-main-foreground">
        <BreadcrumbItem>
          <BreadcrumbLink tabIndex={-1} href="/">
            Home
          </BreadcrumbLink>
        </BreadcrumbItem>
        <BreadcrumbSeparator />
        <BreadcrumbItem>
          <BreadcrumbLink tabIndex={-1} href="/shadcn/components/button">
            Components
          </BreadcrumbLink>
        </BreadcrumbItem>
        <BreadcrumbSeparator />
        <BreadcrumbItem>
          <BreadcrumbPage tabIndex={-1}>Button</BreadcrumbPage>
        </BreadcrumbItem>
      </BreadcrumbList>
    </Breadcrumb>
  </div>
}

function RadioGroupExample() @{
  <div class="bg-main w-full border-2 border-border shadow-shadow p-4 flex items-center justify-center rounded-base">
    <RadioGroup defaultValue="comfortable" inert>
      <div class="flex items-center space-x-2">
        <RadioGroupItem tabIndex={-1} class="" value="default" id="r1" />
        <Label class="text-main-foreground" for="r1">
          Default
        </Label>
      </div>
      <div class="flex items-center space-x-2">
        <RadioGroupItem tabIndex={-1} class="" value="comfortable" id="r2" />
        <Label class="text-main-foreground" for="r2">
          Comfortable
        </Label>
      </div>
      <div class="flex items-center space-x-2">
        <RadioGroupItem tabIndex={-1} class="" value="compact" id="r3" />
        <Label class="text-main-foreground" for="r3">
          Compact
        </Label>
      </div>
    </RadioGroup>
  </div>
}

function CheckboxExample() @{
  <div class="bg-main w-full border-2 border-border shadow-shadow p-4 flex text-main-foreground items-center justify-center rounded-base">
    <div class="flex items-center space-x-2">
      <Checkbox id="terms" tabIndex={-1} />
      <Label for="terms">Accept terms and conditions</Label>
    </div>
  </div>
}

function CarouselExample() @{
  <div class="w-full flex-col items-center gap-4 flex">
    <Carousel class="w-full max-w-[200px]">
      <CarouselContent>
        @for (const index of [0, 1, 2, 3, 4]; key index) {
          <CarouselItem>
            <div class="p-[10px]">
              <Card class="shadow-none p-0 bg-background text-foreground">
                <CardContent class="flex aspect-square items-center justify-center p-4">
                  <span class="text-3xl font-base">{String(index + 1)}</span>
                </CardContent>
              </Card>
            </div>
          </CarouselItem>
        }
      </CarouselContent>
      <CarouselPrevious tabIndex={-1} />
      <CarouselNext tabIndex={-1} />
    </Carousel>
  </div>
}

function CollapsibleExample() @{
  <Collapsible class="w-full space-y-2">
    <div class="rounded-base flex items-center justify-between space-x-4 border-2 border-border text-foreground bg-background px-4 py-2">
      <h4 class="text-sm font-heading">@octanejs published 3 packages</h4>
      <CollapsibleTrigger
        render={
          <Button
            variant="noShadow"
            size="sm"
            class="w-9 bg-secondary-background text-foreground p-0"
            tabIndex={-1}
          />
        }
      >
        <ChevronsUpDown class="size-4" />
        <span class="sr-only">Toggle</span>
      </CollapsibleTrigger>
    </div>
    <div class="rounded-base border-2 border-border bg-background px-4 py-3 font-mono font-base text-foreground text-sm">
      @octanejs/base-ui
    </div>
    <CollapsibleContent class="space-y-2 text-foreground font-base">
      <div class="rounded-base border-2 border-border bg-background px-4 py-3 font-mono text-sm">
        @octanejs/shadcn
      </div>
      <div class="rounded-base border-2 border-border bg-background px-4 py-3 font-mono text-sm">
        @octanejs/lucide
      </div>
    </CollapsibleContent>
  </Collapsible>
}
