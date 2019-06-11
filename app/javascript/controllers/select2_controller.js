import { Controller } from "stimulus"
import 'select2/dist/css/select2.css';
import { initSelect2 } from '../components/init_select2';

export default class extends Controller {

  connect() {
    initSelect2();
  }
}
