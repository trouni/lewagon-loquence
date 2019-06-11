import $ from 'jquery';
import 'select2';

const initSelect2 = (selector = ".select2") => {
  const selects = document.querySelectorAll(selector);
  console.log(selects);
  let count = 0;
  selects.forEach((el) => {
    el.id += `_${count}`;
    const $el = $(el).select2();
    $el.on('change', () => {
      document.querySelector("#new_widget input[type='submit']").click();
      // setTimeout(initSelect2, 5000);
    });
    count += 1;
  });
};

export { initSelect2 };
