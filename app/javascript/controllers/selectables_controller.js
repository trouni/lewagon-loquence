import { Controller } from "stimulus"
import { Selectables } from "selectables"

export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    const selectable = new Selectables({
      elements: '.grid-item',
      selectedClass: 'active',
      zone: '#edit-report-layout',
      stop: function(e) {
        const selected = document.querySelectorAll('.active')
        selected.forEach((item) => {
          item.classList.remove('available')
        });
        console.log(selected[0]);
        console.log(selected[selected.length - 1]);
      }
    });
  }
}
