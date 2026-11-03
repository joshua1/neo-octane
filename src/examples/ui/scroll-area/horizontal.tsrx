import { ScrollArea, ScrollBar } from "@/components/ui/scroll-area.tsrx"

export interface Artwork {
  artist: string
  art: string
}

export const works: Artwork[] = [
  {
    artist: "Ornella Binni",
    art: "https://images.unsplash.com/photo-1465869185982-5a1a7522cbcb?auto=format&fit=crop&w=300&q=80",
  },
  {
    artist: "Tom Byrom",
    art: "https://images.unsplash.com/photo-1548516173-3cabfa4607e9?auto=format&fit=crop&w=300&q=80",
  },
  {
    artist: "Vladimir Malyavko",
    art: "https://images.unsplash.com/photo-1494337480532-3725c85fd2ab?auto=format&fit=crop&w=300&q=80",
  },
]

export default function ScrollAreaHorizontalDemo() @{
  <ScrollArea class="w-96 rounded-base border-2 border-border bg-background shadow-shadow whitespace-nowrap">
    <div class="flex w-max space-x-4 p-4">
      @for (const artwork of works; key artwork.artist) {
        <figure class="shrink-0">
          <div class="overflow-hidden rounded-base border-2 border-border">
            <img
              src={artwork.art}
              alt={`Photo by ${artwork.artist}`}
              class="aspect-[3/4] h-fit w-fit object-cover"
              width={300}
              height={400}
            />
          </div>
          <figcaption class="pt-2 text-xs font-base text-foreground">
            Photo by{" "}
            <span class="font-heading text-foreground">
              {artwork.artist as string}
            </span>
          </figcaption>
        </figure>
      }
    </div>
    <ScrollBar orientation="horizontal" />
  </ScrollArea>
}
