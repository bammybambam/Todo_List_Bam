import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  open(e) {
    e.preventDefault()
    this.containerTarget.classList.remove("hidden")
    document.body.style.overflow = "hidden"
  }

  close(e) {
    if (e) e.preventDefault()
    this.containerTarget.classList.add("hidden")
    document.body.style.overflow = "auto"
  }
}

