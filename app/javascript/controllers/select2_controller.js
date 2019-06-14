import { Controller } from "stimulus"
import $ from 'jquery';
import 'select2';

export default class extends Controller {
  static targets = [ "clickOnChange" ]

  connect(event) {
    const select = this.context.scope.element.querySelector('.select2')
    const $el = $(select).select2({
      theme: "classic",
      width: "resolve"
    });
    $(select).select2('open');
    $el.on('change', () => {
      this.clickOnChangeTarget.click();
    });
  }
}
