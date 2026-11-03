import { Card, CardContent } from "@/components/ui/card.tsrx"
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel.tsrx"

export default function CarouselDemo() @{
  <div class="w-full flex-col items-center gap-4 flex">
    <Carousel class="w-full max-w-[200px]">
      <CarouselContent>
        @for (
          const index of Array.from({ length: 5 }, (_, i) => i);
          key index
        ) {
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
      <CarouselPrevious />
      <CarouselNext />
    </Carousel>
  </div>
}
