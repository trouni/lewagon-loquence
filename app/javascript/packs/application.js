import "bootstrap";

import "controllers";
import repeat_customers_chart from "./repeat_customers_chart.js";

const canvas = document.getElementById("repeat_customers_chart");
if (canvas) {
  repeat_customers_chart();
}
