import type { ClassValue } from "clsx"
import { useIsMobile } from "@/hooks/use-mobile"
import { mergeProps } from "@octanejs/base-ui/merge-props"
import { useRender } from "@octanejs/base-ui/use-render"
import { cva, type VariantProps } from "class-variance-authority"
import { PanelLeftIcon } from "@octanejs/lucide"

import {
  createContext,
  useCallback,
  useContext,
  useEffect,
  useMemo,
  useState,
  type OctaneNode,
} from "octane"

import { Button } from "@/components/ui/button.tsrx"
import { Input } from "@/components/ui/input.tsrx"
import {
  Sheet,
  SheetContent,
  SheetDescription,
  SheetHeader,
  SheetTitle,
} from "@/components/ui/sheet.tsrx"
import { Skeleton } from "@/components/ui/skeleton.tsrx"
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip.tsrx"

import { cn } from "@/lib/utils"

// Octane takes `class`; `className` is what base-ui hands to an element
// passed as `render={…}`, so components fold in both.
type ClassProps = { class?: ClassValue; className?: string }

const SIDEBAR_COOKIE_NAME = "sidebar_state"
const SIDEBAR_COOKIE_MAX_AGE = 60 * 60 * 24 * 7
const SIDEBAR_WIDTH = "16rem"
const SIDEBAR_WIDTH_MOBILE = "18rem"
const SIDEBAR_WIDTH_ICON = "3rem"
const SIDEBAR_KEYBOARD_SHORTCUT = "b"

type Props = Record<string, any> &
  ClassProps & {
    children?: OctaneNode
  }

type StyledProps<P> = Omit<P, "className"> & ClassProps

// @octanejs/base-ui types mergeProps() as PropsOf<T> (no index signature) and
// useRender.ComponentProps["render"] with HTMLProps; neither lines up with
// useRender's own parameter types, so the useRender call sites below cast.
type RenderProp = useRender.RenderProp<any>

type SidebarContextProps = {
  state: "expanded" | "collapsed"
  open: boolean
  setOpen: (open: boolean) => void
  openMobile: boolean
  setOpenMobile: (open: boolean) => void
  isMobile: boolean
  toggleSidebar: () => void
}

const SidebarContext = createContext<SidebarContextProps | null>(null)

function useSidebar() {
  const context = useContext(SidebarContext)
  if (!context) {
    throw new Error("useSidebar must be used within a SidebarProvider.")
  }

  return context
}

function SidebarProvider({
  defaultOpen = true,
  open: openProp,
  onOpenChange: setOpenProp,
  class: klass,
  className,
  style,
  children,
  ...props
}: Props & {
  defaultOpen?: boolean
  open?: boolean
  onOpenChange?: (open: boolean) => void
  style?: Record<string, string | number>
}) @{
  const isMobile = useIsMobile()
  const [openMobile, setOpenMobile] = useState(false)

  // This is the internal state of the sidebar.
  // We use openProp and setOpenProp for control from outside the component.
  const [_open, _setOpen] = useState(defaultOpen)
  const open = openProp ?? _open
  const setOpen = useCallback(
    (value: boolean | ((value: boolean) => boolean)) => {
      const openState = typeof value === "function" ? value(open) : value
      if (setOpenProp) {
        setOpenProp(openState)
      } else {
        _setOpen(openState)
      }

      // This sets the cookie to keep the sidebar state.
      document.cookie = `${SIDEBAR_COOKIE_NAME}=${openState}; path=/; max-age=${SIDEBAR_COOKIE_MAX_AGE}`
    },
    [setOpenProp, open],
  )

  // Helper to toggle the sidebar.
  const toggleSidebar = useCallback(() => {
    return isMobile ? setOpenMobile((open) => !open) : setOpen((open) => !open)
  }, [isMobile, setOpen, setOpenMobile])

  // Adds a keyboard shortcut to toggle the sidebar.
  useEffect(() => {
    const handleKeyDown = (event: KeyboardEvent) => {
      if (
        event.key === SIDEBAR_KEYBOARD_SHORTCUT &&
        (event.metaKey || event.ctrlKey)
      ) {
        event.preventDefault()
        toggleSidebar()
      }
    }

    window.addEventListener("keydown", handleKeyDown)
    return () => window.removeEventListener("keydown", handleKeyDown)
  }, [toggleSidebar])

  // We add a state so that we can do data-state="expanded" or "collapsed".
  // This makes it easier to style the sidebar with Tailwind classes.
  const state = open ? "expanded" : "collapsed"

  const contextValue = useMemo<SidebarContextProps>(
    () => ({
      state,
      open,
      setOpen,
      isMobile,
      openMobile,
      setOpenMobile,
      toggleSidebar,
    }),
    [state, open, setOpen, isMobile, openMobile, setOpenMobile, toggleSidebar],
  )

  <SidebarContext value={contextValue}>
    <TooltipProvider delay={0}>
      <div
        data-slot="sidebar-wrapper"
        style={{
          "--sidebar-width": SIDEBAR_WIDTH,
          "--sidebar-width-icon": SIDEBAR_WIDTH_ICON,
          ...style,
        }}
        class={cn(
          "group/sidebar-wrapper has-data-[variant=inset]:bg-sidebar flex min-h-svh w-full",
          className,
          klass,
        )}
        {...props}
      >
        {children}
      </div>
    </TooltipProvider>
  </SidebarContext>
}

