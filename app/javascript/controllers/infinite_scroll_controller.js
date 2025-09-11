import { Controller } from "@hotwired/stimulus"

// Loads Turbo Streams when the sentinel enters the scroll container
export default class extends Controller {
  static values = { nextUrl: String, rootSelector: String }

  connect() {
    this.loading = false
    const root = this.rootSelectorValue ? document.querySelector(this.rootSelectorValue) : null

    this.observer = new IntersectionObserver(
      (entries) => entries.forEach((entry) => entry.isIntersecting && this.loadMore()),
      { root, rootMargin: "200px 0px" } // prefetch a bit early
    )

    this.observer.observe(this.element)
  }

  disconnect() {
    this.observer?.disconnect()
  }

  async loadMore() {
    if (this.loading || !this.nextUrlValue) return
    this.loading = true
    this.observer.unobserve(this.element)

    try {
      await new Promise(resolve => setTimeout(resolve, 5000))

      const res = await fetch(this.nextUrlValue, {
        headers: { Accept: "text/vnd.turbo-stream.html" },
        credentials: "same-origin",
      })
      const html = await res.text()
      Turbo.renderStreamMessage(html)
    } catch (e) {
      console.error("Infinite scroll fetch failed:", e)
      // allow retry after a short delay
      setTimeout(() => {
        this.loading = false
        this.observer.observe(this.element)
      }, 1500)
    }
  }
}
