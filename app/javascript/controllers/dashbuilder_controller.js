import { Controller } from "stimulus"
// import { initSelect2 } from '../components/init_select2';

export default class extends Controller {
  static targets = [ "gridEditItem" ]

  connect() {
    let selecting = false

    this.setEditSwitchOn()

    const firstWidgetNotice = document.getElementById('notice-first-widget')
    const items = this.gridEditItemTargets
    let fromItem
    items.forEach((item) => {
      item.addEventListener('mousedown', (event) => {
        if (firstWidgetNotice) {
          firstWidgetNotice.classList.add("transparent");
        }
        if (this.isSelectable()) {
          selecting = true
          event.target.classList.add('active')
          fromItem = [event.target.dataset['row'], event.target.dataset['col']]
        }
      })
      item.addEventListener('mouseenter', (event) => {
        if (selecting) {
          this.resetGrid()
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
          let colspan = Math.abs(fromItem[0] - toItem[0]) + 1
          let rowspan = Math.abs(fromItem[1] - toItem[1]) + 1
          const gridArea = `${Math.min(fromItem[0], toItem[0])} / ${Math.min(fromItem[1], toItem[1])} / span ${colspan} / span ${rowspan}`
          this.resetGrid()
          selecting = false
          if (this.widgetArea(fromItem, toItem) >= 4) {
            this.insertKPISelectorDiv(gridArea);
          }
        }
      })
    })
    window.addEventListener("keyup", () => { this.escapeKPISelectorDiv() });
  }

  setEditSwitchOn() {
    document.querySelector('#floating-button-edit-report input[type="checkbox"]').checked = true
    document.getElementById('editFloatingButton').classList.add('show')
  }

  newWidgetSubmit() {
    const KPISelectorDiv = document.getElementById("new-widget-blueprint");
    document.getElementById('replacing_widget_id').value = KPISelectorDiv.dataset["replacingWidgetId"];
    document.querySelector("#new_widget input[type='submit']").click();
  }

  editWidget() {
    if (this.isSelectable()) {
      const widgetToEdit = document.querySelector(`[data-widget-id="${event.target.dataset["widgetId"]}"].grid-item`);
      widgetToEdit.classList.add('hidden');
      // this.insertKPISelectorDiv(widgetToEdit.style.gridArea, widgetToEdit.dataset["widgetId"]);
    }
  }

  resetGrid() {
    const items = this.gridEditItemTargets
    items.forEach(item => item.classList.remove('active'))
  }

  widgetArea(fromItem, toItem) {
      return (Math.abs(fromItem[0] - toItem[0]) + 1) * (Math.abs(fromItem[1] - toItem[1]) + 1)
  }

  insertKPISelectorDiv(gridArea, replacingWidgetId = null) {
    // creating the new widget blueprint div
    const newWidgetTemplate = document.getElementById("new-widget-template");
    // newWidgetTemplate.classList.add("select2");
    const KPISelectorDiv = newWidgetTemplate.cloneNode(true);
    KPISelectorDiv.id = "new-widget-blueprint";
    // newWidgetTemplate.classList.remove("select2");
    KPISelectorDiv.style.gridArea = gridArea;
    KPISelectorDiv.classList.remove('hidden');
    KPISelectorDiv.dataset.controller = 'select2';
    if (replacingWidgetId) {
      KPISelectorDiv.dataset.replacingWidgetId = replacingWidgetId;
    }

    // inserting new div before the first grid-edit-item
    const firstGridEditItem = document.querySelector(".grid-edit-item");
    const grid = document.querySelector(".grid-layout");
    grid.insertBefore(KPISelectorDiv, firstGridEditItem);

    // select newly created div
    const widgetBlueprint = document.getElementById("new-widget-blueprint");
    // set grid-area in the hidden form
    widgetBlueprint.querySelector('#widget_grid_item_position').value = gridArea;


    this.resetGrid();

    const closeBtn = document.querySelector("#new-widget-blueprint .btn-close");
    closeBtn.addEventListener("click", (event) => {
      this.removeKPISelectorDiv();
    });
  }

  isSelectable() {
    return document.getElementById("new-widget-blueprint") === null
  }

  escapeKPISelectorDiv() {
    const KPISelectorDiv = document.getElementById("new-widget-blueprint");
    if (event.key === 'Escape' && KPISelectorDiv) {
      this.removeKPISelectorDiv();
    }
  }

  removeKPISelectorDiv() {
    const KPISelectorDiv = document.getElementById("new-widget-blueprint");
    KPISelectorDiv.remove()

    if (KPISelectorDiv.dataset["replacingWidgetId"]) {
      document.querySelector(`[data-widget-id="${KPISelectorDiv.dataset["replacingWidgetId"]}"].grid-item`).classList.remove('hidden');
    }
  }

  disconnect() {
    // Remove Editing Grid
    const removeEditGrid = () => {
      const grid = document.querySelector('.grid-layout')
      // grid.removeAttribute('data-controller')
      grid.classList.remove('edit')
      grid.querySelectorAll('.grid-edit-item').forEach(el => el.remove())
      // Removes existing blueprint if any
      const newWidgetBlueprint = document.getElementById('new-widget-blueprint')
      if (newWidgetBlueprint) { newWidgetBlueprint.remove() }
      // Removes hidden template
      const newWidgetTemplate = document.getElementById('new-widget-template')
      if (newWidgetTemplate) { newWidgetTemplate.remove() }
    }
    removeEditGrid()
    document.querySelector('#floating-button-edit-report input[type="checkbox"]').checked = false
    setTimeout(() => {document.getElementById('editFloatingButton').classList.remove('show')}, 800)
  }
}

















