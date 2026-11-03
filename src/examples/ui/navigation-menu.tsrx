import type { OctaneNode } from "octane"

import {
  NavigationMenu,
  NavigationMenuContent,
  NavigationMenuItem,
  NavigationMenuLink,
  NavigationMenuList,
  NavigationMenuTrigger,
  navigationMenuTriggerStyle,
} from "@/components/ui/navigation-menu.tsrx"

import { cn, type ClassValue } from "@/lib/utils"

const components: { title: string; href: string; description: string }[] = [
  {
    title: "Alert Dialog",
    href: "https://ui.shadcn.com/docs/primitives/alert-dialog",
    description:
      "A modal dialog that interrupts the user with important content and expects a response.",
  },
  {
    title: "Hover Card",
    href: "https://ui.shadcn.com/docs/primitives/hover-card",
    description:
      "For sighted users to preview content available behind a link.",
  },
  {
    title: "Progress",
    href: "https://ui.shadcn.com/docs/primitives/progress",
    description:
      "Displays an indicator showing the completion progress of a task, typically displayed as a progress bar.",
  },
  {
    title: "Scroll-area",
    href: "https://ui.shadcn.com/docs/primitives/scroll-area",
    description: "Visually or semantically separates content.",
  },
  {
    title: "Tabs",
    href: "https://ui.shadcn.com/docs/primitives/tabs",
    description:
      "A set of layered sections of content—known as tab panels—that are displayed one at a time.",
  },
  {
    title: "Tooltip",
    href: "https://ui.shadcn.com/docs/primitives/tooltip",
    description:
      "A popup that displays information related to an element when the element receives keyboard focus or the mouse hovers over it.",
  },
]

export default function NavigationMenuDemo() @{
  <NavigationMenu class="z-5 ">
    <NavigationMenuList>
      <NavigationMenuItem class="sm:block hidden">
        <NavigationMenuTrigger>Getting started</NavigationMenuTrigger>
        <NavigationMenuContent>
          <ul class="grid w-[500px] gap-3 p-2 lg:grid-cols-[.75fr_1fr]">
            <li class="row-span-3">
              <NavigationMenuLink
                class="flex h-full w-full select-none flex-col justify-end rounded-base border-2 border-transparent p-6 no-underline outline-hidden hover:border-border"
                href="https://ui.shadcn.com"
              >
                <div class="mb-2 mt-4 text-lg font-heading">shadcn/ui</div>
                <p class="text-sm font-base leading-tight">
                  Beautifully designed components that you can copy and paste
                  into your apps. Accessible. Customizable. Open Source.
                </p>
              </NavigationMenuLink>
            </li>
            <ListItem href="https://ui.shadcn.com/docs" title="Introduction">
              Re-usable components built using Base UI and Tailwind CSS.
            </ListItem>
            <ListItem
              href="https://ui.shadcn.com/docs/installation"
              title="Installation"
            >
              How to install dependencies and structure your app.
            </ListItem>
            <ListItem
              href="https://ui.shadcn.com/docs/primitives/typography"
              title="Typography"
            >
              Styles for headings, paragraphs, lists...etc
            </ListItem>
          </ul>
        </NavigationMenuContent>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuTrigger>Components</NavigationMenuTrigger>
        <NavigationMenuContent>
          <ul class="grid w-[400px] gap-3 p-2 md:w-[500px] md:grid-cols-2 lg:w-[600px] ">
            @for (const component of components; key component.title) {
              <ListItem title={component.title} href={component.href}>
                {component.description as string}
              </ListItem>
            }
          </ul>
        </NavigationMenuContent>
      </NavigationMenuItem>
      <NavigationMenuItem>
        <NavigationMenuLink
          render={<a href="https://ui.shadcn.com/docs" />}
          class={navigationMenuTriggerStyle()}
        >
          Documentation
        </NavigationMenuLink>
      </NavigationMenuItem>
    </NavigationMenuList>
  </NavigationMenu>
}

type ListItemProps = Record<string, any> & {
  class?: ClassValue
  className?: string
  title?: string
  children?: OctaneNode
}

function ListItem({
  class: klass,
  className,
  title,
  children,
  ...props
}: ListItemProps) @{
  <li>
    <NavigationMenuLink
      class={cn(
        "block text-foreground select-none space-y-1 rounded-base border-2 border-transparent p-3 leading-none no-underline outline-hidden transition-colors hover:bg-main hover:text-main-foreground hover:border-border",
        className,
        klass,
      )}
      {...props}
    >
      <div class="text-base font-heading leading-none">{title as string}</div>
      <p class="font-base line-clamp-2 text-sm leading-snug">{children}</p>
    </NavigationMenuLink>
  </li>
}
