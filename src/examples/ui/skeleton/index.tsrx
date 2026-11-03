import { Skeleton } from "@/components/ui/skeleton.tsrx"

export default function SkeletonDemo() @{
  <div class="flex items-center space-x-4">
    <Skeleton class="h-12 w-12 rounded-full" />
    <div class="space-y-2">
      <Skeleton class="h-4 sm:w-[250px] w-[100px]" />
      <Skeleton class="h-4 sm:w-[200px] w-[100px]" />
    </div>
  </div>
}
