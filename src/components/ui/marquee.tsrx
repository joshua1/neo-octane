export default function Marquee({ items }: { items: string[] }) @{
  <div class="relative flex w-full overflow-x-hidden border-b-2 border-t-2 border-border bg-secondary-background text-foreground font-base">
    <div class="animate-marquee whitespace-nowrap py-12">
      @for (const item of items; key item) {
        <span class="mx-4 text-4xl">{item as string}</span>
      }
    </div>

    <div class="absolute top-0 animate-marquee2 whitespace-nowrap py-12">
      @for (const item of items; key item) {
        <span class="mx-4 text-4xl">{item as string}</span>
      }
    </div>

    {/* must have both of these in order to work */}
  </div>
}
