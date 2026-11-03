import { CheckCircle2Icon } from "@octanejs/lucide"

import { useState } from "octane"

import { getPalette } from "@/data/colors"

import {
  Accordion,
  AccordionContent,
  AccordionItem,
  AccordionTrigger,
} from "@/components/ui/accordion.tsrx"
import { Alert, AlertDescription, AlertTitle } from "@/components/ui/alert.tsrx"
import { Badge } from "@/components/ui/badge.tsrx"
import { Button } from "@/components/ui/button.tsrx"
import {
  Select,
  SelectContent,
  SelectGroup,
  SelectItem,
  SelectLabel,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select.tsrx"

const previewStyling = [
  {
    name: "blue",
    rounded: "rounded-[5px]!",
    boxShadow: "4px 4px 0 0 rgba(0,0,0,1)",
  },
  {
    name: "green",
    rounded: "rounded-[15px]!",
    boxShadow: "0 4px 0 0 rgba(0,0,0,1)",
  },
  {
    name: "orange",
    rounded: "rounded-[10px]!",
    boxShadow: "-4px -4px 0 0 rgba(0,0,0,1)",
  },
  {
    name: "violet",
    rounded: "rounded-none!",
    boxShadow: "4px -4px 0 0 rgba(0,0,0,1)",
  },
].map((item) => {
  const palette = getPalette("monochromatic", item.name)!
  return { ...item, main: palette.main, bg: palette.bg }
})

export default function StylingCustomizer() @{
  const [{ main, bg, rounded, boxShadow }, setStyling] = useState(
    previewStyling[0],
  )

  const mainStyle = { backgroundColor: main }

  <div class="mx-auto max-w-[800px] w-full mt-20 sm:px-5 px-0">
    <div class="grid md:gap-10 gap-5">
      <div class="grid md:grid-cols-4 sm:grid-cols-2 grid-cols-2 gap-4 sm:w-full w-2/3 mx-auto">
        @for (const color of previewStyling; key color.name) {
          <Button
            class="h-full border-2 border-border md:text-xl sm:text-sm text-xs sm:px-4 px-2"
            style={{ backgroundColor: color.main }}
            onClick={() => setStyling(color)}
          >
            {"try " + color.name}
          </Button>
        }
      </div>
      <div
        style={{ backgroundColor: bg }}
        class="sm:border-x-2 border-x-0 border-y-2 sm:shadow-shadow shadow-none flex flex-col justify-between sm:p-8 p-4 border-border h-[350px] bg-[linear-gradient(to_right,#80808033_1px,transparent_1px),linear-gradient(to_bottom,#80808033_1px,transparent_1px)] bg-[size:30px_30px] transition-colors duration-200"
      >
        <Alert
          style={{ ...mainStyle, boxShadow }}
          class={`${rounded} transition-all duration-200`}
        >
          <CheckCircle2Icon />
          <AlertTitle>Success! Your changes have been saved</AlertTitle>
          <AlertDescription>
            This is an alert with icon, title and description.
          </AlertDescription>
        </Alert>

        <Accordion defaultValue={["item-1"]}>
          <AccordionItem
            style={{ boxShadow }}
            class={`${rounded} transition-all duration-200`}
            value="item-1"
          >
            <AccordionTrigger style={mainStyle}>
              Is it accessible?
            </AccordionTrigger>
            <AccordionContent>
              Yes. It adheres to the WAI-ARIA design pattern.
            </AccordionContent>
          </AccordionItem>
        </Accordion>

        <div class="flex items-center justify-between gap-2">
          <Button
            style={{ ...mainStyle, boxShadow }}
            class={`${rounded} transition-all duration-200 pointer-events-none`}
            size="sm"
          >
            Button
          </Button>
          <Button
            variant="noShadow"
            style={mainStyle}
            class={`${rounded} transition-all duration-200`}
            size="sm"
          >
            Button
          </Button>
          <Badge
            style={mainStyle}
            class={`${rounded} transition-all hidden md:block duration-200`}
          >
            Badge
          </Badge>

          <div class="hidden sm:block">
            <Select
              items={{
                apple: "Apple",
                banana: "Banana",
                blueberry: "Blueberry",
                grapes: "Grapes",
              }}
            >
              <SelectTrigger
                style={mainStyle}
                class={`${rounded} w-[180px] transition-all duration-200`}
              >
                <SelectValue placeholder="Select a fruit" />
              </SelectTrigger>
              <SelectContent
                style={mainStyle}
                class={`${rounded} transition-all duration-200`}
              >
                <SelectGroup>
                  <SelectLabel>Fruits</SelectLabel>
                  <SelectItem class={`${rounded}`} value="apple">
                    Apple
                  </SelectItem>
                  <SelectItem class={`${rounded}`} value="banana">
                    Banana
                  </SelectItem>
                  <SelectItem class={`${rounded}`} value="blueberry">
                    Blueberry
                  </SelectItem>
                  <SelectItem class={`${rounded}`} value="grapes">
                    Grapes
                  </SelectItem>
                </SelectGroup>
              </SelectContent>
            </Select>
          </div>
        </div>
      </div>
    </div>
  </div>
}
