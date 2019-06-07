import Chart from 'chart.js';

const repeat_customers_chart = () => {

  const canvas = document.getElementById("repeat_customers_chart");
  const cumulData = JSON.parse(canvas.dataset.cumul);
  const newCustomerData = JSON.parse(canvas.dataset.newcustomer);
  const repeatCustomerData = JSON.parse(canvas.dataset.repeatcustomer);

  var myChart = new Chart('repeat_customers_chart', {
      type: 'bar',
      data: {
        datasets: [{
            label: 'Fist time customers',
            yAxisID: 'A',
            data: newCustomerData,
            backgroundColor: '#1EDD88',
        }, {
            label: 'Repeat customers',
            yAxisID: 'A',
            data: repeatCustomerData,
            backgroundColor: '#167FFB',
        }, {
            label: 'Total customers (cumul)',
            yAxisID: 'B',
            data: cumulData,
            borderColor: '#F4F4F4',
            // Changes this dataset to become a line
            type: 'line'
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
                      max: 70,
                      min: 0
                    }
                  }, {
                    id: 'B',
                    type: 'linear',
                    position: 'right',
                    ticks: {
                      max: 250,
                      min: 0
                    }
                  }]
                }
      }
});

};

export default repeat_customers_chart;
