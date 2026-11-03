import { Button } from "@/components/ui/button.tsrx"
import { Toaster, useToastManager } from "@/components/ui/toast.tsrx"

function ToastPromiseButton() @{
  const toast = useToastManager()

  function showToast() {
    toast.promise(
      new Promise<{ name: string }>((resolve) => {
        window.setTimeout(() => resolve({ name: "Event" }), 2000)
      }),
      {
        loading: "Creating event…",
        success: (data) => `${data.name} created.`,
        error: "Could not create event.",
      },
    )
  }

  <Button variant="neutral" onClick={showToast}>
    Create Event
  </Button>
}

export default function ToastPromiseDemo() @{
  <Toaster>
    <ToastPromiseButton />
  </Toaster>
}
