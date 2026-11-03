import { useEffect, useState } from "octane"

import { Card, CardContent } from "@/components/ui/card.tsrx"
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
  type CarouselApi,
} from "@/components/ui/carousel.tsrx"

export default function CarouselApiDemo() @{
  const [api, setApi] = useState<CarouselApi>()
  const [current, setCurrent] = useState(0)
  const [count, setCount] = useState(0)

  useEffect(() => {
    if (!api) {
      return
    }

    setCount(api.scrollSnapList().length)
    setCurrent(api.selectedScrollSnap() + 1)

    api.on("select", () => {
      setCurrent(api.selectedScrollSnap() + 1)
    })
  }, [api])

  <div class="mx-auto max-w-[10rem] sm:max-w-xs">
    <Carousel setApi={setApi} class="w-full max-w-xs">
      <CarouselContent>
        @for (
          const index of Array.from({ length: 5 }, (_, i) => i);
          key index
        ) {
          <CarouselItem>
            <div class="p-1">
              <Card class="p-0 shadow-none">
                <CardContent class="flex aspect-square items-center justify-center p-6">
                  <span class="text-4xl font-heading">{String(index + 1)}</span>
                </CardContent>
              </Card>
            </div>
          </CarouselItem>
        }
      </CarouselContent>
      <CarouselPrevious />
      <CarouselNext />
    </Carousel>
    <div class="py-2 text-center text-sm text-foreground">
      {"Slide " + current + " of " + count}
    </div>
  </div>
}
