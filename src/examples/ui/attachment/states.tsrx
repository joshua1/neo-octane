import {
  AlertCircleIcon,
  FileTextIcon,
  UploadIcon,
  XIcon,
} from "@octanejs/lucide"

import {
  Attachment,
  AttachmentAction,
  AttachmentActions,
  AttachmentContent,
  AttachmentDescription,
  AttachmentMedia,
  AttachmentTitle,
} from "@/components/ui/attachment.tsrx"
import { Spinner } from "@/components/ui/spinner.tsrx"

export default function AttachmentStatesDemo() @{
  <div class="flex w-full max-w-xs flex-col gap-4">
    <Attachment state="idle" class="w-full">
      <AttachmentMedia>
        <UploadIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>Drop a file</AttachmentTitle>
        <AttachmentDescription>Waiting for a file</AttachmentDescription>
      </AttachmentContent>
    </Attachment>
    <Attachment state="uploading" class="w-full">
      <AttachmentMedia>
        <Spinner />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>quarterly-report.pdf</AttachmentTitle>
        <AttachmentDescription>Uploading · 45%</AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Cancel">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
    <Attachment state="error" class="w-full">
      <AttachmentMedia>
        <AlertCircleIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>large-video.mp4</AttachmentTitle>
        <AttachmentDescription>File is too large</AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Remove">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
    <Attachment state="done" class="w-full">
      <AttachmentMedia>
        <FileTextIcon />
      </AttachmentMedia>
      <AttachmentContent>
        <AttachmentTitle>notes.md</AttachmentTitle>
        <AttachmentDescription>Markdown · 12 KB</AttachmentDescription>
      </AttachmentContent>
      <AttachmentActions>
        <AttachmentAction aria-label="Remove">
          <XIcon />
        </AttachmentAction>
      </AttachmentActions>
    </Attachment>
  </div>
}
