import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "gridEditItem" ]

  connect() {
    let selecting = false
    const grid = document.querySelector(".grid-layout");

    const isSelectable = () => {
      return document.getElementById("new-widget-blueprint") === null
    }

    const resetGrid = () => {
      items.forEach(item => item.classList.remove('active'))
    }

    const removeKPISelectorDiv = () => {
      document.getElementById("new-widget-blueprint").remove();
    }
    const escapeKPISelectorDiv = (event) => {
      if (event.key === 'Escape') {
        removeKPISelectorDiv();
        window.removeEventListener("keyup", escapeKPISelectorDiv)
      }
    }

    const insertKPISelectorDiv = (gridArea) => {
      // creating the new widget blueprint div
      const KPISelectorDiv = document.getElementById("new-widget-template").cloneNode(true);
      KPISelectorDiv.style.gridArea = gridArea;
      KPISelectorDiv.id = "new-widget-blueprint";
      KPISelectorDiv.classList.remove('hidden');

      // inserting new div before the first grid-edit-item
      const firstGridEditItem = document.querySelector(".grid-edit-item");
      grid.insertBefore(KPISelectorDiv, firstGridEditItem);

      // select newly created div
      const widgetBlueprint = document.getElementById("new-widget-blueprint");
      // set grid-area in the hidden form
      widgetBlueprint.querySelector('#widget_grid_item_position').value = gridArea;
      // set focus to the select field
      widgetBlueprint.querySelector('#widget_kpi_id').focus();

      resetGrid();

      const closeBtn = document.querySelector("#new-widget-blueprint .btn-close")
      closeBtn.addEventListener("click", event => removeKPISelectorDiv())
      window.addEventListener("keyup", escapeKPISelectorDiv)
    }

    const widgetArea = (fromItem, toItem) => {
      return (Math.abs(fromItem[0] - toItem[0]) + 1) * (Math.abs(fromItem[1] - toItem[1]) + 1)
    }

    const items = this.gridEditItemTargets
    let fromItem
    items.forEach((item) => {
      item.addEventListener('mousedown', (event) => {
        if (isSelectable()) {
          selecting = true
          event.target.classList.add('active')
          fromItem = [event.target.dataset['row'], event.target.dataset['col']]
        }
      })
      item.addEventListener('mouseenter', (event) => {
        if (selecting) {
          resetGrid()
          const currentItem = [event.target.dataset['row'], event.target.dataset['col']]
          let row, col
          for (row = Math.min(fromItem[0], currentItem[0]); row <= Math.max(fromItem[0], currentItem[0]); row += 1) {
            for (col = Math.min(fromItem[1], currentItem[1]); col <= Math.max(fromItem[1], currentItem[1]); col += 1) {
              document.querySelector(`[data-row="${row}"][data-col="${col}"]`).classList.add('active')
            }
          }
        }
      })
      item.addEventListener('mouseup', (event) => {
        if (selecting) {
          const toItem = [event.target.dataset['row'], event.target.dataset['col']]
          const gridArea = `${Math.min(fromItem[0], toItem[0])} / ${Math.min(fromItem[1], toItem[1])} / ${parseInt(Math.max(fromItem[0], toItem[0])) + 1} / ${parseInt(Math.max(fromItem[1], toItem[1])) + 1}`
          resetGrid()
          selecting = false
          if (widgetArea(fromItem, toItem) >= 4) {
            insertKPISelectorDiv(gridArea);
          }
        }
      })
    })
  }

  newWidgetSubmit() {
    document.querySelector("#new_widget input[type='submit']").click();
  }

  launchBuilder() {

  }
}

















