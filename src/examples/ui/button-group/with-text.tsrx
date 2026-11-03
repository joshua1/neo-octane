import { Button } from "@/components/ui/button.tsrx"
import { ButtonGroup, ButtonGroupText } from "@/components/ui/button-group.tsrx"

export default function ButtonGroupWithTextDemo() @{
  <ButtonGroup>
    <ButtonGroupText>Text</ButtonGroupText>
    <Button variant="neutral">Another Button</Button>
  </ButtonGroup>
}
