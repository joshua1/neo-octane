// ArkType resolver for @octanejs/hook-form.
//
// `@hookform/resolvers/arktype` imports the original hook-form package at
// runtime, so it cannot run against the octane binding. ArkType types implement the
// Standard Schema spec (`schema["~standard"]`), so validation goes through
// that interface and needs no ArkType internals. Issues are written into a
// nested error object with hook-form's own `set`, so array/object fields keep
// working (`errors.emails?.[0]?.address`). Only the first issue per field is
// kept, matching hook-form's default `criteriaMode: "firstError"`.
import {
  set,
  type FieldError,
  type FieldErrors,
  type FieldValues,
  type Resolver,
} from "@octanejs/hook-form"

type StandardIssue = {
  message?: string
  path?: ReadonlyArray<PropertyKey | { key: PropertyKey }>
}

type StandardResult<T> =
  | { readonly issues?: undefined; readonly value: T }
  | { readonly issues: readonly StandardIssue[]; readonly value?: undefined }

type StandardSchema<TInput, TOutput> = {
  readonly "~standard": {
    readonly types?: { readonly input: TInput; readonly output: TOutput }
    // Loose on purpose: ArkType's result type doesn't structurally carry the
    // spec's marker properties even though its runtime results conform.
    validate: (value: any, options?: any) => unknown
  }
}

const toDotPath = (issue: StandardIssue): string => {
  if (!issue.path || issue.path.length === 0) return "root"
  return issue.path
    .map((segment) =>
      typeof segment === "object" && segment !== null
        ? String(segment.key)
        : String(segment),
    )
    .join(".")
}

export function arktypeResolver<
  TFieldValues extends FieldValues,
  TContext = unknown,
  TTransformedValues = TFieldValues,
>(
  schema: StandardSchema<TFieldValues, TTransformedValues>,
): Resolver<TFieldValues, TContext, TTransformedValues> {
  return (values) => {
    const resolve = (result: StandardResult<TTransformedValues>) => {
      if (!result.issues || result.issues.length === 0) {
        return { values: result.value as TTransformedValues, errors: {} }
      }

      const errors: Record<string, unknown> = {}
      const seen = new Set<string>()
      for (const issue of result.issues) {
        const path = toDotPath(issue)
        if (seen.has(path)) continue
        seen.add(path)
        const error: FieldError = {
          type: "validation",
          message: issue.message ?? "",
        }
        set(errors, path, error)
      }
      return { values: {}, errors: errors as FieldErrors<TFieldValues> }
    }

    const result = schema["~standard"].validate(values)
    return result instanceof Promise
      ? result.then((r) => resolve(r as StandardResult<TTransformedValues>))
      : resolve(result as StandardResult<TTransformedValues>)
  }
}
