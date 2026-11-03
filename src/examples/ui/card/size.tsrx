import { ChevronRightIcon } from "@octanejs/lucide"

import { Button } from "@/components/ui/button.tsrx"
import {
  Card,
  CardContent,
  CardDescription,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card.tsrx"

export default function CardSizeDemo() @{
  const featureName = "Scheduled reports"

  <Card size="sm" class="mx-auto w-full max-w-xs">
    <CardHeader>
      <CardTitle>{featureName}</CardTitle>
      <CardDescription>
        Weekly snapshots. No more manual exports.
      </CardDescription>
    </CardHeader>
    <CardContent>
      <ul class="grid gap-2 py-2 text-sm">
        <li class="flex gap-2">
          <ChevronRightIcon class="mt-0.5 size-4 shrink-0 text-foreground" />
          <span>Choose a schedule (daily, or weekly).</span>
        </li>
        <li class="flex gap-2">
          <ChevronRightIcon class="mt-0.5 size-4 shrink-0 text-foreground" />
          <span>Send to channels or specific teammates.</span>
        </li>
        <li class="flex gap-2">
          <ChevronRightIcon class="mt-0.5 size-4 shrink-0 text-foreground" />
          <span>Include charts, tables, and key metrics.</span>
        </li>
      </ul>
    </CardContent>
    <CardFooter class="flex-col gap-2">
      <Button size="sm" class="w-full">
        Set up scheduled reports
      </Button>
      <Button variant="neutral" size="sm" class="w-full">
        See what's new
      </Button>
    </CardFooter>
  </Card>
}
