import { Controller } from "@hotwired/stimulus"

// data-controller="flash" data-flash-dismiss-after-value="5000"
export default class extends Controller {
  static values = { dismissAfter: { type: Number, default: 4000 } }

  connect() {
    // Fade in
    requestAnimationFrame(() => {
      this.element.classList.remove("opacity-0", "translate-y-2")
      this.element.classList.add("opacity-100", "translate-y-0")
    })

    // Auto-dismiss
    this.timeout = setTimeout(() => this.leave(), this.dismissAfterValue)
  }

  disconnect() { clearTimeout(this.timeout) }

  close() { this.leave() }

  leave() {
    this.element.classList.add("opacity-0", "translate-y-2")
    setTimeout(() => this.element.remove(), 200) // match duration-200
  }
}