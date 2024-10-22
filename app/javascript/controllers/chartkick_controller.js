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
    const newAmazonCustomerData = JSON.parse(canvas.dataset.amazonnewcustomer);
    const repeatAmazonCustomerData = JSON.parse(canvas.dataset.amazonrepeatcustomer);
    const newShopifyCustomerData = JSON.parse(canvas.dataset.shopifynewcustomer);
    const repeatShopifyCustomerData = JSON.parse(canvas.dataset.shopifyrepeatcustomer);

    const widgetId = canvas.dataset.widgetid;
    const amazonSwitch = document.getElementById(`switch-amazon-${widgetId}`);
    const shopifySwitch = document.getElementById(`switch-shopify-${widgetId}`);
    document.querySelector(`#switch-amazon-${widgetId} input[type="checkbox"]`).checked = true;
    document.querySelector(`#switch-shopify-${widgetId} input[type="checkbox"]`).checked = true;

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
            label: 'Amazon - first time customers',
            stack: 'Stack 0',
            yAxisID: 'A',
            data: newAmazonCustomerData,
            backgroundColor: '#FED876',
          }, {
            label: 'Amazon - repeat customers',
            stack: 'Stack 0',
            yAxisID: 'A',
            data: repeatAmazonCustomerData,
            backgroundColor: '#FFD600',
          }, {
            label: 'Shopify - first time customers',
            stack: 'Stack 1',
            yAxisID: 'A',
            data: newShopifyCustomerData,
            backgroundColor: '#E5F0FF',
          }, {
            label: 'Shopify - repeat customers',
            stack: 'Stack 1',
            yAxisID: 'A',
            data: repeatShopifyCustomerData,
            backgroundColor: '#7EB3FF',
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
                max: 150,
                min: 0
              }
            }, {
              id: 'B',
              type: 'linear',
              position: 'right',
              ticks: {
                max: 150,
                min: 0
              }
            }]
          }
        }

      });

    const showEverything = (event) => {
      myChart.data.datasets = [{
        label: 'Total customers (cumul)',
        yAxisID: 'B',
        data: cumulData,
        borderColor: '#F4F4F4',
          // Changes this dataset to become a line
          type: 'line',
        }, {
          label: 'Amazon - first time customers',
          stack: 'Stack 0',
          yAxisID: 'A',
          data: newAmazonCustomerData,
          backgroundColor: '#FED876',
        }, {
          label: 'Amazon - repeat customers',
          stack: 'Stack 0',
          yAxisID: 'A',
          data: repeatAmazonCustomerData,
          backgroundColor: '#FFD600',
        }, {
          label: 'Shopify - first time customers',
          stack: 'Stack 1',
          yAxisID: 'A',
          data: newShopifyCustomerData,
          backgroundColor: '#E5F0FF',
        }, {
          label: 'Shopify - repeat customers',
          stack: 'Stack 1',
          yAxisID: 'A',
          data: repeatShopifyCustomerData,
          backgroundColor: '#7EB3FF',
        }]
        myChart.update();
        document.querySelector(`#switch-amazon-${widgetId} input[type="checkbox"]`).checked = true
        document.querySelector(`#switch-shopify-${widgetId} input[type="checkbox"]`).checked = true
      }

    const showOnlyAmazon = (event) => {
      myChart.data.datasets = [{
          label: 'Total customers (cumul)',
          yAxisID: 'B',
          data: cumulData,
          borderColor: '#F4F4F4',
            // Changes this dataset to become a line
            type: 'line',
          }, {
            label: 'Amazon - first time customers',
            stack: 'Stack 0',
            yAxisID: 'A',
            data: newAmazonCustomerData,
            backgroundColor: '#FED876',
          }, {
            label: 'Amazon - repeat customers',
            stack: 'Stack 0',
            yAxisID: 'A',
            data: repeatAmazonCustomerData,
            backgroundColor: '#FFD600',
          }];
      myChart.update();
      document.querySelector(`#switch-amazon-${widgetId} input[type="checkbox"]`).checked = true
      document.querySelector(`#switch-shopify-${widgetId} input[type="checkbox"]`).checked = false
    }


    const showOnlyShopify = (event) => {
      myChart.data.datasets = [{
          label: 'Total customers (cumul)',
          yAxisID: 'B',
          data: cumulData,
          borderColor: '#F4F4F4',
            // Changes this dataset to become a line
            type: 'line',
          }, {
            label: 'Shopify - first time customers',
            stack: 'Stack 1',
            yAxisID: 'A',
            data: newShopifyCustomerData,
            backgroundColor: '#E5F0FF',
          }, {
            label: 'Shopify - repeat customers',
            stack: 'Stack 1',
            yAxisID: 'A',
            data: repeatShopifyCustomerData,
            backgroundColor: '#7EB3FF',
      }];
      myChart.update();
      document.querySelector(`#switch-amazon-${widgetId} input[type="checkbox"]`).checked = false
      document.querySelector(`#switch-shopify-${widgetId} input[type="checkbox"]`).checked = true
    }

    shopifySwitch.addEventListener("click", (event) => {
      if (document.querySelector(`#switch-amazon-${widgetId} input[type="checkbox"]`).checked === true &&
        document.querySelector(`#switch-shopify-${widgetId} input[type="checkbox"]`).checked === true) {
        showOnlyAmazon()
      } else {
        showEverything()
      }
      //update chart
    });

    amazonSwitch.addEventListener("click", (event) => {
      if (document.querySelector(`#switch-shopify-${widgetId} input[type="checkbox"]`).checked === true &&
        document.querySelector(`#switch-amazon-${widgetId} input[type="checkbox"]`).checked === true) {
        showOnlyShopify()
      } else {
        showEverything()
      }
      //update chart
    });
    // shopifySwitch.addEventListener("click", (event) => {
    //   myChart.data.datasets = [{
    //       label: 'Total customers (cumul)',
    //       yAxisID: 'B',
    //       data: cumulData,
    //       borderColor: '#F4F4F4',
    //         // Changes this dataset to become a line
    //         type: 'line',
    //       }, {
    //         label: 'Shopify - first time customers',
    //         stack: 'Stack 1',
    //         yAxisID: 'A',
    //         data: newShopifyCustomerData,
    //         backgroundColor: '#E5F0FF',
    //       }, {
    //         label: 'Shopify - repeat customers',
    //         stack: 'Stack 1',
    //         yAxisID: 'A',
    //         data: repeatShopifyCustomerData,
    //         backgroundColor: '#7EB3FF',
    //   }];
    //   myChart.update();
    // });

  }
}
