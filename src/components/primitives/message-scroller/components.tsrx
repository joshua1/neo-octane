/**
 * Octane message-scroller primitive (components).
 * Derived from shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c (message-scroller).
 * License: MIT, (c) 2023 shadcn — see ../LICENSE.upstream.md.
 * Notes:
 * - Contexts render as `<Context value>` (no `.Provider`).
 * - Event handler types are native DOM events (Octane has no synthetic layer).
 */
import * as Octane from "octane"

import { composeRefs, mergeProps, useRender } from "../use-render"
import { USER_SCROLL_KEYS } from "./types"
import type {
  MessageScrollerButtonProps,
  MessageScrollerContentProps,
  MessageScrollerContextValue,
  MessageScrollerItemProps,
  MessageScrollerProps,
  MessageScrollerProviderProps,
  MessageScrollerRegisterMessage,
  MessageScrollerViewportProps,
} from "./types"
import { useMessageScrollerController } from "./use-message-scroller-controller"
import { useLatest } from "./utils"

const MessageScrollerContext =
  Octane.createContext<MessageScrollerContextValue | null>(null)
const MessageScrollerItemContext =
  Octane.createContext<MessageScrollerRegisterMessage | null>(null)

function useMessageScrollerContext() {
  const context = Octane.useContext(MessageScrollerContext)

  if (!context) {
    throw new Error("useMessageScroller must be used within a MessageScroller.")
  }

  return context
}

function useMessageScrollerItemContext() {
  const context = Octane.useContext(MessageScrollerItemContext)

  if (!context) {
    throw new Error(
      "MessageScrollerItem must be used within a MessageScroller.",
    )
  }

  return context
}

function useMessageScroller() {
  const { scrollToEnd, scrollToMessage, scrollToStart } =
    useMessageScrollerContext()

  return Octane.useMemo(
    () => ({
      scrollToEnd,
      scrollToMessage,
      scrollToStart,
    }),
    [scrollToEnd, scrollToMessage, scrollToStart],
  )
}

function useMessageScrollerScrollable() {
  const { stateStore } = useMessageScrollerContext()

  return Octane.useSyncExternalStore(
    stateStore.subscribe,
    stateStore.getSnapshot,
    stateStore.getSnapshot,
  )
}

function useMessageScrollerVisibility() {
  const { observeVisibility, unobserveVisibility, visibilityStore } =
    useMessageScrollerContext()
  const subscribe = Octane.useCallback(
    (listener: () => void) =>
      visibilityStore.subscribe(
        listener,
        observeVisibility,
        unobserveVisibility,
      ),
    [observeVisibility, unobserveVisibility, visibilityStore],
  )

  return Octane.useSyncExternalStore(
    subscribe,
    visibilityStore.getSnapshot,
    visibilityStore.getSnapshot,
  )
}

function MessageScrollerProvider({
  autoScroll = false,
  children,
  defaultScrollPosition = "end",
  scrollEdgeThreshold,
  scrollPreviousItemPeek,
  scrollMargin,
}: MessageScrollerProviderProps) @{
  const { context, registerMessage } = useMessageScrollerController({
    autoScroll,
    defaultScrollPosition,
    scrollEdgeThreshold,
    scrollPreviousItemPeek,
    scrollMargin,
  })

  <MessageScrollerContext value={context}>
    <MessageScrollerItemContext value={registerMessage}>
      {children}
    </MessageScrollerItemContext>
  </MessageScrollerContext>
}

function usePendingDefaultScroll() {
  const { pendingDefaultScrollStore } = useMessageScrollerContext()

  return Octane.useSyncExternalStore(
    pendingDefaultScrollStore.subscribe,
    pendingDefaultScrollStore.getSnapshot,
    pendingDefaultScrollStore.getSnapshot,
  )
}

