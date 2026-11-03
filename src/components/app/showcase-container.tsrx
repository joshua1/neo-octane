import clsx from "clsx"

export type ShowcaseItem = {
  color: string
  text?: string
  liveUrl: string
  /** Public URL of the preview image (e.g. "/showcase-previews/x.webp"). */
  previewImg: string
  repoUrl?: string
  title: string
}

export default function ShowcaseContainer({
  items,
}: {
  items: ShowcaseItem[]
}) @{
  <div class="max-w-full grid sm:grid-cols-2 grid-cols-1 gap-5">
    @for (
      const { color, text, liveUrl, previewImg, repoUrl, title } of items;
      key title
    ) {
      <div class="p-[15px] bg-secondary-background rounded-base shadow-shadow border-2 border-border">
        <div class="border-2 border-border rounded-base aspect-2/1">
          <img class="rounded-base" src={previewImg} alt="preview image" />
        </div>

        <h4 class="text-center font-heading mt-4">{title as string}</h4>

        <div class="grid grid-cols-2 md:text-base text-sm gap-5 mt-8">
          <a
            style={{
              backgroundColor: color,
              color: text ? text : "black",
            }}
            class={clsx(
              "text-center border-2 py-1.5 font-base shadow-shadow hover:translate-x-boxShadowX hover:translate-y-boxShadowY hover:shadow-none transition-all border-border rounded-base",
              !repoUrl && "col-span-2",
            )}
            target="_blank"
            href={liveUrl}
          >
            Visit
          </a>
          @if (repoUrl) {
            <a
              style={{
                backgroundColor: color,
                color: text ? text : "black",
              }}
              class="text-center border-2 py-1.5 font-base shadow-shadow hover:translate-x-boxShadowX hover:translate-y-boxShadowY hover:shadow-none transition-all border-border rounded-base"
              target="_blank"
              href={repoUrl}
            >
              Github repo
            </a>
          }
        </div>
      </div>
    }
  </div>
}
