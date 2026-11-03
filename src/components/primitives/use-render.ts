/**
 * Octane `useRender` helper: renders a default element or a caller-supplied
 * `render` element/function, merging props and composing refs.
 * Derived from shadcn's `use-render` helper (shadcn-ui/ui@295a1f114a138f23b5dfee0e0c6812394dfeb90c),
 * MIT, (c) 2023 shadcn; itself adapted from Base UI's `useRender`
 * (MIT, (c) MUI). See ./LICENSE.upstream.md.
 *
 * Notes:
 * - Built on Octane's `createElement`, `cloneElement` and `isValidElement`.
 * - `composeRefs` also flattens Octane array refs (`ref={[a, b]}`).
 * - Event types are native DOM events (Octane has no synthetic layer).
 */
import { cloneElement, createElement, isValidElement } from "octane"
import type * as Octane from "octane"

type RenderState = Record<string, unknown>

type RenderFunction<TState extends RenderState> = (
  props: Record<string, unknown>,
  state: TState,
) => Octane.ElementDescriptor | null

type RenderProp<TState extends RenderState> =
  Octane.ElementDescriptor | RenderFunction<TState>

type StateAttributesMapping<TState extends RenderState> = Partial<{
  [K in keyof TState]: (
    value: TState[K],
  ) => Record<string, string | undefined> | null | undefined
}>

type UseRenderComponentProps<
  TElement extends Octane.ElementType,
  TState extends RenderState = RenderState,
> = Octane.ComponentPropsWithRef<TElement> & {
  render?: RenderProp<TState>
}

type UseRenderOptions<
  TElement extends Octane.ElementType,
  TState extends RenderState,
> = {
  defaultTagName: TElement
  props?: Octane.ComponentPropsWithRef<TElement> | Record<string, unknown>
  render?: RenderProp<TState>
  state?: TState
  stateAttributesMapping?: StateAttributesMapping<TState>
}

type AnyRef<T> =
  | Octane.Ref<T>
  | readonly AnyRef<T>[]
  | ((value: T | null) => void)
  | null
  | undefined

function useRender<
  TElement extends Octane.ElementType,
  TState extends RenderState = RenderState,
>({
  defaultTagName,
  props,
  render,
  state = {} as TState,
  stateAttributesMapping,
}: UseRenderOptions<TElement, TState>): Octane.ElementDescriptor | null {
  const elementProps = mergeProps<TElement>(
    getStateAttributes(state, stateAttributesMapping),
    props,
  ) as Record<string, unknown>

  if (!render) {
    return createElement(defaultTagName as string, elementProps)
  }

  if (typeof render === "function") {
    return render(elementProps, state)
  }

  if (!isValidElement(render)) {
    return null
  }

  const renderProps = (render.props ?? {}) as Record<string, unknown>
  const propsWithRenderProps = mergeProps<TElement>(
    elementProps,
    renderProps,
  ) as Record<string, unknown>
  const propsWithRef = {
    ...propsWithRenderProps,
    ref: composeRefs(
      elementProps.ref as AnyRef<unknown>,
      renderProps.ref as AnyRef<unknown>,
    ),
  }

  return cloneElement(render, propsWithRef)
}

function mergeProps<TElement extends Octane.ElementType>(
  ...sources: Array<
    Octane.ComponentPropsWithRef<TElement> | Record<string, unknown> | undefined
  >
) {
  const result: Record<string, unknown> = {}

  for (const source of sources) {
    if (!source) {
      continue
    }

    const sourceProps = source as Record<string, unknown>

    for (const key of Object.keys(sourceProps)) {
      const value = sourceProps[key]

      if (value === undefined) {
        continue
      }

      const current = result[key]

      if (key === "className") {
        result[key] = [current, value].filter(Boolean).join(" ")
      } else if (key === "style") {
        result[key] = {
          ...(current as Octane.CSSProperties | undefined),
          ...(value as Octane.CSSProperties | undefined),
        }
      } else if (key === "ref") {
        result[key] = composeRefs(
          current as AnyRef<unknown>,
          value as AnyRef<unknown>,
        )
      } else if (
        isEventHandler(key) &&
        typeof current === "function" &&
        typeof value === "function"
      ) {
        result[key] = composeEventHandlers(
          value as EventHandler,
          current as EventHandler,
        )
      } else {
        result[key] = value
      }
    }
  }

  return result as Octane.ComponentPropsWithRef<TElement>
}

function getStateAttributes<TState extends RenderState>(
  state: TState,
  mapping?: StateAttributesMapping<TState>,
) {
  const props: Record<string, unknown> = {}

  for (const key of Object.keys(state) as Array<keyof TState>) {
    const value = state[key]
    const attributes = mapping?.[key]?.(value)

    if (attributes) {
      Object.assign(props, attributes)
      continue
    }

    if (key === "slot") {
      props["data-slot"] = value
      continue
    }

    const attribute = `data-${String(key).replace(
      /[A-Z]/g,
      (letter) => `-${letter.toLowerCase()}`,
    )}`

    if (typeof value === "boolean") {
      props[attribute] = value ? "" : undefined
    } else if (value !== null && value !== undefined) {
      props[attribute] = String(value)
    }
  }

  return props
}

type EventHandler = (event: Event) => void

function composeEventHandlers(theirs: EventHandler, ours: EventHandler) {
  return function handleEvent(event: Event) {
    theirs(event)

    if (!event.defaultPrevented) {
      ours(event)
    }
  }
}

function isEventHandler(key: string) {
  return /^on[A-Z]/.test(key)
}

function flattenRefs<T>(refs: ReadonlyArray<AnyRef<T>>): AnyRef<T>[] {
  const result: AnyRef<T>[] = []

  for (const ref of refs) {
    if (Array.isArray(ref)) {
      result.push(...flattenRefs<T>(ref as ReadonlyArray<AnyRef<T>>))
    } else if (ref) {
      result.push(ref)
    }
  }

  return result
}

function composeRefs<T>(
  ...refs: Array<AnyRef<T>>
): ((value: T | null) => void) | undefined {
  const validRefs = flattenRefs(refs)

  if (validRefs.length === 0) {
    return undefined
  }

  return (value) => {
    for (const ref of validRefs) {
      if (typeof ref === "function") {
        ;(ref as (value: T | null) => void)(value)
      } else if (ref) {
        ;(ref as { current: T | null }).current = value
      }
    }
  }
}

export {
  composeRefs,
  mergeProps,
  useRender,
  type AnyRef,
  type RenderProp,
  type UseRenderComponentProps,
}
