# Compiler leaves JSX untransformed in parameter default values

**Package:** `octane@0.8.0` (compiler, `octane/compiler`)
**Affects:** `.tsrx` and `.tsx`, client and server compile modes

## Summary

When JSX appears as the default value of a function parameter, the compiler
emits the JSX unchanged. The output module then contains raw `<Element />`
syntax, so the bundler fails to parse it and every route that imports the
module returns a 500.

## Minimal reproduction

```tsx
// slot.tsrx
function Fallback() @{ <span>fallback</span> }

export function Slot({ content = <Fallback /> }: { content?: unknown }) @{
  <div>{content}</div>
}
```

```js
import { compile } from "octane/compiler"
const { code } = compile(source, "slot.tsrx", { mode: "client" })
```

**Actual output** (raw JSX remains in the parameter list):

```js
export const Slot = /* @__PURE__ */ _$__s(function Slot({ content = <Fallback /> }, __s, __extra) {
```

**Expected:** the default value is lowered like any other JSX expression in
value position (an element descriptor), or the compiler reports a diagnostic.

## What happens in an app

`compile()` succeeds with no diagnostics, and `tsrx-tsc` typechecks the file
cleanly. The failure only shows up in the bundler. Under Vite 8 via
`@octanejs/tanstack-start`, the dev server logs
`RolldownError: Parse failure`, and every page whose module graph reaches the
file returns 500.

We hit this in a shadcn-style toast component:

```tsx
function ToastClose({ render = <Button variant="neutral" size="icon" />, ...props }) @{ … }
```

## Scope (each case checked with `compile()`, client and server modes)

| Form | Result |
| --- | --- |
| Destructured default in an `@{ }` component: `({ x = <B /> })` | raw JSX in output |
| Plain parameter default: `(x = <B />)` | raw JSX in output |
| Arrow component with destructured default | raw JSX in output |
| `.tsx` (`return` form, `@jsxImportSource octane`) | raw JSX in output |
| Template block as default: `({ x = @{ <B /> } })` | throws `Not implemented: JSXCodeBlock (consider using 'esrap/languages/tsx')` |
| Default assigned in the body: `const x = props.x ?? <B />` | compiles correctly |
| Default referencing a module-level constant: `const d = <B />; ({ x = d })` | compiles correctly |

The `JSXCodeBlock` case may well be invalid syntax. If so, it would help to
report it as a diagnostic pointing at the source location, not an internal
"Not implemented" error from the printer.

## Workaround

Assign the default in the function body:

```tsx
function ToastClose({ render: renderProp, ...props }) @{
  const render = renderProp ?? <Button variant="neutral" size="icon" />
  …
}
```

## Environment

- `octane@0.8.0`, `@octanejs/tanstack-start@0.2.0`, `vite@8.3.2`
- Node 24.16.0, macOS
- Reproduced against the published 0.8.0 package. octane-core `main` at
  `ed0760c44` also reports 0.8.0, but I did not run its source compiler, so I
  have not confirmed whether the bug is still present there.
