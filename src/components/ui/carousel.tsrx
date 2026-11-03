import type { ClassValue } from "clsx"
import useEmblaCarousel, {
  type UseEmblaCarouselType,
} from "@octanejs/embla-carousel"
import { ArrowLeft, ArrowRight } from "@octanejs/lucide"
import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useState,
  type OctaneNode,
} from "octane"

import { Button } from "@/components/ui/button.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

export type CarouselApi = UseEmblaCarouselType[1]
type UseCarouselParameters = Parameters<typeof useEmblaCarousel>
type CarouselOptions = UseCarouselParameters[0]
type CarouselPlugin = UseCarouselParameters[1]

type CarouselProps = {
  opts?: CarouselOptions
  plugins?: CarouselPlugin
  orientation?: "horizontal" | "vertical"
  setApi?: (api: CarouselApi) => void
}

type CarouselContextProps = {
  carouselRef: ReturnType<typeof useEmblaCarousel>[0]
  api: ReturnType<typeof useEmblaCarousel>[1]
  scrollPrev: () => void
  scrollNext: () => void
  canScrollPrev: boolean
  canScrollNext: boolean
  plugins?: CarouselPlugin
} & CarouselProps

type DivProps = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type ButtonProps = Parameters<typeof Button>[0]

const CarouselContext = createContext<CarouselContextProps | null>(null)

function useCarousel() {
  const context = useContext(CarouselContext)

  if (!context) {
    throw new Error("useCarousel must be used within a <Carousel />")
  }

  return context
}

function Carousel({
  orientation = "horizontal",
  opts,
  setApi,
  plugins,
  class: klass,
  className,
  children,
  ...props
}: DivProps & CarouselProps) @{
  const [carouselRef, api] = useEmblaCarousel(
    {
      ...opts,
      axis: orientation === "horizontal" ? "x" : "y",
    },
    plugins,
  )
  const [canScrollPrev, setCanScrollPrev] = useState(false)
  const [canScrollNext, setCanScrollNext] = useState(false)

  const onSelect = useCallback((api: CarouselApi) => {
    if (!api) {
      return
    }

    setCanScrollPrev(api.canScrollPrev())
    setCanScrollNext(api.canScrollNext())
  }, [])

  const scrollPrev = useCallback(() => {
    api?.scrollPrev()
  }, [api])

  const scrollNext = useCallback(() => {
    api?.scrollNext()
  }, [api])

  const handleKeyDown = useCallback(
    (event: KeyboardEvent) => {
      if (event.key === "ArrowLeft") {
        event.preventDefault()
        scrollPrev()
      } else if (event.key === "ArrowRight") {
        event.preventDefault()
        scrollNext()
      }
    },
    [scrollPrev, scrollNext],
  )

  useEffect(() => {
    if (!api || !setApi) {
      return
    }

    setApi(api)
  }, [api, setApi])

  useEffect(() => {
    if (!api) {
      return
    }

    onSelect(api)
    api.on("reInit", onSelect)
    api.on("select", onSelect)

    return () => {
      api?.off("select", onSelect)
    }
  }, [api, onSelect])

  <CarouselContext
    value={{
      carouselRef,
      api: api,
      opts,
      orientation:
        orientation || (opts?.axis === "y" ? "vertical" : "horizontal"),
      scrollPrev,
      scrollNext,
      canScrollPrev,
      canScrollNext,
    }}
  >
    <div
      onKeyDownCapture={handleKeyDown}
      class={cn("relative", className, klass)}
      role="region"
      aria-roledescription="carousel"
      data-slot="carousel"
      {...props}
    >
      {children}
    </div>
  </CarouselContext>
}

function CarouselContent({ class: klass, className, ...props }: DivProps) @{
  const { carouselRef, orientation } = useCarousel()

  <div ref={carouselRef} class="overflow-hidden" data-slot="carousel-content">
    <div
      class={cn(
        "flex",
        orientation === "horizontal" ? "-ml-4" : "-mt-4 flex-col",
        className,
        klass,
      )}
      {...props}
    />
  </div>
}

function CarouselItem({ class: klass, className, ...props }: DivProps) @{
  const { orientation } = useCarousel()

  <div
    data-slot="carousel-item"
    role="group"
    aria-roledescription="slide"
    class={cn(
      "min-w-0 shrink-0 grow-0 basis-full",
      orientation === "horizontal" ? "pl-4" : "pt-4",
      className,
      klass,
    )}
    {...props}
  />
}

function CarouselPrevious({
  class: klass,
  className,
  variant = "noShadow",
  size = "icon",
  ...props
}: ButtonProps) @{
  const { orientation, scrollPrev, canScrollPrev } = useCarousel()

  <Button
    data-slot="carousel-previous"
    variant={variant}
    size={size}
    class={cn(
      "absolute size-8 rounded-base",
      orientation === "horizontal"
        ? "top-1/2 -left-12 -translate-y-1/2"
        : "-top-12 left-1/2 -translate-x-1/2 rotate-90",
      className,
      klass,
    )}
    disabled={!canScrollPrev}
    onClick={scrollPrev}
    {...props}
  >
    <ArrowLeft />
    <span class="sr-only">Previous slide</span>
  </Button>
}

function CarouselNext({
  class: klass,
  className,
  variant = "noShadow",
  size = "icon",
  ...props
}: ButtonProps) @{
  const { orientation, scrollNext, canScrollNext } = useCarousel()

  <Button
    data-slot="carousel-next"
    variant={variant}
    size={size}
    class={cn(
      "absolute h-8 w-8 rounded-base",
      orientation === "horizontal"
        ? "-right-12 top-1/2 -translate-y-1/2"
        : "-bottom-12 left-1/2 -translate-x-1/2 rotate-90",
      className,
      klass,
    )}
    disabled={!canScrollNext}
    onClick={scrollNext}
    {...props}
  >
    <ArrowRight />
    <span class="sr-only">Next slide</span>
  </Button>
}

export {
  Carousel,
  CarouselContent,
  CarouselItem,
  CarouselPrevious,
  CarouselNext,
}
