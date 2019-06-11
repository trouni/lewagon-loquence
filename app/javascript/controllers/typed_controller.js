import { Controller } from "stimulus"
import Typed from 'typed.js';

export default class extends Controller {

  connect() {
    new Typed('#report_name', {
      strings: ["Type the name of your new report..."],
      typeSpeed: 15,
      showCursor: true,
      attr: 'placeholder',
      loop: false
    })
    document.getElementById('report_name').focus()
  }
}
