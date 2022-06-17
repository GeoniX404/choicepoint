import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["save", "remove"]

  connect() {
    console.log("hello")
  }

  toggle(event) {

    let text = event.currentTarget.querySelector(".save-target")
    let i = event.currentTarget.querySelector("i")
    console.log(i)
    if (i.classList.contains("fas")) {
      i.classList.remove("fas")
      i.classList.add("far")
      text.innerText = " save"
    } else {
      i.classList.add("fas")
      i.classList.remove("far")
      text.innerText = "saved"
    }
  }
}
