import { createStart } from "@octanejs/tanstack-start"

export const startInstance = createStart(() => ({
  defaultSsr: true,
}))
