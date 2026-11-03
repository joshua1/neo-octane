// MDX pipeline for the docs. This replaces the velite collection used by the
// Next.js site: the same remark/rehype plugins run inside @octanejs/mdx, which
// compiles every .mdx document straight to an octane component module.
import fs from "node:fs"
import { defaultRemarkPlugins } from "@octanejs/mdx/compile"
import rehypeToc from "@stefanprobst/rehype-extract-toc"
import rehypeTocExtract from "@stefanprobst/rehype-extract-toc/mdx"
import rehypePrettyCode from "rehype-pretty-code"
import rehypeSlug from "rehype-slug"
import codeImport from "remark-code-import"
import { visit } from "unist-util-visit"

const theme = JSON.parse(fs.readFileSync("./src/data/theme.json", "utf-8"))

// Keeps the raw source of every code block on the <pre> so the copy button
// can copy it after rehype-pretty-code has tokenised the children.
const captureRawString = () => (tree: any) => {
  visit(tree, (node: any) => {
    if (node?.type === "element" && node?.tagName === "pre") {
      const [codeEl] = node.children
      if (codeEl?.tagName !== "code") return
      node.__rawstring__ = codeEl.children?.[0]?.value
    }
  })
}

const forwardRawString = () => (tree: any) => {
  visit(tree, (node: any) => {
    if (node?.type === "element" && node?.tagName === "figure") {
      if (!("data-rehype-pretty-code-figure" in node.properties)) return
      const preElement = node.children.at(-1)
      if (preElement?.tagName !== "pre") return
      preElement.properties["__rawstring__"] = node.__rawstring__
    }
  })
}

// Passing remarkPlugins replaces the defaults (GFM + frontmatter export),
// so they are spread back in first.
export const remarkPlugins = [
  ...(defaultRemarkPlugins ?? []),
  [codeImport, { removeRedundantIndentations: true, rootDir: process.cwd() }],
] as any[]

export const rehypePlugins = [
  rehypeSlug,
  rehypeToc,
  [rehypeTocExtract, { name: "toc" }],
  captureRawString,
  [
    rehypePrettyCode,
    {
      theme,
      keepBackground: false,
      onVisitLine(node: any) {
        if (node.children.length === 0) {
          node.children = [{ type: "text", value: " " }]
        }
      },
    },
  ],
  forwardRawString,
] as any[]
