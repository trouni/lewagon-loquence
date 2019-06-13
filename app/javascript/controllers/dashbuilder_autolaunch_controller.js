import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    document.getElementById('menu-item-edit-report').click();
  }
}
