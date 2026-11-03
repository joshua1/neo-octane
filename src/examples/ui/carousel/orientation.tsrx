import { Card, CardContent } from "@/components/ui/card.tsrx"
import {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselNext,
  CarouselPrevious,
} from "@/components/ui/carousel.tsrx"

export default function CarouselOrientationDemo() @{
  <Carousel
    opts={{
      align: "start",
    }}
    orientation="vertical"
    class="w-full max-w-xs"
  >
    <CarouselContent class="-mt-1 h-[270px]">
      @for (const index of Array.from({ length: 5 }, (_, i) => i); key index) {
        <CarouselItem class="basis-1/2 pt-1">
          <div class="p-1">
            <Card class="p-0 shadow-none">
              <CardContent class="flex items-center justify-center p-6">
                <span class="text-3xl font-heading">{String(index + 1)}</span>
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
