import { Badge } from "@/components/ui/badge.tsrx"
import { Button } from "@/components/ui/button.tsrx"
import {
  Card,
  CardAction,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card.tsrx"

export default function CardImageDemo() @{
  <Card class="relative mx-auto w-full max-w-sm overflow-hidden pt-0">
    <div class="absolute inset-0 z-30 aspect-video bg-black/35" />
    <img
      src="https://avatar.vercel.sh/shadcn1"
      alt="Event cover"
      class="relative z-20 aspect-video w-full object-cover brightness-60 grayscale dark:brightness-40"
    />
    <CardHeader>
      <CardAction>
        <Badge variant="neutral">Featured</Badge>
      </CardAction>
      <CardTitle>Design systems meetup</CardTitle>
      <CardDescription>
        A practical talk on component APIs, accessibility, and shipping faster.
      </CardDescription>
    </CardHeader>
    <CardFooter>
      <Button class="w-full">View Event</Button>
    </CardFooter>
  </Card>
}