function MessageScroller({ children, ...props }: MessageScrollerProps) @{
  const { setRootElement } = useMessageScrollerContext()
  const pendingDefaultScroll = usePendingDefaultScroll()

  <div
    ref={setRootElement}
    {...props}
    {...(pendingDefaultScroll ? { "data-pending-scroll": "" } : null)}
  >
    {children}
  </div>
}

function MessageScrollerViewport({
  "aria-label": ariaLabel,
  children,
  onKeyDown,
  onScroll,
  onTouchMove,
  onWheel,
  preserveScrollOnPrepend = true,
  ref,
  role,
  tabIndex,
  ...props
}: MessageScrollerViewportProps) @{
  const {
    handleResize,
    preserveScrollOnPrependRef,
    setViewportElement,
    syncAfterScroll,
    userScrollIntent,
    viewportRef,
  } = useMessageScrollerContext()
  const pendingDefaultScroll = usePendingDefaultScroll()

  preserveScrollOnPrependRef.current = preserveScrollOnPrepend

  const setViewportRef = Octane.useCallback(
    (element: HTMLDivElement | null) => {
      setViewportElement(element)
      composeRefs(ref)?.(element)
    },
    [ref, setViewportElement],
  )

  function handleScroll(event: Octane.UIEvent<HTMLDivElement>) {
    syncAfterScroll()
    onScroll?.(event)
  }

  function handleWheel(event: Octane.WheelEvent<HTMLDivElement>) {
    userScrollIntent()
    onWheel?.(event)
  }

  function handleTouchMove(event: Octane.TouchEvent<HTMLDivElement>) {
    userScrollIntent()
    onTouchMove?.(event)
  }

  function handleKeyDown(event: Octane.KeyboardEvent<HTMLDivElement>) {
    if (USER_SCROLL_KEYS.has(event.key)) {
      userScrollIntent()
    }

    onKeyDown?.(event)
  }

  Octane.useEffect(() => {
    const viewport = viewportRef.current

    if (!viewport || typeof ResizeObserver === "undefined") {
      return
    }

    // Coalesce into rAF: handleResize mutates the spacer inside the observed
    // content, and resizing an observed element during delivery fires
    // "ResizeObserver loop completed with undelivered notifications".
    let frame = 0

    const observer = new ResizeObserver(() => {
      window.cancelAnimationFrame(frame)
      frame = window.requestAnimationFrame(handleResize)
    })

    observer.observe(viewport)

    return () => {
      window.cancelAnimationFrame(frame)
      observer.disconnect()
    }
  }, [handleResize, viewportRef])

  <div
    ref={setViewportRef}
    role={role ?? "region"}
    aria-label={ariaLabel ?? "Messages"}
    tabIndex={tabIndex ?? 0}
    onKeyDown={handleKeyDown}
    onScroll={handleScroll}
    onTouchMove={handleTouchMove}
    onWheel={handleWheel}
    {...props}
    {...(pendingDefaultScroll ? { "data-pending-scroll": "" } : null)}
  >
    {children}
  </div>
}

