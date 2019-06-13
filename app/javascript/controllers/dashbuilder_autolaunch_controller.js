import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    document.getElementById('edit-report-link').click();
  }
}
