Chartkick.options = {
  colors: ['#00D7C0', '#F6DD27', '#FE864E', '#DB1271', '#8A4BFF'],
  library: {
    mapsApiKey: ENV['GOOGLE_MAPS_API_KEY'],
    animation: {
      duration: 1500,
      easing: 'easeOutQuad'
    },
    chart: {
      backgroundColor: {
        linearGradient: { x1: 0, y1: 0, x2: 1, y2: 1 },
        stops: [
          [0, '#2a2a2b'],
          [1, '#3e3e40']
        ]
      },
      style: {
        fontFamily: '\'Unica One\', sans-serif'
      },
      plotBorderColor: '#F3F4F8'
    },
    backgroundColor: 'transparent',
    title: {
      style: {
        color: '#F3F4F8',
        textTransform: 'uppercase',
        fontSize: '20px'
      }
    },
    subtitle: {
      style: {
        color: '#F3F4F8',
        textTransform: 'uppercase'
      }
    },
    xAxis: {
      gridLineColor: '#E9E9F2',
      labels: {
        style: {
          color: '#F3F4F8'
        }
      },
      lineColor: '#E9E9F2',
      minorGridLineColor: '#E9E9F2',
      tickColor: '#E9E9F2',
      title: {
        style: {
          color: '#A0A0A3'

        }
      }
    },
    yAxis: {
      gridLineColor: '#E9E9F2',
      labels: {
        style: {
          color: '#F3F4F8'
        }
      },
      lineColor: '#E9E9F2',
      minorGridLineColor: '#E9E9F2',
      tickColor: '#E9E9F2',
      tickWidth: 1,
      title: {
        style: {
          color: '#A0A0A3'
        }
      }
    },
    vAxis: {
      baselineColor: "#F3F4F8",
      gridlines: {
        color: ""
      },
      textStyle: {
        color: "#76BDD1"
      },
      titleTextStyle: {
        color: "#F76161"
      }
    },
    hAxis: {
      baselineColor: "#F3F4F8",
      gridlines: {
        color: ""
      },
      textStyle: {
        color: "#76BDD1"
      },
      titleTextStyle: {
        color: "#F76161"
      },
      tooltip: {
        backgroundColor: 'rgba(0, 0, 0, 0.85)',
        style: {
          color: '#F0F0F0'
        }
      }
    },
    plotOptions: {
      series: {
        dataLabels: {
          color: '#F0F0F3',
          style: {
            fontSize: '13px'
          }
        },
        marker: {
          lineColor: '#333'
        }
      },
      boxplot: {
        fillColor: '#505053'
      },
      candlestick: {
        lineColor: 'white'
      },
      errorbar: {
        color: 'white'
      }
    },
    legend: {
      backgroundColor: 'rgba(0, 0, 0, 0.5)',
      itemStyle: {
        color: '#F3F4F8'
      },
      itemHoverStyle: {
        color: '#FFF'
      },
      itemHiddenStyle: {
        color: '#C2C4CB'
      },
      title: {
        style: {
          color: '#C0C0C0'
        }
      }
    },
    credits: {
      style: {
        color: '#666'
      }
    },
    labels: {
      style: {
        color: '#E9E9F2'
      }
    },

    drilldown: {
      activeAxisLabelStyle: {
        color: '#F0F0F3'
      },
      activeDataLabelStyle: {
        color: '#F0F0F3'
      }
    },

    navigation: {
      buttonOptions: {
        symbolStroke: '#DDDDDD',
        theme: {
          fill: '#505053'
        }
      }
    },

    # scroll charts
    rangeSelector: {
      buttonTheme: {
        fill: '#505053',
        stroke: '#000000',
        style: {
          color: '#CCC'
        },
        states: {
          hover: {
            fill: '#E9E9F2',
            stroke: '#000000',
            style: {
              color: 'white'
            }
          },
          select: {
            fill: '#000003',
            stroke: '#000000',
            style: {
              color: 'white'
            }
          }
        }
      },
      inputBoxBorderColor: '#505053',
      inputStyle: {
        backgroundColor: '#333',
        color: 'silver'
      },
      labelStyle: {
        color: 'silver'
      }
    },

    navigator: {
      handles: {
        backgroundColor: '#666',
        borderColor: '#AAA'
      },
      outlineColor: '#CCC',
      maskFill: 'rgba(255,255,255,0.1)',
      series: {
        color: '#7798BF',
        lineColor: '#A6C7ED'
      },
      xAxis: {
        gridLineColor: '#505053'
      }
    },

    scrollbar: {
      barBackgroundColor: '#808083',
      barBorderColor: '#808083',
      buttonArrowColor: '#CCC',
      buttonBackgroundColor: '#C2C4CB',
      buttonBorderColor: '#C2C4CB',
      rifleColor: '#FFF',
      trackBackgroundColor: '#404043',
      trackBorderColor: '#404043'
    }
  }
}
