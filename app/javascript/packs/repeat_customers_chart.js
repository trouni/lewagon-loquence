import Chart from 'chart.js';

const repeat_customers_chart = () => {

  const canvas = document.getElementById("repeat_customers_chart");
  const orderData = JSON.parse(canvas.dataset.order);

  var myChart = new Chart('repeat_customers_chart', {
      type: 'bar',
      data: {
        datasets: [{
            label: 'Bar Dataset',
            data: orderData
        }, {
            label: 'Line Dataset',
            data: [20, 30, 35, 12],

            // Changes this dataset to become a line
            type: 'line'
        }],
        labels: ['January', 'February', 'March', 'April']
      },
      options: {
          scales: {
              yAxes: [{
                  ticks: {
                      beginAtZero: true
                  }
              }]
          }
      }
  });

};

export default repeat_customers_chart;
