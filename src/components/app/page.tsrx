import type { OctaneNode } from "octane"

import { cn, type ClassValue } from "@/lib/utils"

type HostProps = Record<string, any> & {
  class?: ClassValue
  className?: string
  children?: OctaneNode
}

function PageWrapper({ children }: { children?: OctaneNode }) @{
  <div class="min-h-[100dvh] bg-background bg-[linear-gradient(to_right,#80808033_1px,transparent_1px),linear-gradient(to_bottom,#80808033_1px,transparent_1px)] bg-[size:70px_70px] px-5 pt-[70px] prose-h4:xl:text-2xl prose-h4:lg:text-xl prose-h4:text-lg">
    <div class="py-16 mx-auto w-container max-w-full text-foreground text-left">
      {children}
    </div>
  </div>
}

function PageHeading({ class: klass, className, ...props }: HostProps) @{
  <h1
    class={cn(
      "font-heading text-center 2xl:text-4xl xl:text-3xl text-2xl",
      className,
      klass,
    )}
    {...props}
  />
}

function PageHeader({
  children,
  class: klass,
  className,
  ...props
}: HostProps) @{
  <div class={cn("mb-[50px] flex flex-col gap-8", className, klass)} {...props}>
    {children}
  </div>
}

function PageDescription({ class: klass, className, ...props }: HostProps) @{
  <p
    class={cn(
      "font-base 2xl:text-2xl xl:text-xl md:text-lg sm:text-lg text-base text-center",
      className,
      klass,
    )}
    {...props}
  />
}

function PageActions({ class: klass, className, ...props }: HostProps) @{
  <div
    class={cn(
      "flex w-full items-center justify-center gap-2 pt-2",
      className,
      klass,
    )}
    {...props}
  />
}

export { PageWrapper, PageActions, PageDescription, PageHeading, PageHeader }
