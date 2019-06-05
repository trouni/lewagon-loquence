import { Controller } from "stimulus"
import Chartkick from 'chartkick'
import Chart from 'chart.js'

export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    console.log("controller chartkick")
    window.Chartkick = Chartkick
    Chartkick.addAdapter(Chart)
    Chartkick.options = {
      library: {animation: {easing: 'easeOutQuart', backgroundColor: 'rgba(200,0,0,1)'}},
    }
  }
}
