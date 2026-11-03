import {
  Progress,
  ProgressLabel,
  ProgressValue,
} from "@/components/ui/progress.tsrx"

export default function ProgressLabelDemo() @{
  <Progress value={56} class="w-full max-w-sm">
    <ProgressLabel>Upload progress</ProgressLabel>
    <ProgressValue />
  </Progress>
}
