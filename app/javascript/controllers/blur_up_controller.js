import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["overlay"]

  connect() {
    const img = this.element.querySelector("img");
    if (img?.complete) this.reveal({ target: img });
  }
  reveal(event) {
    const img = event.target
    img.classList.remove("opacity-0", "blur-lg")
    if (this.hasOverlayTarget) {
      this.overlayTarget.classList.add("opacity-0");
      setTimeout(() => this.overlayTarget.classList.add("hidden"), 300)
    }
  }
}