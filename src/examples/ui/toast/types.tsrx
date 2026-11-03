import { Button } from "@/components/ui/button.tsrx"
import { Toaster, useToastManager } from "@/components/ui/toast.tsrx"

function ToastTypeButtons() @{
  const toast = useToastManager()

  <div class="flex flex-wrap justify-center gap-2">
    <Button
      variant="neutral"
      onClick={() => toast.add({ description: "Event has been created." })}
    >
      Default
    </Button>
    <Button
      variant="neutral"
      onClick={() =>
        toast.add({
          type: "success",
          description: "Event has been created.",
        })
      }
    >
      Success
    </Button>
    <Button
      variant="neutral"
      onClick={() =>
        toast.add({
          type: "info",
          description: "Arrive 10 minutes before the event.",
        })
      }
    >
      Info
    </Button>
    <Button
      variant="neutral"
      onClick={() =>
        toast.add({
          type: "warning",
          description: "The event cannot start before 8:00 AM.",
        })
      }
    >
      Warning
    </Button>
    <Button
      variant="neutral"
      onClick={() =>
        toast.add({
          type: "error",
          description: "The event could not be created.",
          priority: "high",
        })
      }
    >
      Error
    </Button>
  </div>
}

export default function ToastTypesDemo() @{
  <Toaster>
    <ToastTypeButtons />
  </Toaster>
}
