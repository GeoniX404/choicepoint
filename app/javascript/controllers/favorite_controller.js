import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["save", "remove"]

  connect() {
    console.log("hello")
  }

  toggle(event) {

    let i = event.currentTarget.querySelector("i")
    console.log("i", i)
    if (i.classList.contains("fas")) {
      i.classList.remove("fas")
      i.classList.remove("cp-card-voted-color")
      i.classList.add("far")
      i.innerText = " Save"
    } else {
      i.classList.add("fas")
      i.classList.remove("cp-card-voted-color")
      i.classList.remove("far")
      i.innerText = " Saved"
    }
  }
}
