import { Card, CardContent } from "@/components/ui/card.tsrx"
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel.tsrx"

export default function CarouselSpacingDemo() @{
  <Carousel class="w-full max-w-[12rem] sm:max-w-xs md:max-w-sm">
    <CarouselContent class="-ml-1">
      @for (const index of Array.from({ length: 5 }, (_, i) => i); key index) {
        <CarouselItem class="basis-1/2 pl-1 lg:basis-1/3">
          <div class="p-1">
            <Card class="p-0 shadow-none">
              <CardContent class="flex aspect-square items-center justify-center p-6">
                <span class="text-2xl font-heading">{String(index + 1)}</span>
              </CardContent>
            </Card>
          </div>
        </CarouselItem>
      }
    </CarouselContent>
    <CarouselPrevious />
    <CarouselNext />
  </Carousel>
}
