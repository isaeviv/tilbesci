import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notice", "alert"]

  closeNotice(event) {
    event.preventDefault()
    this.noticeTarget.classList.add('is-hidden')
  }

  closeAlert(event) {
    event.preventDefault()
    this.alertTarget.classList.add('is-hidden')
  }

}
