import { Controller } from "stimulus"
import Chart from 'chart.js';

export default class extends Controller {
  // static targets = [ "number" ]

  connect() {
    const element = this.context.scope.element.querySelector("[data-chartname]")
    if (element) {
      switch(element.dataset.chartname) {
        case "repeatCustomersChart":
          this.repeatCustomersChart();
          break;
      }
    }

  }

  repeatCustomersChart() {
    const canvas = document.getElementById("repeat_customers_chart");
    const cumulData = JSON.parse(canvas.dataset.cumul);
    const newCustomerData = JSON.parse(canvas.dataset.newcustomer);
    const repeatCustomerData = JSON.parse(canvas.dataset.repeatcustomer);

    var myChart = new Chart('repeat_customers_chart', {
      type: 'bar',
      data: {
        datasets: [{
          label: 'Total customers (cumul)',
          yAxisID: 'B',
          data: cumulData,
          borderColor: '#F4F4F4',
            // Changes this dataset to become a line
            type: 'line'
          }, {
            label: 'Fist time customers',
            yAxisID: 'A',
            data: newCustomerData,
            backgroundColor: '#AFCFEA',
          }, {
            label: 'Repeat customers',
            yAxisID: 'A',
            data: repeatCustomerData,
            backgroundColor: '#00D7C0',
          }],
          labels: ['January', 'February', 'March', 'April', 'Mai']
        },
        options: {
          scales: {
            yAxes: [
            {
              id: 'A',
              barPercentage: 0.5,
              type: 'linear',
              position: 'left',
              ticks: {
                max: 100,
                min: 0
              }
            }, {
              id: 'B',
              type: 'linear',
              position: 'right',
              ticks: {
                max: 100,
                min: 0
              }
            }]
          }
        }
      });
  }
}
