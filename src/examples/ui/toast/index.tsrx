import { Button } from "@/components/ui/button.tsrx"
import { Toaster, useToastManager } from "@/components/ui/toast.tsrx"

function ShowToastButton() @{
  const toast = useToastManager()

  function showToast() {
    const id = toast.add({
      title: "Event created",
      description: "Sunday, December 3 at 9:00 AM",
      actionProps: {
        children: "Undo",
        onClick() {
          toast.close(id)
        },
      },
    })
  }

  <Button onClick={showToast}>Show Toast</Button>
}

export default function ToastDemo() @{
  <Toaster>
    <ShowToastButton />
  </Toaster>
}
