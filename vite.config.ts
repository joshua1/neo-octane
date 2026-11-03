import { octaneMdx } from "@octanejs/mdx/vite"
import { tanstackStart } from "@octanejs/tanstack-start/plugin/vite"
import tailwindcss from "@tailwindcss/vite"
import { nitro } from "nitro/vite"
import { defineConfig } from "vite"

import { rehypePlugins, remarkPlugins } from "./mdx.config.ts"

export default defineConfig({
  resolve: {
    tsconfigPaths: true,
  },
  server: {
    port: 4300,
    allowedHosts: [
      "benjamin-initiated-entities-biotechnology.trycloudflare.com",
    ],
  },
  preview: {
    port: 4300,
  },
  optimizeDeps: {
    // @octanejs/* bindings ship source and are excluded from pre-bundling, so
    // their CommonJS dependencies must be pre-bundled explicitly or the
    // browser gets a CJS file with no default export.
    include: [
      "@octanejs/recharts > decimal.js-light",
      "@octanejs/recharts > eventemitter3",
    ],
  },
  build: {
    // Octane emits modern output; esnext avoids a redundant downlevel pass.
    target: "esnext",
    reportCompressedSize: false,
  },
  plugins: [
    // Claims .mdx/.md and emits final JS, so it composes with the octane
    // compiler that @octanejs/tanstack-start wires in for .tsrx/.tsx.
    octaneMdx({ remarkPlugins, rehypePlugins }),
    nitro(),
    tailwindcss(),
    // The Octane compiler handles JSX and .tsrx; no other JSX plugin is needed.
    tanstackStart(),
  ],
})
