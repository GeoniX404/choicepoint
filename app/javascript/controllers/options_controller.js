import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["options", "form"]

connect() {
  console.log("Hello")
}

add(event) {
  console.log(event.currentTarget.id)
  const choicePointId = event.currentTarget.id
  const formCode = `<form class="simple_form new_option" data-options-target="form" id="new_option" novalidate="novalidate" action="/choice_points/${choicePointId}/options" accept-charset="UTF-8" method="post" wtx-context="C41976B0-83D1-4134-BA65-1DEDB6373E70"><input type="hidden" name="authenticity_token" value="4o7UQYSvDffB0ijNAN93NjdVEWb_0jaaALVwuvZeFFLDsyci8WMpsCVrl0iGWjnK3s_cXBqD9QIXUOoQdaSCXA" autocomplete="off" wtx-context="E12C7EE9-CDA6-4B86-99C7-33DE524880DB">
  <div class="option-description-container">
    <div class="mb-3 text required option_description"><textarea class="form-control text required" required="required" aria-required="true" placeholder="Option 1" name="option[description]" id="option_description"></textarea></div>
    <div class="mb-3 text required option_pros"><textarea class="form-control text required" required="required" aria-required="true" placeholder="What you like about it" name="option[pros]" id="option_pros"></textarea></div>
    <div class="mb-3 text required option_cons"><textarea class="form-control text required" required="required" aria-required="true" placeholder="What you do not like" name="option[cons]" id="option_cons"></textarea></div>
  </div>

  </form>`
  this.optionsTarget.insertAdjacentHTML("beforeend", formCode)
}
send() {
  this.formTargets.forEach(form => {
    form.submit()
  });
}

}
