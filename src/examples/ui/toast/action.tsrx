import { Button } from "@/components/ui/button.tsrx"
import { Toaster, useToastManager } from "@/components/ui/toast.tsrx"

function ToastActionButton() @{
  const toast = useToastManager()

  function showToast() {
    const id = toast.add({
      title: "Event created",
      actionProps: {
        children: "Undo",
        onClick() {
          toast.close(id)
        },
      },
    })
  }

  <Button variant="neutral" onClick={showToast}>
    Show Toast
  </Button>
}

export default function ToastActionDemo() @{
  <Toaster>
    <ToastActionButton />
  </Toaster>
}
