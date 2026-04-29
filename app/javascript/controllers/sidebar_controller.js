import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    this.element.classList.toggle("translate-x-full")
    this.element.classList.toggle("translate-x-0")
  }
}