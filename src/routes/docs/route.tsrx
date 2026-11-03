import { createFileRoute, Outlet } from "@octanejs/tanstack-router"

import Sidebar from "@/components/app/sidebar.tsrx"

import codeCss from "@/styling/code.css?url"

export const Route = createFileRoute("/docs")({
  head: () => ({
    links: [{ rel: "stylesheet", href: codeCss }],
  }),
  component: MainDocsLayout,
})

function MainDocsLayout() @{
  <>
    <Sidebar />
    <Outlet />
    <footer class="lg:ml-[250px] border-t-4 border-border bg-secondary-background text-center font-base sm:text-base text-sm text-foreground">
      <div class="xl:mr-[250px] px-5 py-6">
        Released under MIT License. Built by{" "}
        <a
          href="https://samuelbreznjak.com"
          target="_blank"
          rel="noreferrer"
          class="font-heading underline decoration-2 underline-offset-2"
        >
          Samuel
        </a>
      </div>
    </footer>
  </>
}
