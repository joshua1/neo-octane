// GitHub star count for the navbar. The Next.js navbar was an async server
// component fetching with `cache: "force-cache"`; here it is a server
// function (GH_API_KEY never reaches the client) called from the root route
// loader, with an in-memory cache standing in for Next's fetch cache.
import { createServerFn } from "@octanejs/tanstack-start"

const REPO_URL = "https://api.github.com/repos/ekmas/neobrutalism-components"
const TTL_MS = 60 * 60 * 1000

let cached: { value: string | null; at: number } | undefined

export const getStarsCount = createServerFn({ method: "GET" }).handler(
  async (): Promise<string | null> => {
    if (cached && Date.now() - cached.at < TTL_MS) return cached.value

    const headers: Record<string, string> = {
      "X-GitHub-Api-Version": "2022-11-28",
    }
    if (process.env.GH_API_KEY) {
      headers.Authorization = `Bearer ${process.env.GH_API_KEY}`
    }

    let value: string | null = null
    try {
      const res = await fetch(REPO_URL, { headers })
      if (res.ok) {
        const repo = (await res.json()) as { stargazers_count: number }
        value = (repo.stargazers_count / 1000).toFixed(1) + "k"
      }
    } catch {
      value = null
    }

    // Keep a failed lookup only briefly so a transient error is retried.
    cached = { value, at: value ? Date.now() : Date.now() - TTL_MS + 60_000 }
    return value
  },
)