function MessageScrollerContent({
  "aria-relevant": ariaRelevant,
  children,
  ref,
  role,
  spacerClassName,
  ...props
}: MessageScrollerContentProps) @{
  const {
    handleContentChange,
    handleResize,
    setContentElement,
    setSpacerElement,
  } = useMessageScrollerContext()
  const contentRef = Octane.useRef<HTMLDivElement | null>(null)

  const setContentRef = Octane.useCallback(
    (element: HTMLDivElement | null) => {
      contentRef.current = element
      setContentElement(element)
      composeRefs(ref)?.(element)
    },
    [ref, setContentElement],
  )

  Octane.useLayoutEffect(() => {
    const content = contentRef.current

    if (!content) {
      return
    }

    handleContentChange()

    if (typeof MutationObserver === "undefined") {
      return
    }

    const observer = new MutationObserver(() => {
      handleContentChange()
    })

    observer.observe(content, { childList: true })

    return () => observer.disconnect()
  }, [handleContentChange])

  Octane.useEffect(() => {
    const content = contentRef.current

    if (!content || typeof ResizeObserver === "undefined") {
      return
    }

    // Coalesce into rAF: handleResize mutates the spacer inside this observed
    // element, and resizing an observed element during delivery fires
    // "ResizeObserver loop completed with undelivered notifications".
    let frame = 0

    const observer = new ResizeObserver(() => {
      window.cancelAnimationFrame(frame)
      frame = window.requestAnimationFrame(handleResize)
    })

    observer.observe(content)

    return () => {
      window.cancelAnimationFrame(frame)
      observer.disconnect()
    }
  }, [handleResize])

  <div
    ref={setContentRef}
    role={role ?? "log"}
    aria-relevant={ariaRelevant ?? "additions"}
    {...props}
  >
    {children}
    <div
      ref={setSpacerElement}
      aria-hidden="true"
      data-message-scroller-spacer=""
      hidden
      class={spacerClassName}
    />
  </div>
}

function MessageScrollerItem({
  messageId,
  ref,
  scrollAnchor = false,
  ...props
}: MessageScrollerItemProps) @{
  const registerMessage = useMessageScrollerItemContext()
  const elementRef = Octane.useRef<HTMLDivElement | null>(null)

  const setItemRef = Octane.useCallback(
    (element: HTMLDivElement | null) => {
      const previousElement = elementRef.current

      elementRef.current = element

      if (messageId) {
        registerMessage(messageId, element, previousElement)
      }

      composeRefs(ref)?.(element)
    },
    [messageId, ref, registerMessage],
  )

  <div
    ref={setItemRef}
    data-message-id={messageId}
    data-scroll-anchor={scrollAnchor ? "true" : "false"}
    {...props}
  />
}

function MessageScrollerButton({
  behavior = "smooth",
  children,
  direction = "end",
  onClick,
  render,
  tabIndex,
  type = "button",
  ...props
}: MessageScrollerButtonProps) {
  const { scrollToEnd, scrollToStart, stateStore } = useMessageScrollerContext()
  const onClickRef = useLatest(onClick)
  const subscribe = Octane.useCallback(
    (listener: () => void) => stateStore.subscribe(listener),
    [stateStore],
  )
  const getSnapshot = Octane.useCallback(() => {
    const state = stateStore.getSnapshot()

    return direction === "start" ? state.start : state.end
  }, [direction, stateStore])
  const isActive = Octane.useSyncExternalStore(
    subscribe,
    getSnapshot,
    getSnapshot,
  )

  const handleClick = Octane.useCallback(
    (event: Octane.MouseEvent<HTMLButtonElement>) => {
      if (!isActive) {
        return
      }

      onClickRef.current?.(event)

      if (!event.defaultPrevented) {
        event.currentTarget.blur()

        if (direction === "start") {
          scrollToStart({ behavior })
        } else {
          scrollToEnd({ behavior })
        }
      }
    },
    [behavior, direction, isActive, onClickRef, scrollToEnd, scrollToStart],
  )

  return useRender({
    defaultTagName: "button",
    props: mergeProps<"button">(
      {
        type,
        inert: !isActive,
        tabIndex: isActive ? tabIndex : -1,
        children: children ?? <span>{"Scroll to " + direction}</span>,
        onClick: handleClick,
      },
      props,
    ),
    render,
    state: {
      active: isActive,
      direction,
    },
    stateAttributesMapping: {
      active: (value: boolean) => ({
        "data-active": value ? "true" : "false",
      }),
    },
  })
}

export {
  MessageScroller,
  MessageScrollerButton,
  MessageScrollerContent,
  MessageScrollerItem,
  MessageScrollerProvider,
  MessageScrollerViewport,
  useMessageScroller,
  useMessageScrollerScrollable,
  useMessageScrollerVisibility,
}
