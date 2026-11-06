import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container"]

  open(event) {
    event.preventDefault()
    this.containerTarget.classList.add('is-active')
  }

  close(event) {
    event.preventDefault()
    this.containerTarget.classList.remove('is-active')
  }

  // Обработчик для клавиши Escape
  closeOnEscape(event) {
    if (event.key === "Escape") {
      this.close(event)
    }
  }
}
