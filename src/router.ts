import { createRouter as createTanStackRouter } from "@octanejs/tanstack-router"

import { routeTree } from "./routeTree.gen"

export const getRouter = () => {
  return createTanStackRouter({
    routeTree,
    scrollRestoration: true,
    defaultPreload: "intent",
    defaultPreloadStaleTime: 0,
  })
}

declare module "@octanejs/tanstack-router" {
  interface Register {
    router: ReturnType<typeof getRouter>
  }
}
