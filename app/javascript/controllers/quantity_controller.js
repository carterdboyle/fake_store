import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "add", "buy"];
  static values = { max: Number }

  connect() {
    this.update();
  }

  update() {
    let val = parseInt(this.inputTarget.value, 10);

    if (isNaN(val) || val < 0) val = 0;
    if (this.hasMaxValue && val > this.maxValue) val = this.maxValue;
    
    this.inputTarget.value = val;

    const valid = val >= 1 && val <= this.maxValue;

    this.addTarget.disabled = !valid;
    this.buyTarget.disabled = !valid;
  }
}