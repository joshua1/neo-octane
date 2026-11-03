import {
  Avatar,
  AvatarFallback,
  AvatarImage,
} from "@/components/ui/avatar.tsrx"

export default function AvatarBasicDemo() @{
  <Avatar>
    <AvatarImage
      src="https://github.com/shadcn.png"
      alt="@shadcn"
      class="grayscale"
    />
    <AvatarFallback>CN</AvatarFallback>
  </Avatar>
}
