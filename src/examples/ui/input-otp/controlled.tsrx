import { useState } from "octane"

import {
  InputOTP,
  InputOTPGroup,
  InputOTPSlot,
} from "@/components/ui/input-otp.tsrx"

export default function InputOTPControlledDemo() @{
  const [value, setValue] = useState("")

  <div class="space-y-2">
    <InputOTP
      maxLength={6}
      value={value}
      onChange={(value: string) => setValue(value)}
    >
      <InputOTPGroup>
        <InputOTPSlot index={0} />
        <InputOTPSlot index={1} />
        <InputOTPSlot index={2} />
        <InputOTPSlot index={3} />
        <InputOTPSlot index={4} />
        <InputOTPSlot index={5} />
      </InputOTPGroup>
    </InputOTP>
    <div class="text-center text-sm">
      @if (value === "") {
        <>Enter your one-time password.</>
      } @else {
        <>You entered: {value as string}</>
      }
    </div>
  </div>
}
