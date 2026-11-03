import {
  AudioWaveform,
  BadgeCheck,
  Bell,
  BookOpen,
  Bot,
  ChevronRight,
  ChevronsUpDown,
  Command,
  CreditCard,
  Folder,
  Forward,
  Frame,
  GalleryVerticalEnd,
  LogOut,
  Map,
  MoreHorizontal,
  PieChart,
  Plus,
  Settings2,
  Sparkles,
  SquareTerminal,
  Trash2,
} from "@octanejs/lucide"

import { useState, type ComponentProps } from "octane"

import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar.tsrx"
import {
  Collapsible,
  CollapsibleContent,
  CollapsibleTrigger,
} from "@/components/ui/collapsible.tsrx"
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuGroup,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuShortcut,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu.tsrx"
import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarGroup,
  SidebarGroupAction,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarHeader,
  SidebarMenu,
  SidebarMenuAction,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarMenuSub,
  SidebarMenuSubButton,
  SidebarMenuSubItem,
  SidebarRail,
  useSidebar,
} from "@/components/ui/sidebar.tsrx"

// This is sample data.
const data = {
  user: {
    name: "shadcn",
    email: "m@example.com",
    avatar: "/avatars/shadcn.jpg",
  },
  teams: [
    {
      name: "Acme Inc",
      logo: GalleryVerticalEnd,
      plan: "Enterprise",
    },
    {
      name: "Acme Corp.",
      logo: AudioWaveform,
      plan: "Startup",
    },
    {
      name: "Evil Corp.",
      logo: Command,
      plan: "Free",
    },
  ],
  navMain: [
    {
      title: "Playground",
      url: "#",
      icon: SquareTerminal,
      isActive: true,
      items: [
        {
          title: "History",
          url: "#",
        },
        {
          title: "Starred",
          url: "#",
        },
        {
          title: "Settings",
          url: "#",
        },
      ],
    },
    {
      title: "Models",
      url: "#",
      icon: Bot,
      items: [
        {
          title: "Genesis",
          url: "#",
        },
        {
          title: "Explorer",
          url: "#",
        },
        {
          title: "Quantum",
          url: "#",
        },
      ],
    },
    {
      title: "Documentation",
      url: "#",
      icon: BookOpen,
      items: [
        {
          title: "Introduction",
          url: "#",
        },
        {
          title: "Get Started",
          url: "#",
        },
        {
          title: "Tutorials",
          url: "#",
        },
        {
          title: "Changelog",
          url: "#",
        },
      ],
    },
    {
      title: "Settings",
      url: "#",
      icon: Settings2,
      items: [
        {
          title: "General",
          url: "#",
        },
        {
          title: "Team",
          url: "#",
        },
        {
          title: "Billing",
          url: "#",
        },
        {
          title: "Limits",
          url: "#",
        },
      ],
    },
  ],
  projects: [
    {
      name: "Design Engineering",
      url: "#",
      icon: Frame,
    },
    {
      name: "Sales & Marketing",
      url: "#",
      icon: PieChart,
    },
    {
      name: "Travel",
      url: "#",
      icon: Map,
    },
  ],
}

