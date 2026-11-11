import { Controller } from "@hotwired/stimulus"
// Надо подумать над названием контроллера. Сейчас он используется в ключах и переводах, 
// но хотелось бы чтобы он обрабатывал все филььтры
export default class extends Controller {
  static values = { delay: { type: Number, default: 300 } }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, this.delayValue)
  }

  submitNow() {
    clearTimeout(this.timeout)
    this.element.requestSubmit()
  }
}
