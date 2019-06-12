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
            type: 'line',
          }, {
            label: 'other',
            stack: 'Stack 0',
            yAxisID: 'A',
            data: newCustomerData,
            backgroundColor: '#333370',
          }, {
            label: 'other 2',
            stack: 'Stack 0',
            yAxisID: 'A',
            data: newCustomerData,
            backgroundColor: '#333390',
          }, {
            label: 'Fist time customers',
            stack: 'Stack 1',
            yAxisID: 'A',
            data: newCustomerData,
            backgroundColor: '#AFCFEA',
          }, {
            label: 'Repeat customers',
            stack: 'Stack 1',
            yAxisID: 'A',
            data: repeatCustomerData,
            backgroundColor: '#00D7C0',
          }],
          labels: ['January', 'February', 'March', 'April', 'Mai']
        },
        options: {
          scales: {
            xAxes: [{
              stacked: true
            }],
            yAxes: [
            {
              id: 'A',
              stacked: 'true',
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
