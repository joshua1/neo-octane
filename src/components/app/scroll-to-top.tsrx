import { useLocation } from "@octanejs/tanstack-router"
import { useEffect } from "octane"

export default function Scroll() @{
  const pathname = useLocation({ select: (location) => location.pathname })
  useEffect(() => {
    window.scroll(0, 0)
  }, [pathname])
  <></>
}
