import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "voteButton"]

  enableVoteButton() {
    this.voteButtonTarget.removeAttribute("disabled")
  }

  update(event) {
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
    .then(response => response.text())
    .then((data) => {
      this.formTarget.outerHTML = data
    })
  }
}
