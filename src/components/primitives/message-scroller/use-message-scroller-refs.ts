/**
 * Octane message-scroller primitive (use-message-scroller-refs).
 * Derived from shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c (message-scroller).
 * License: MIT, (c) 2023 shadcn — see ../LICENSE.upstream.md.
 */
import * as Octane from "octane"

import {
  areScrollStatesEqual,
  createMessageScrollerStore,
  createMessageScrollerVisibilityStore,
} from "./stores"
import { EMPTY_MESSAGE_SCROLLER_SCROLLABLE } from "./types"
import type {
  MessageScrollerDefaultScrollPosition,
  MessageScrollerMode,
  MessageScrollerScrollable,
  MessageScrollerScrollOptions,
  MessageScrollerStore,
  MessageScrollerVisibilityStore,
} from "./types"

// Shared mutable ref bag for one MessageScroller, closed over by both the
// controller and the commands so writes are visible across them without prop
// threading. stateStore and visibilityStore fan out via useSyncExternalStore.
type MessageScrollerRefs = {
  autoScrollRef: Octane.RefObject<boolean>
  autoscrollingRef: Octane.RefObject<boolean>
  autoscrollingTimeoutRef: Octane.RefObject<number | null>
  streamingTurnRef: Octane.RefObject<HTMLElement | null>
  contentRef: Octane.RefObject<HTMLDivElement | null>
  defaultScrollPositionAppliedRef: Octane.RefObject<boolean>
  firstItemRef: Octane.RefObject<HTMLElement | null>
  itemCountRef: Octane.RefObject<number>
  lastScrollTopRef: Octane.RefObject<number>
  messageElementsRef: Octane.RefObject<Map<string, HTMLElement>>
  modeRef: Octane.RefObject<MessageScrollerMode>
  pendingScrollFrameRef: Octane.RefObject<number | null>
  pendingScrollToMessageRef: Octane.RefObject<{
    messageId: string
    options?: MessageScrollerScrollOptions
  } | null>
  prependRestoreRef: Octane.RefObject<{
    element: HTMLElement
    viewportTop: number
  } | null>
  preserveScrollOnPrependRef: Octane.RefObject<boolean>
  pendingDefaultScrollStore: MessageScrollerStore<boolean>
  rootRef: Octane.RefObject<HTMLDivElement | null>
  scrollEdgeThresholdRef: Octane.RefObject<number>
  scrollMarginRef: Octane.RefObject<number>
  scrollPreviousItemPeekRef: Octane.RefObject<number>
  spacerGapRef: Octane.RefObject<number>
  spacerHeightRef: Octane.RefObject<number>
  spacerRef: Octane.RefObject<HTMLDivElement | null>
  stateFrameRef: Octane.RefObject<number | null>
  stateStore: MessageScrollerStore<MessageScrollerScrollable>
  viewportRef: Octane.RefObject<HTMLDivElement | null>
  visibilityFrameRef: Octane.RefObject<number | null>
  visibilityObserverRef: Octane.RefObject<IntersectionObserver | null>
  visibilityStore: MessageScrollerVisibilityStore
  visibleMessageIdsRef: Octane.RefObject<Set<string>>
  handledScrollAnchorsRef: Octane.RefObject<WeakSet<HTMLElement>>
}