export function AppSidebar({ ...props }: ComponentProps<typeof Sidebar>) @{
  const { isMobile } = useSidebar()
  const [activeTeam, setActiveTeam] = useState(data.teams[0])

  if (!activeTeam) {
    return null
  }

  const ActiveTeamLogo = activeTeam.logo

  <Sidebar class="static" collapsible="icon" {...props}>
    <SidebarHeader>
      <SidebarMenu>
        <SidebarMenuItem>
          <DropdownMenu>
            <DropdownMenuTrigger
              class="focus-visible:ring-0"
              render={
                <SidebarMenuButton
                  size="lg"
                  class="data-popup-open:bg-main data-popup-open:text-main-foreground data-popup-open:outline-border data-popup-open:outline-2"
                />
              }
            >
              <div class="flex aspect-square size-8 items-center justify-center rounded-base">
                <ActiveTeamLogo class="size-4" />
              </div>
              <div class="grid flex-1 text-left text-sm leading-tight">
                <span class="truncate font-heading">
                  {activeTeam.name as string}
                </span>
                <span class="truncate font-base text-xs">
                  {activeTeam.plan as string}
                </span>
              </div>
              <ChevronsUpDown class="ml-auto" />
            </DropdownMenuTrigger>
            <DropdownMenuContent
              class="w-(--anchor-width) min-w-56 rounded-base"
              align="start"
              side={isMobile ? "bottom" : "right"}
              sideOffset={4}
            >
              <DropdownMenuLabel class="text-sm font-heading">
                Teams
              </DropdownMenuLabel>
              @for (const team of data.teams; index index; key team.name) {
                const TeamLogo = team.logo
                <DropdownMenuItem
                  onClick={() => setActiveTeam(team)}
                  class="gap-2 p-1.5"
                >
                  <div class="flex size-6 items-center justify-center">
                    <TeamLogo class="size-4 shrink-0" />
                  </div>
                  {team.name as string}
                  <DropdownMenuShortcut>
                    {"⌘" + (index + 1)}
                  </DropdownMenuShortcut>
                </DropdownMenuItem>
              }
              <DropdownMenuSeparator />
              <DropdownMenuItem class="gap-2 p-1.5">
                <div class="flex size-6 items-center justify-center">
                  <Plus class="size-4" />
                </div>
                <div class="font-base">Add team</div>
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </SidebarMenuItem>
      </SidebarMenu>
    </SidebarHeader>
    <SidebarContent>
      <SidebarGroup>
        <SidebarGroupLabel>Platform</SidebarGroupLabel>
        <SidebarMenu>
          @for (const item of data.navMain; key item.title) {
            const ItemIcon = item.icon
            <Collapsible
              defaultOpen={item.isActive}
              class="group/collapsible"
              render={<SidebarMenuItem />}
            >
              <CollapsibleTrigger
                render={
                  <SidebarMenuButton
                    class="data-panel-open:bg-main data-panel-open:outline-border data-panel-open:text-main-foreground"
                    tooltip={item.title}
                  />
                }
              >
                @if (ItemIcon) {
                  <ItemIcon />
                }
                <span>{item.title as string}</span>
                <ChevronRight class="ml-auto transition-transform duration-200 group-data-open/collapsible:rotate-90" />
              </CollapsibleTrigger>
              <CollapsibleContent>
                <SidebarMenuSub>
                  @for (const subItem of item.items ?? []; key subItem.title) {
                    <SidebarMenuSubItem>
                      <SidebarMenuSubButton render={<a href={subItem.url} />}>
                        <span>{subItem.title as string}</span>
                      </SidebarMenuSubButton>
                    </SidebarMenuSubItem>
                  }
                </SidebarMenuSub>
              </CollapsibleContent>
            </Collapsible>
          }
        </SidebarMenu>
      </SidebarGroup>
      <SidebarGroup class="group-data-[collapsible=icon]:hidden">
        <SidebarGroupLabel>Projects</SidebarGroupLabel>
        <SidebarMenu>
          @for (const item of data.projects; key item.name) {
            const ProjectIcon = item.icon
            <SidebarMenuItem>
              <SidebarMenuButton render={<a href={item.url} />}>
                <ProjectIcon />
                <span>{item.name as string}</span>
              </SidebarMenuButton>
              <DropdownMenu>
                <DropdownMenuTrigger render={<SidebarMenuAction />}>
                  <MoreHorizontal class="group-hover/menu-item:text-main-foreground" />
                  <span class="sr-only">More</span>
                </DropdownMenuTrigger>
                <DropdownMenuContent
                  class="w-48"
                  side={isMobile ? "bottom" : "right"}
                  align={isMobile ? "end" : "start"}
                >
                  <DropdownMenuItem>
                    <Folder />
                    <span>View Project</span>
                  </DropdownMenuItem>
                  <DropdownMenuItem>
                    <Forward />
                    <span>Share Project</span>
                  </DropdownMenuItem>
                  <DropdownMenuSeparator />
                  <DropdownMenuItem>
                    <Trash2 />
                    <span>Delete Project</span>
                  </DropdownMenuItem>
                </DropdownMenuContent>
              </DropdownMenu>
            </SidebarMenuItem>
          }
          <SidebarMenuItem>
            <SidebarMenuButton>
              <MoreHorizontal />
              <span>More</span>
            </SidebarMenuButton>
          </SidebarMenuItem>
        </SidebarMenu>
      </SidebarGroup>
    </SidebarContent>
    <SidebarFooter>
      <SidebarMenu>
        <SidebarMenuItem>
          <DropdownMenu>
            <DropdownMenuTrigger
              render={
                <SidebarMenuButton
                  class="group-data-[state=collapsed]:hover:outline-0 group-data-[state=collapsed]:hover:bg-transparent overflow-visible"
                  size="lg"
                />
              }
            >
              <Avatar class="h-8 w-8">
                <AvatarImage
                  src="https://github.com/shadcn.png?size=40"
                  alt="CN"
                />
                <AvatarFallback>CN</AvatarFallback>
              </Avatar>
              <div class="grid flex-1 text-left text-sm leading-tight">
                <span class="truncate font-heading">
                  {data.user.name as string}
                </span>
                <span class="truncate text-xs">
                  {data.user.email as string}
                </span>
              </div>
              <ChevronsUpDown class="ml-auto size-4" />
            </DropdownMenuTrigger>
            <DropdownMenuContent
              class="w-(--anchor-width) min-w-56"
              side={isMobile ? "bottom" : "right"}
              align="end"
              sideOffset={4}
            >
              <DropdownMenuLabel class="p-0 font-base">
                <div class="flex items-center gap-2 px-1 py-1.5 text-left text-sm">
                  <Avatar class="h-8 w-8">
                    <AvatarImage
                      src="https://github.com/shadcn.png?size=40"
                      alt="CN"
                    />
                    <AvatarFallback>CN</AvatarFallback>
                  </Avatar>
                  <div class="grid flex-1 text-left text-sm leading-tight">
                    <span class="truncate font-heading">
                      {data.user.name as string}
                    </span>
                    <span class="truncate text-xs">
                      {data.user.email as string}
                    </span>
                  </div>
                </div>
              </DropdownMenuLabel>
              <DropdownMenuSeparator />
              <DropdownMenuGroup>
                <DropdownMenuItem>
                  <Sparkles />
                  Upgrade to Pro
                </DropdownMenuItem>
              </DropdownMenuGroup>
              <DropdownMenuSeparator />
              <DropdownMenuGroup>
                <DropdownMenuItem>
                  <BadgeCheck />
                  Account
                </DropdownMenuItem>
                <DropdownMenuItem>
                  <CreditCard />
                  Billing
                </DropdownMenuItem>
                <DropdownMenuItem>
                  <Bell />
                  Notifications
                </DropdownMenuItem>
              </DropdownMenuGroup>
              <DropdownMenuSeparator />
              <DropdownMenuItem>
                <LogOut />
                Log out
              </DropdownMenuItem>
            </DropdownMenuContent>
          </DropdownMenu>
        </SidebarMenuItem>
      </SidebarMenu>
    </SidebarFooter>
    <SidebarRail />
  </Sidebar>
}