function Sidebar({
  side = "left",
  variant = "sidebar",
  collapsible = "offcanvas",
  class: klass,
  className,
  children,
  ...props
}: Props & {
  side?: "left" | "right"
  variant?: "sidebar" | "floating" | "inset"
  collapsible?: "offcanvas" | "icon" | "none"
}) {
  const { isMobile, state, openMobile, setOpenMobile } = useSidebar()

  if (collapsible === "none") {
    return (
      <div
        data-slot="sidebar"
        class={cn(
          "bg-secondary-background text-foreground flex h-full w-(--sidebar-width) flex-col",
          className,
          klass,
        )}
        {...props}
      >
        {children}
      </div>
    )
  }

  if (isMobile) {
    return (
      <Sheet open={openMobile} onOpenChange={setOpenMobile} {...props}>
        <SheetContent
          data-sidebar="sidebar"
          data-slot="sidebar"
          data-mobile="true"
          showCloseButton={false}
          class="bg-secondary-background text-foreground w-(--sidebar-width) p-0"
          style={{
            "--sidebar-width": SIDEBAR_WIDTH_MOBILE,
          }}
          side={side}
        >
          <SheetHeader class="sr-only">
            <SheetTitle>Sidebar</SheetTitle>
            <SheetDescription>Displays the mobile sidebar.</SheetDescription>
          </SheetHeader>
          <div class="flex h-full w-full flex-col">{children}</div>
        </SheetContent>
      </Sheet>
    )
  }

  // The first child is what handles the sidebar gap on desktop.
  return (
    <div
      class="group peer hidden md:block"
      data-state={state}
      data-collapsible={state === "collapsed" ? collapsible : ""}
      data-variant={variant}
      data-side={side}
      data-slot="sidebar"
    >
      <div
        data-slot="sidebar-gap"
        class={cn(
          "relative w-(--sidebar-width) bg-transparent transition-[width] duration-200 ease-linear",
          "group-data-[collapsible=offcanvas]:w-0",
          "group-data-[side=right]:rotate-180",
          variant === "floating" || variant === "inset"
            ? "group-data-[collapsible=icon]:w-[calc(var(--sidebar-width-icon)+(--spacing(4)))]"
            : "group-data-[collapsible=icon]:w-(--sidebar-width-icon)",
        )}
      />
      <div
        data-slot="sidebar-container"
        class={cn(
          "fixed inset-y-0 z-10 hidden h-svh w-(--sidebar-width) transition-[left,right,width] duration-200 ease-linear md:flex",
          side === "left"
            ? "left-0 group-data-[collapsible=offcanvas]:left-[calc(var(--sidebar-width)*-1)]"
            : "right-0 group-data-[collapsible=offcanvas]:right-[calc(var(--sidebar-width)*-1)]",
          // Adjust the padding for floating and inset variants.
          variant === "floating" || variant === "inset"
            ? "p-2 group-data-[collapsible=icon]:w-[calc(var(--sidebar-width-icon)+(--spacing(4))+2px)]"
            : "group-data-[collapsible=icon]:w-(--sidebar-width-icon) group-data-[side=left]:border-r-2 border-r-border group-data-[side=right]:border-l-2 border-l-border",
          className,
          klass,
        )}
        {...props}
      >
        <div
          data-sidebar="sidebar"
          data-slot="sidebar-inner"
          class="bg-secondary-background flex h-full w-full flex-col"
        >
          {children}
        </div>
      </div>
    </div>
  )
}

