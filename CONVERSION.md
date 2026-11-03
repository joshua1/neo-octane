# Octane authoring guide (neo-octane)

`neo-octane/` is the neobrutalism components site built with Octane and
TanStack Start. Components, examples and pages are `.tsrx` files under
`neo-octane/src`; plain `.ts` files that contain no JSX stay `.ts`.

Octane repo (source of truth): `../../octane-core`

Required reading before writing `.tsrx`:

- `../../octane-core/.rulesync/rules/tsrx-authoring.md` — full `.tsrx` reference
- `../../octane-core/CLAUDE.md` — Octane authoring rules and common mistakes

House-style references (shadcn **base-ui** components in Octane, the closest
relatives of these neobrutalism components):
`../../octane-core/packages/shadcn/src/bases/base-ui/ui/*.tsrx`.
Use them for *structure and API shape* only. **Keep the neobrutalism class
strings, markup and behavior** — these components are not restyled shadcn.

## Packages

Use these Octane packages:

| Need | Package |
| --- | --- |
| Hooks, context, portals (`useState`, `useEffect`, `createContext`, `createPortal`, …) | `octane` |
| Base UI primitives | `@octanejs/base-ui/<part>` (subpaths incl. `use-render`, `merge-props`, `drawer`, `toast`, `combobox`, `direction-provider`) |
| Icons | `@octanejs/lucide` (`LucideIcon`/`LucideProps` types) |
| Charts | `@octanejs/recharts` |
| Command menu | `@octanejs/cmdk` |
| Carousel | `@octanejs/embla-carousel` |
| OTP input | `@octanejs/input-otp` |
| Calendar / date picker | `@octanejs/day-picker` |
| Forms | `@octanejs/hook-form` |
| Form validation | `@/lib/arktype-resolver` (local; schemas use ArkType: `arktypeResolver(schema)`) |
| Resizable panels | `@octanejs/resizable-panels` |
| Data table | `@octanejs/tanstack-table` |
| Questionnaire, message scroller | local ports in `@/components/primitives/*.tsrx` |
| Marquee | local port `@/components/primitives/marquee.tsrx` |
| Routing (`Link`, `useLocation`, `useNavigate`, `notFound`) | `@octanejs/tanstack-router`; use plain `<a>` for external/hash links and plain `<img>` for images |
| `class-variance-authority`, `clsx`, `tailwind-merge`, `date-fns` | used as-is (framework-neutral) |

If a binding is missing an export you need, check its source under
`node_modules/@octanejs/<pkg>/src` before inventing a workaround. Only add
framework-neutral packages or `@octanejs/*` bindings.

## Syntax rules

- Components use the `@{ … }` form: `function Button(props: Props) @{ <button … /> }`.
  Setup statements (hooks, locals) go before the single output node.
  `export default function X() @{ … }` and `export { A, B }` both work.
- **Imports of `.tsrx` modules carry the extension**:
  `import { Button } from "@/components/ui/button.tsrx"`. `.ts` imports stay
  extensionless. Keep the `@/` alias. Import a *directory* module by its
  index file: `@/examples/ui/accordion/index.tsrx`.
- Template control flow uses directives, not `&&`/ternaries/`.map` returning JSX:
  - `{cond && <X/>}` → `@if (cond) { <X/> }`
  - `{a ? <X/> : <Y/>}` → `@if (a) { <X/> } @else { <Y/> }`
  - `{items.map((i) => <Li key={i.id} …/>)}` → `@for (const i of items; key i.id) { <Li …/> }`
    With an index: `@for (const item of items; index i; key item.id)`.
    `.map(...)` returning JSX still compiles, but prefer `@for`.
  A ternary that picks a *value* (class name, string) is fine as an expression.
- **Text holes**: a dynamic value rendered as text needs proof it is a string:
  `{label as string}`, `{String(count)}`, `{"Total: " + n}`. Bare `{expr}` is a
  renderable hole (component / element / node) — correct for `children`/`OctaneNode`.
- Hooks are keyed by call site; never call a hook inside a plain JS loop (use
  `@for` or a child component). Hooks behind a condition are allowed.
- `useState`/`useReducer` return `[state, set, getState]`; destructuring two is fine.
- No `forwardRef`; `ref` is an ordinary prop (`ref={cb}`, `ref={obj}`, `ref={[a, b]}`).
  Create refs with `useRef<T | null>(null)` from `octane`.
- Events are **native and delegated**. Text inputs/textareas use `onInput` for
  per-keystroke updates, reading `(e.currentTarget as HTMLInputElement).value`. Keep `onChange` on
  checkboxes/radios/selects and keep library callbacks (`onValueChange`,
  `onCheckedChange`, `onOpenChange`, `onSelect`, hook-form `field.onChange`)
  unchanged. Event types are DOM types (`MouseEvent`, `KeyboardEvent`,
  `InputEvent`, …).
