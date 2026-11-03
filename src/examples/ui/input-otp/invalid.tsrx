import { useState } from "octane"

import {
  InputOTP,
  InputOTPGroup,
  InputOTPSeparator,
  InputOTPSlot,
} from "@/components/ui/input-otp.tsrx"

export default function InputOTPInvalidDemo() @{
  const [value, setValue] = useState("000000")

  <InputOTP maxLength={6} value={value} onChange={setValue}>
    <InputOTPGroup>
      <InputOTPSlot index={0} aria-invalid />
      <InputOTPSlot index={1} aria-invalid />
    </InputOTPGroup>
    <InputOTPSeparator />
    <InputOTPGroup>
      <InputOTPSlot index={2} aria-invalid />
      <InputOTPSlot index={3} aria-invalid />
    </InputOTPGroup>
    <InputOTPSeparator />
    <InputOTPGroup>
      <InputOTPSlot index={4} aria-invalid />
      <InputOTPSlot index={5} aria-invalid />
    </InputOTPGroup>
  </InputOTP>
}
