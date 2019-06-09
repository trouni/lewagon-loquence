import { Controller } from "stimulus"
require("selectables")
import { Selectables } from "selectables"

export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    const selectable = new Selectables({
      elements: '.grid-edit-item',
      selectedClass: 'active',
      zone: '#edit-report-layout',
      stop: function(e) {
        const selected = document.querySelectorAll('.active')
        selected.forEach((item) => {
          item.classList.remove('available')
        });
        const gridArea = `${selected[0].dataset["row"]} / ${selected[0].dataset["col"]} / ${parseInt(selected[selected.length - 1].dataset["row"]) + 1} / ${parseInt(selected[selected.length - 1].dataset["col"]) + 1}`
        document.getElementById('widget_grid_item_position').value = gridArea
        console.log(selected[0].dataset["row"]);
        console.log(selected[0].dataset["col"]);
        console.log(selected[selected.length - 1].dataset["row"]);
        console.log(selected[selected.length - 1].dataset["col"]);
      }
    });
  }
}
