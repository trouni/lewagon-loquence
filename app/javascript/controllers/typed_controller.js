import { Controller } from "stimulus"
import Typed from 'typed.js';

export default class extends Controller {
  static targets = ["focus"]

  connect() {
    new Typed('#report_name', {
      strings: ["Enter a name for your report..."],
      typeSpeed: 15,
      showCursor: true,
      startDelay: 500,
      attr: 'placeholder',
      loop: false
    })
    this.focusTarget.focus();
  }
}
