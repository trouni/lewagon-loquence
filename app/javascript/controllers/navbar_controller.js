import { Controller } from "stimulus"

export default class extends Controller {
  // static targets = [ "output" ]

  toggleExpand() {
    document.getElementById("navbar").classList.toggle("minimized")
  }
}
