import { Controller } from "stimulus"

export default class extends Controller {
  // static targets = [ "number" ]

  connect() {
    const categories = document.querySelectorAll('.category');

    const toggleActiveClass = (event) => {
      event.currentTarget.classList.toggle('active');
    };

    const toggleActiveOnClick = (category) => {
      category.addEventListener('click', toggleActiveClass);
    };

    categories.forEach(toggleActiveOnClick);
  }
}
