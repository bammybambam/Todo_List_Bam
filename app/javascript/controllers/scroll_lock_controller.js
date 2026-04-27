import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  scrollPos = 0

  connect() {
    this.lockBound = this.lock.bind(this)
    document.addEventListener("turbo:before-stream-render", this.lockBound)
  }

  disconnect() {
    document.removeEventListener("turbo:before-stream-render", this.lockBound)
  }

  lock(event) {
    this.scrollPos = window.scrollY

    document.body.style.top = `-${this.scrollPos}px`
    document.body.style.position = 'fixed'
    document.body.style.width = '100%'

    const originalRender = event.detail.render
    event.detail.render = (streamElement) => {
      originalRender(streamElement)
      
      requestAnimationFrame(() => {
        document.body.style.position = ''
        document.body.style.top = ''
        document.body.style.width = ''
        window.scrollTo(0, this.scrollPos)
      })
    }
  }
}