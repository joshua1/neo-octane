import { REGEXP_ONLY_DIGITS } from "@octanejs/input-otp"

import {
  InputOTP,
  InputOTPGroup,
  InputOTPSlot,
} from "@/components/ui/input-otp.tsrx"

export default function InputOTPFourDigitsDemo() @{
  <InputOTP maxLength={4} pattern={REGEXP_ONLY_DIGITS}>
    <InputOTPGroup>
      <InputOTPSlot index={0} />
      <InputOTPSlot index={1} />
      <InputOTPSlot index={2} />
      <InputOTPSlot index={3} />
    </InputOTPGroup>
  </InputOTP>
}