function SidebarTrigger({
  class: klass,
  className,
  onClick,
  ...props
}: Parameters<typeof Button>[0] & {
  onClick?: (event: MouseEvent) => void
}) @{
  const { toggleSidebar } = useSidebar()

  <Button
    data-sidebar="trigger"
    data-slot="sidebar-trigger"
    variant="noShadow"
    size="icon"
    class={cn("size-7", className, klass)}
    onClick={(event: MouseEvent) => {
      onClick?.(event)
      toggleSidebar()
    }}
    {...props}
  >
    <PanelLeftIcon />
    <span class="sr-only">Toggle Sidebar</span>
  </Button>
}

function SidebarRail({ class: klass, className, ...props }: Props) @{
  const { toggleSidebar } = useSidebar()

  <button
    data-sidebar="rail"
    data-slot="sidebar-rail"
    aria-label="Toggle Sidebar"
    tabIndex={-1}
    onClick={toggleSidebar}
    title="Toggle Sidebar"
    class={cn(
      "absolute inset-y-0 z-20 hidden w-4 -translate-x-1/2 transition-all ease-linear group-data-[side=left]:-right-4 group-data-[side=right]:left-0 after:absolute after:inset-y-0 after:left-1/2 after:w-[2px] sm:flex",
      "in-data-[side=left]:cursor-w-resize in-data-[side=right]:cursor-e-resize",
      "[[data-side=left][data-state=collapsed]_&]:cursor-e-resize [[data-side=right][data-state=collapsed]_&]:cursor-w-resize",
      "hover:group-data-[collapsible=offcanvas]:bg-sidebar group-data-[collapsible=offcanvas]:translate-x-0 group-data-[collapsible=offcanvas]:after:left-full",
      "[[data-side=left][data-collapsible=offcanvas]_&]:-right-2",
      "[[data-side=right][data-collapsible=offcanvas]_&]:-left-2",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarInset({ class: klass, className, ...props }: Props) @{
  <main
    data-slot="sidebar-inset"
    class={cn(
      "bg-secondary-background relative flex w-full flex-1 flex-col",
      "md:peer-data-[variant=inset]:m-2 md:peer-data-[variant=inset]:ml-0 md:peer-data-[variant=inset]:rounded-base md:peer-data-[variant=inset]:shadow-sm md:peer-data-[variant=inset]:peer-data-[state=collapsed]:ml-2",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarInput({ class: klass, className, ...props }: Props) @{
  <Input
    data-slot="sidebar-input"
    data-sidebar="input"
    class={cn(
      "bg-secondary-background h-8 w-full shadow-none",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarHeader({ class: klass, className, ...props }: Props) @{
  <div
    data-slot="sidebar-header"
    data-sidebar="header"
    class={cn(
      "flex flex-col gap-2 p-2 border-b-2 border-b-border",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarFooter({ class: klass, className, ...props }: Props) @{
  <div
    data-slot="sidebar-footer"
    data-sidebar="footer"
    class={cn(
      "flex flex-col gap-2 p-2 border-t-2 border-t-border",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarContent({ class: klass, className, ...props }: Props) @{
  <div
    data-slot="sidebar-content"
    data-sidebar="content"
    class={cn(
      "flex min-h-0 flex-1 flex-col overflow-auto group-data-[collapsible=icon]:overflow-hidden",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarGroup({ class: klass, className, ...props }: Props) @{
  <div
    data-slot="sidebar-group"
    data-sidebar="group"
    class={cn(
      "relative flex w-full min-w-0 flex-col p-2 border-b-2 border-b-border last:border-b-0",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarGroupLabel({
  class: klass,
  className,
  render,
  ...props
}: StyledProps<useRender.ComponentProps<"div">>) {
  return useRender({
    defaultTagName: "div",
    render: render as RenderProp,
    props: mergeProps<"div">(
      {
        className: cn(
          "text-foreground ring-ring flex h-8 shrink-0 items-center rounded-base px-2 text-sm font-heading outline-hidden transition-[margin,opacity] duration-200 ease-linear focus-visible:ring-2 [&>svg]:size-4 [&>svg]:shrink-0",
          "group-data-[collapsible=icon]:-mt-8 group-data-[collapsible=icon]:opacity-0",
          className,
          klass,
        ),
      },
      props,
    ) as Record<string, unknown>,
    state: {
      slot: "sidebar-group-label",
      sidebar: "group-label",
    },
  })
}

function SidebarGroupAction({
  class: klass,
  className,
  render,
  ...props
}: StyledProps<useRender.ComponentProps<"button">>) {
  return useRender({
    defaultTagName: "button",
    render: render as RenderProp,
    props: mergeProps<"button">(
      {
        className: cn(
          "absolute top-3.5 right-3 flex aspect-square w-5 items-center justify-center rounded-base p-0 outline-hidden transition-transform focus-visible:ring-2 [&>svg]:size-4 [&>svg]:shrink-0",
          // Increases the hit area of the button on mobile.
          "after:absolute after:-inset-2 md:after:hidden",
          "group-data-[collapsible=icon]:hidden",
          className,
          klass,
        ),
      },
      props,
    ) as Record<string, unknown>,
    state: {
      slot: "sidebar-group-action",
      sidebar: "group-action",
    },
  })
}

function SidebarGroupContent({ class: klass, className, ...props }: Props) @{
  <div
    data-slot="sidebar-group-content"
    data-sidebar="group-content"
    class={cn("w-full text-sm", className, klass)}
    {...props}
  />
}

function SidebarMenu({ class: klass, className, ...props }: Props) @{
  <ul
    data-slot="sidebar-menu"
    data-sidebar="menu"
    class={cn("flex w-full min-w-0 flex-col gap-1", className, klass)}
    {...props}
  />
}

function SidebarMenuItem({ class: klass, className, ...props }: Props) @{
  <li
    data-slot="sidebar-menu-item"
    data-sidebar="menu-item"
    class={cn("group/menu-item relative font-base", className, klass)}
    {...props}
  />
}

const sidebarMenuButtonVariants = cva(
  "peer/menu-button flex w-full items-center gap-2 overflow-hidden outline-2 outline-transparent rounded-base p-2 text-left text-sm ring-ring transition-[width,height,padding] hover:bg-main hover:text-main-foreground hover:outline-border focus-visible:outline-border focus-visible:text-main-foreground focus-visible:bg-main disabled:pointer-events-none disabled:opacity-50 group-has-data-[sidebar=menu-action]/menu-item:pr-8 aria-disabled:pointer-events-none aria-disabled:opacity-50 data-active:bg-main data-active:text-main-foreground data-active:outline-border group-data-[collapsible=icon]:size-8! group-data-[collapsible=icon]:p-2! [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0",
  {
    variants: {
      size: {
        default: "h-8 text-sm",
        sm: "h-7 text-xs",
        lg: "h-12 text-sm group-data-[collapsible=icon]:p-0!",
      },
    },
    defaultVariants: {
      size: "default",
    },
  },
)

function SidebarMenuButton({
  render,
  isActive = false,
  size = "default",
  tooltip,
  class: klass,
  className,
  ...props
}: StyledProps<useRender.ComponentProps<"button">> & {
  isActive?: boolean
  // TooltipContent props (`children`, `side`, `align`, …).
  tooltip?: string | Record<string, any>
} & VariantProps<typeof sidebarMenuButtonVariants>) {
  const { isMobile, state } = useSidebar()

  const button = useRender({
    defaultTagName: "button",
    // When a tooltip is present, the button doubles as the tooltip trigger.
    render: (tooltip ? (
      <TooltipTrigger render={render} />
    ) : (
      render
    )) as RenderProp,
    props: mergeProps<"button">(
      {
        className: cn(sidebarMenuButtonVariants({ size }), className, klass),
      },
      props,
    ) as Record<string, unknown>,
    state: {
      slot: "sidebar-menu-button",
      sidebar: "menu-button",
      size,
      active: isActive,
    },
  })

  if (!tooltip) {
    return button
  }

  const tooltipProps =
    typeof tooltip === "string" ? { children: tooltip } : tooltip

  return (
    <Tooltip>
      {button}
      <TooltipContent
        side="right"
        align="center"
        hidden={state !== "collapsed" || isMobile}
        {...tooltipProps}
      />
    </Tooltip>
  )
}

function SidebarMenuAction({
  class: klass,
  className,
  render,
  showOnHover = false,
  ...props
}: StyledProps<useRender.ComponentProps<"button">> & {
  showOnHover?: boolean
}) {
  return useRender({
    defaultTagName: "button",
    render: render as RenderProp,
    props: mergeProps<"button">(
      {
        className: cn(
          "[&_svg]:text-foreground hover:[&_svg]:text-main-foreground text-main-foreground hover:bg-main hover:outline-border outline-transparent outline-2 absolute top-1.5 right-1 flex aspect-square w-5 items-center justify-center rounded-base p-0 transition-transform focus-visible:ring-2 [&>svg]:size-4 [&>svg]:shrink-0",
          // Increases the hit area of the button on mobile.
          "after:absolute after:-inset-2 md:after:hidden",
          "peer-data-[size=sm]/menu-button:top-1",
          "peer-data-[size=default]/menu-button:top-1.5",
          "peer-data-[size=lg]/menu-button:top-2.5",
          "group-data-[collapsible=icon]:hidden",
          showOnHover &&
            "group-focus-within/menu-item:opacity-100 group-hover/menu-item:opacity-100 peer-data-active/menu-button:text-main-foreground aria-expanded:opacity-100 md:opacity-0",
          className,
          klass,
        ),
      },
      props,
    ) as Record<string, unknown>,
    state: {
      slot: "sidebar-menu-action",
      sidebar: "menu-action",
    },
  })
}

function SidebarMenuBadge({ class: klass, className, ...props }: Props) @{
  <div
    data-slot="sidebar-menu-badge"
    data-sidebar="menu-badge"
    class={cn(
      "text-foreground pointer-events-none absolute right-1 flex h-5 min-w-5 items-center justify-center rounded-base px-1 text-xs font-base tabular-nums select-none",
      "peer-hover/menu-button:text-main-foreground",
      "peer-data-[size=sm]/menu-button:top-1",
      "peer-data-[size=default]/menu-button:top-1.5",
      "peer-data-[size=lg]/menu-button:top-2.5",
      "group-data-[collapsible=icon]:hidden",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarMenuSkeleton({
  class: klass,
  className,
  showIcon = false,
  ...props
}: Props & {
  showIcon?: boolean
}) @{
  // Random width between 50 to 90%.
  const width = useMemo(() => {
    return `${Math.floor(Math.random() * 40) + 50}%`
  }, [])

  <div
    data-slot="sidebar-menu-skeleton"
    data-sidebar="menu-skeleton"
    class={cn(
      "flex h-8 items-center gap-2 rounded-base px-2",
      className,
      klass,
    )}
    {...props}
  >
    @if (showIcon) {
      <Skeleton class="size-4 rounded-base" data-sidebar="menu-skeleton-icon" />
    }
    <Skeleton
      class="h-4 max-w-(--skeleton-width) flex-1"
      data-sidebar="menu-skeleton-text"
      style={{
        "--skeleton-width": width,
      }}
    />
  </div>
}

function SidebarMenuSub({ class: klass, className, ...props }: Props) @{
  <ul
    data-slot="sidebar-menu-sub"
    data-sidebar="menu-sub"
    class={cn(
      "border-l-foreground/50 mx-3.5 flex min-w-0 translate-x-px flex-col gap-1 border-l-2 px-2.5 py-0.5",
      "group-data-[collapsible=icon]:hidden",
      className,
      klass,
    )}
    {...props}
  />
}

function SidebarMenuSubItem({ class: klass, className, ...props }: Props) @{
  <li
    data-slot="sidebar-menu-sub-item"
    data-sidebar="menu-sub-item"
    class={cn("group/menu-sub-item relative", className, klass)}
    {...props}
  />
}

function SidebarMenuSubButton({
  render,
  size = "md",
  isActive = false,
  class: klass,
  className,
  ...props
}: StyledProps<useRender.ComponentProps<"a">> & {
  size?: "sm" | "md"
  isActive?: boolean
}) {
  return useRender({
    defaultTagName: "a",
    render: render as RenderProp,
    props: mergeProps<"a">(
      {
        className: cn(
          "text-foreground hover:bg-main hover:outline-border hover:text-main-foreground active:bg-main outline-transparent outline-2 [&>svg]:text-main-foreground flex h-7 min-w-0 -translate-x-px items-center gap-2 overflow-hidden rounded-base px-2 focus-visible:ring-2 disabled:pointer-events-none disabled:opacity-50 aria-disabled:pointer-events-none aria-disabled:opacity-50 [&>span:last-child]:truncate [&>svg]:size-4 [&>svg]:shrink-0",
          "data-active:bg-main data-active:outline-border",
          size === "sm" && "text-xs",
          size === "md" && "text-sm",
          "group-data-[collapsible=icon]:hidden",
          className,
          klass,
        ),
      },
      props,
    ) as Record<string, unknown>,
    state: {
      slot: "sidebar-menu-sub-button",
      sidebar: "menu-sub-button",
      size,
      active: isActive,
    },
  })
}

export {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupAction,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarInput,
  SidebarInset,
  SidebarMenu,
  SidebarMenuAction,
  SidebarMenuBadge,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarMenuSkeleton,
  SidebarMenuSub,
  SidebarMenuSubButton,
  SidebarMenuSubItem,
  SidebarProvider,
  SidebarRail,
  SidebarTrigger,
  useSidebar,
}
