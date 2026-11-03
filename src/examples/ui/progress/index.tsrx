import { useEffect, useState } from "octane"

import { Progress } from "@/components/ui/progress.tsrx"

export default function ProgressDemo() @{
  const [progress, setProgress] = useState(13)

  useEffect(() => {
    const timer = setTimeout(() => setProgress(66), 500)
    return () => clearTimeout(timer)
  }, [])

  <Progress value={progress} class="w-[60%]" />
}
