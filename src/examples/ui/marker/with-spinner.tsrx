import { Marker, MarkerContent, MarkerIcon } from "@/components/ui/marker.tsrx"
import { Spinner } from "@/components/ui/spinner.tsrx"

export default function MarkerWithSpinnerDemo() @{
  <div class="w-full max-w-sm">
    <Marker role="status">
      <MarkerIcon>
        <Spinner />
      </MarkerIcon>
      <MarkerContent>Thinking...</MarkerContent>
    </Marker>
  </div>
}
