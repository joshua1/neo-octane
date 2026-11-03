import {
  Body,
  createRootRoute,
  Head,
  HeadContent,
  Html,
  Outlet,
  Scripts,
} from "@octanejs/tanstack-router"
import type { OctaneNode } from "octane"

import Navbar from "@/components/app/navbar.tsrx"
import NotFound from "@/components/app/not-found.tsrx"
import ScrollToTop from "@/components/app/scroll-to-top.tsrx"
import SetStylingPref from "@/components/app/set-styling-pref.tsrx"

import { getStarsCount } from "@/lib/github"

import appCss from "@/styling/globals.css?url"

// Next's `metadata` export. The title template ("%s - Neobrutalism
// components") is applied by each route's own head().
const DESCRIPTION =
  "A collection of neobrutalism-styled components based on shadcn/ui."
const PREVIEW_IMAGE = "https://www.neobrutalism.dev/preview.png"

export const Route = createRootRoute({
  head: () => ({
    meta: [
      { charSet: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      {
        title:
          "Neobrutalism components - Start making neobrutalism layouts today",
      },
      { name: "description", content: DESCRIPTION },
      {
        name: "keywords",
        content: [
          "neobrutalism",
          "neobrutalism components",
          "neobrutalism tailwind",
          "octane neobrutalism",
          "octane tailwind components",
          "shadcn components",
          "shadcn neobrutalism",
        ].join(","),
      },
      { name: "author", content: "Samuel Breznjak" },
      { property: "og:type", content: "website" },
      { property: "og:title", content: "Neobrutalism components" },
      { property: "og:description", content: DESCRIPTION },
      { property: "og:url", content: "https://www.neobrutalism.dev/" },
      { property: "og:image", content: PREVIEW_IMAGE },
      { name: "twitter:card", content: "summary_large_image" },
      {
        name: "twitter:title",
        content: "Neobrutalism components - Start making neobrutalism layouts",
      },
      { name: "twitter:description", content: DESCRIPTION },
      { name: "twitter:image", content: PREVIEW_IMAGE },
      { name: "twitter:creator", content: "@samuelbreznjak" },
    ],
    links: [
      { rel: "icon", href: "/favicon.ico" },
      { rel: "author", href: "https://github.com/ekmas" },
      { rel: "preconnect", href: "https://fonts.googleapis.com" },
      { rel: "preconnect", href: "https://fonts.gstatic.com", crossOrigin: "" },
      {
        rel: "stylesheet",
        href: "https://fonts.googleapis.com/css2?family=DM+Sans:ital,opsz,wght@0,9..40,100..1000;1,9..40,100..1000&display=swap",
      },
      { rel: "stylesheet", href: appCss },
    ],
  }),
  // GitHub stars for the navbar; fetched once per session, not per navigation.
  loader: async () => ({ starsCount: await getStarsCount() }),
  staleTime: Infinity,
  shellComponent: RootDocument,
  component: RootLayout,
  notFoundComponent: NotFound,
})

function RootLayout() @{
  const { starsCount } = Route.useLoaderData()

  <>
    <Navbar starsCount={starsCount} />
    <Outlet />
    <SetStylingPref />
    <ScrollToTop />
  </>
}

function RootDocument({ children }: { children?: OctaneNode }) @{
  <Html lang="en" class="scroll-smooth">
    <Head>
      <HeadContent />
    </Head>
    <Body class="isolate">
      {children}
      <Scripts />
    </Body>
  </Html>
}