// Builds the per-instance ref bag: the two external stores constructed once, and
// the latest prop values mirrored onto refs each render so callbacks stay stable.
function useMessageScrollerRefs({
  autoScroll,
  defaultScrollPosition,
  scrollEdgeThreshold,
  scrollMargin,
  scrollPreviousItemPeek,
}: {
  autoScroll: boolean
  defaultScrollPosition: MessageScrollerDefaultScrollPosition
  scrollEdgeThreshold: number
  scrollMargin: number
  scrollPreviousItemPeek: number
}): MessageScrollerRefs {
  const autoScrollRef = Octane.useRef(autoScroll)
  const autoscrollingRef = Octane.useRef(false)
  const contentRef = Octane.useRef<HTMLDivElement | null>(null)
  const defaultScrollPositionAppliedRef = Octane.useRef(false)
  const scrollEdgeThresholdRef = Octane.useRef(scrollEdgeThreshold)
  const itemCountRef = Octane.useRef(0)
  const firstItemRef = Octane.useRef<HTMLElement | null>(null)
  // The scrollTop seen by the previous state commit, so follow-release can tell
  // a reader scrolling up from content growing past the live edge.
  const lastScrollTopRef = Octane.useRef(0)
  const modeRef = Octane.useRef<MessageScrollerMode>(
    autoScroll ? "following-bottom" : "free-scrolling",
  )
  const messageElementsRef = Octane.useRef(new Map<string, HTMLElement>())
  const pendingScrollToMessageRef = Octane.useRef<{
    messageId: string
    options?: MessageScrollerScrollOptions
  } | null>(null)
  // The row to hold steady on the next prepend: the first visible row, or a jump
  // target seeded by scrollToElement. restorePrependedAnchor reads only this.
  const prependRestoreRef = Octane.useRef<{
    element: HTMLElement
    viewportTop: number
  } | null>(null)
  // The turn held at the reading line so a reply streaming in below it can re-pin
  // it instead of letting scrollTop clamp it loose.
  const streamingTurnRef = Octane.useRef<HTMLElement | null>(null)
  const scrollPreviousItemPeekRef = Octane.useRef(scrollPreviousItemPeek)
  const preserveScrollOnPrependRef = Octane.useRef(true)
  const rootRef = Octane.useRef<HTMLDivElement | null>(null)
  const scrollMarginRef = Octane.useRef(scrollMargin)
  const pendingScrollFrameRef = Octane.useRef<number | null>(null)
  const spacerGapRef = Octane.useRef(0)
  const spacerHeightRef = Octane.useRef(0)
  const spacerRef = Octane.useRef<HTMLDivElement | null>(null)
  const stateFrameRef = Octane.useRef<number | null>(null)
  const pendingDefaultScrollStoreRef =
    Octane.useRef<MessageScrollerStore<boolean> | null>(null)
  const stateStoreRef =
    Octane.useRef<MessageScrollerStore<MessageScrollerScrollable> | null>(null)
  const autoscrollingTimeoutRef = Octane.useRef<number | null>(null)
  const viewportRef = Octane.useRef<HTMLDivElement | null>(null)
  const visibilityFrameRef = Octane.useRef<number | null>(null)
  const visibilityObserverRef = Octane.useRef<IntersectionObserver | null>(null)
  const visibilityStoreRef =
    Octane.useRef<MessageScrollerVisibilityStore | null>(null)
  const visibleMessageIdsRef = Octane.useRef(new Set<string>())
  const handledScrollAnchorsRef = Octane.useRef(new WeakSet<HTMLElement>())

  if (pendingDefaultScrollStoreRef.current === null) {
    pendingDefaultScrollStoreRef.current = createMessageScrollerStore(
      defaultScrollPosition === "end" ||
        defaultScrollPosition === "last-anchor",
      (current, next) => current === next,
    )
  }

  if (stateStoreRef.current === null) {
    stateStoreRef.current = createMessageScrollerStore(
      EMPTY_MESSAGE_SCROLLER_SCROLLABLE,
      areScrollStatesEqual,
    )
  }

  if (visibilityStoreRef.current === null) {
    visibilityStoreRef.current = createMessageScrollerVisibilityStore()
  }

  // Track the latest prop values on every render so callbacks read fresh values
  // without being recreated (the useLatest pattern).
  autoScrollRef.current = autoScroll
  scrollEdgeThresholdRef.current = scrollEdgeThreshold
  scrollMarginRef.current = scrollMargin
  scrollPreviousItemPeekRef.current = scrollPreviousItemPeek

  return {
    autoScrollRef,
    autoscrollingRef,
    autoscrollingTimeoutRef,
    streamingTurnRef,
    contentRef,
    defaultScrollPositionAppliedRef,
    firstItemRef,
    itemCountRef,
    lastScrollTopRef,
    messageElementsRef,
    modeRef,
    pendingScrollFrameRef,
    pendingScrollToMessageRef,
    prependRestoreRef,
    preserveScrollOnPrependRef,
    pendingDefaultScrollStore: pendingDefaultScrollStoreRef.current,
    rootRef,
    scrollEdgeThresholdRef,
    scrollMarginRef,
    scrollPreviousItemPeekRef,
    spacerGapRef,
    spacerHeightRef,
    spacerRef,
    stateFrameRef,
    stateStore: stateStoreRef.current,
    viewportRef,
    visibilityFrameRef,
    visibilityObserverRef,
    visibilityStore: visibilityStoreRef.current,
    visibleMessageIdsRef,
    handledScrollAnchorsRef,
  }
}

function clearPendingDefaultScroll(refs: MessageScrollerRefs) {
  refs.pendingDefaultScrollStore.setSnapshot(false)
}

function markDefaultScrollPositionApplied(refs: MessageScrollerRefs) {
  refs.defaultScrollPositionAppliedRef.current = true
  clearPendingDefaultScroll(refs)
}

export {
  clearPendingDefaultScroll,
  markDefaultScrollPositionApplied,
  useMessageScrollerRefs,
}
export type { MessageScrollerRefs }
