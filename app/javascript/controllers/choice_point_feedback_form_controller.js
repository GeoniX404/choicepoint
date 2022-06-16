import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "container"]

  update(event) {
    console.log("I'm here!!!")
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "PATCH",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        this.containerTarget.outerHTML = data
      })
  }
}
