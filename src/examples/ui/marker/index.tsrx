import { GlobeIcon } from "@octanejs/lucide"

import { Marker, MarkerContent, MarkerIcon } from "@/components/ui/marker.tsrx"

export default function MarkerDemo() @{
  <div class="w-full max-w-sm">
    <Marker>
      <MarkerIcon>
        <GlobeIcon />
      </MarkerIcon>
      <MarkerContent>Searched the web</MarkerContent>
    </Marker>
  </div>
}
