import type { ClassValue } from "clsx"
import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

type Props = {
  imageUrl: string
  caption: string
} & ClassProps

export default function ImageCard({
  imageUrl,
  caption,
  class: klass,
  className,
}: Props) @{
  <figure
    class={cn(
      "w-[250px] overflow-hidden rounded-base border-2 border-border bg-background font-base shadow-shadow",
      className,
      klass,
    )}
  >
    <img class="w-full aspect-4/3" src={imageUrl} alt="image" />
    <figcaption class="border-t-2 text-foreground border-border p-4">
      {caption as string}
    </figcaption>
  </figure>
}
