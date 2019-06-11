import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    console.log("autolaunch")
    document.getElementById('menu-item-edit-report').click();
  }
}

















