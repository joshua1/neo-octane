/**
 * Octane message-scroller primitive (utils).
 * Derived from shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c (message-scroller).
 * License: MIT, (c) 2023 shadcn — see ../LICENSE.upstream.md.
 */
import * as Octane from "octane"

function useLatest<T>(value: T) {
  const ref = Octane.useRef(value)

  ref.current = value

  return ref
}

export { useLatest }
