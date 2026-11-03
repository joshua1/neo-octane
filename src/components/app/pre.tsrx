import type { OctaneNode } from "octane"

import { cn, type ClassValue } from "@/lib/utils"

import { CopyButton } from "./copy-button.tsrx"

type PreProps = Record<string, any> & {
  children?: OctaneNode
  __rawstring__?: string
  /** Classes for the outer wrapper that carries the shadow. */
  wrapperClassName?: string
  /** Classes for the pre element itself. */
  class?: ClassValue
  className?: string
}

export function Pre(props: PreProps) @{
  const {
    children,
    __rawstring__ = "",
    wrapperClassName,
    class: klass,
    className,
  } = props

  <div
    data-slot="pre-wrapper"
    class={cn("relative shadow-shadow", wrapperClassName)}
  >
    <pre
      class={cn(
        "bg-black border-2 border-border code text-sm max-h-[300px] overflow-auto p-4 not-prose",
        className,
        klass,
      )}
    >
      <CopyButton text={__rawstring__} />
      {children}
    </pre>
  </div>
}
