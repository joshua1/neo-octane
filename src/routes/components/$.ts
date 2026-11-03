import { createFileRoute, redirect } from "@octanejs/tanstack-router"

// next.config.mjs: /components/:slug* -> /docs/:slug* (permanent).
export const Route = createFileRoute("/components/$")({
  beforeLoad: ({ params }) => {
    const slug = params._splat ?? ""
    throw redirect(
      slug
        ? { to: "/docs/$", params: { _splat: slug }, statusCode: 301 }
        : { to: "/docs", statusCode: 301 },
    )
  },
})