- Use `class` (and `for`, not `htmlFor`) — never `className` on DOM elements or
  on our own components. Every `components/ui` component takes a `class` prop
  (`ClassProps` from `@/lib/utils`) and destructures `class: klass, className`,
  folding both in with `cn(styles, className, klass)`: on a DOM element `class`
  and `className` share one slot and the last one wins, and base-ui hands a
  `className` to the element passed as `render={<Button />}`. `className=` stays
  only where a binding's own API consumes it: base-ui primitives
  (`<DialogPrimitive.Popup className=…>`), recharts elements, and similar.
- `style={{ "--x": value }}` works for CSS custom properties.
- Do not add `"use client"` / `"use server"` directives.
- Element-as-prop (`render={<Button variant="neutral" />}`, `icon={<X/>}`)
  works.
- Any JSX `<style>` in `.tsrx` is a compiler-scoped style block (only `ref`/`apply` attrs). For runtime CSS text use `createElement("style", { dangerouslySetInnerHTML: { __html: css } })` from `octane`.
- `mergeProps(...)`/`useRender` typings in `@octanejs/base-ui` don't line up; cast `props: mergeProps(...) as Record<string, unknown>` and `render: render as any` with a short comment.
- Slot-like components that inspect `children` with `isValidElement`/clone them need their children as element descriptors: export them wrapped in `descriptorChildren(Impl)` from `octane` (see `src/components/ui/form.tsrx` `FormControl`).
- `@octanejs/hook-form` `field` objects expose `onInput` (not `onChange`) for text inputs; `<Input {...field} />` just works.
- **Render callbacks that a library calls as a plain function** (hook-form `FormField`/`Controller` `render`, recharts `formatter`/`content`/`label`) must return a JSX *value*: `render={({ field }) => <FormItem>…</FormItem>}`. Do **not** write `({ field }) => @{ … }` there: that compiles to a component body that needs the renderer's scope, compiles and typechecks fine, then crashes on hydration with `Cannot read properties of undefined (reading 'block')`. Use `=> @{ … }` only for functions octane renders as components.
- **Compiler gap (octane 0.8.0):** JSX as a destructured-parameter default (`({ render = <Button/> }) => …`) is emitted untransformed and the module fails to parse. Default it in the body instead: `const render = renderProp ?? <Button/>`.
- There is no `Context.Provider`: render the context itself, `<MyContext value={v}>…</MyContext>`.
- `export { type Foo, Bar }` inline type specifiers can fail to parse in `.tsrx`; use `export type Foo = …` at the declaration.
- Fragments are `<>…</>` (a keyed fragment inside `@for` is unnecessary — the key is in the header).

## Types

- Renderable content (children, nodes, elements) is `OctaneNode` from `octane`.
- Props for a DOM-wrapping component: `Record<string, any> & { className?: string; children?: OctaneNode }`
  or a precise local interface. Props of a binding part: `Primitive.Part.Props`
  when the octane binding exports it, otherwise `Record<string, any>`. Keep
  props typed — `noImplicitAny` is on.
- SVG props: `Octane.SVGProps<SVGSVGElement>` (`import type { Octane } from "octane/jsx-runtime"`). camelCase SVG attrs (`strokeWidth`, `fillRule`) are accepted and mapped.
- Inline style objects: `Record<string, string | number>` (or the DOM
  `Partial<CSSStyleDeclaration>` if precision matters).
- Component types: `(props: P) => OctaneNode` (or `any` component type).

## Verification (required for every batch)

Typecheck only your own files with a throwaway tsconfig in the scratchpad
directory you were given (the full project typechecks slowly and other agents
are writing files concurrently):

```jsonc
// <scratchpad>/tsconfig.<batch>.json  (no baseUrl: it is a TS5101 error on TS 6)
{
  "extends": "<abs>/neo-octane/tsconfig.json",
  "compilerOptions": {
    "typeRoots": ["<abs>/neo-octane/node_modules", "<abs>/neo-octane/node_modules/@types"],
    "paths": { "@/*": ["<abs>/neo-octane/src/*"], "@public/*": ["<abs>/neo-octane/public/*"] }
  },
  "include": ["<abs>/neo-octane/src/<your files glob>"]
}
```

Run `<abs path>/neo-octane/node_modules/.bin/tsrx-tsc --noEmit -p <that tsconfig>`
from inside `neo-octane/`. Fix every error in your files.
`Cannot find module '@/components/ui/xyz.tsrx'` for a file another agent owns
(not yet written) is acceptable — keep import names identical to that
file's planned exports so they line up. Never silence errors with `declare module` or
`// @ts-nocheck`; a targeted `as any` with a short reason is acceptable at
genuine binding-typing gaps.
