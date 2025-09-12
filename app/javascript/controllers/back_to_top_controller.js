// app/javascript/controllers/back_to_top_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]
  static values = {
    offset: { type: Number, default: 300 } // px before showing the button
  }

  connect() {
    this.onScroll = this.onScroll.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.onScroll()
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }

  onScroll() {
    const y = window.scrollY || window.pageYOffset
    if (!this.hasButtonTarget) return
    this.buttonTarget.classList.toggle("hidden", y < this.offsetValue)
  }

  scroll() {
    window.scrollTo({ top: 0, behavior: "smooth" })
  }
}
