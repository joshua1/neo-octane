/**
 * Octane message-scroller primitive — public entry.
 * Derived from shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c (message-scroller).
 * License: MIT, (c) 2023 shadcn — see ../LICENSE.upstream.md.
 */
import {
  MessageScrollerButton as Button,
  MessageScrollerContent as Content,
  MessageScrollerItem as Item,
  MessageScrollerProvider as Provider,
  MessageScroller as Root,
  MessageScrollerViewport as Viewport,
} from "./components.tsrx"

export const MessageScroller = {
  Provider,
  Root,
  Viewport,
  Content,
  Item,
  Button,
}

export {
  useMessageScroller,
  useMessageScrollerScrollable,
  useMessageScrollerVisibility,
} from "./components.tsrx"

export type {
  MessageScrollerDefaultScrollPosition,
  MessageScrollerScrollAlign,
  MessageScrollerScrollOptions,
  MessageScrollerScrollable,
  MessageScrollerVisibilityState,
} from "./types"
