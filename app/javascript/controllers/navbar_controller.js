import { Controller } from "stimulus"
// import Vue from 'vue/dist/vue.esm'

export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    // const app = new Vue({
    //   el: '#navbar',
    //   methods: {
    //     enterNavbar: () => {
    //       setTimeout(document.getElementById("navbar").classList.remove("minimized"), 20000)
    //       clearTimeout(this.hideNavbarTimeout)
    //     },
    //     leaveNavbar: () => {
    //       setTimeout(document.getElementById("navbar").classList.add("minimized"), 20000)
    //       clearTimeout(this.showNavbarTimeout)
    //     },
    //     expandMenu: () => {
    //       document.getElementById("navbar").classList.remove("minimized")
    //     },
    //     hideMenu: () => {
    //       document.getElementById("navbar").classList.add("minimized")
    //     }
    //   }
    // });
  }

  goFullscreen() {
    const elem = document.querySelector("html");
    if (elem.requestFullscreen) {
      elem.requestFullscreen();
    } else if (elem.mozRequestFullScreen) { /* Firefox */
      elem.mozRequestFullScreen();
    } else if (elem.webkitRequestFullscreen) { /* Chrome, Safari & Opera */
      elem.webkitRequestFullscreen();
    } else if (elem.msRequestFullscreen) { /* IE/Edge */
      elem.msRequestFullscreen();
    }
    document.getElementById('btn-exit-fullscreen').classList.remove('hidden')
    document.getElementById('btn-go-fullscreen').classList.add('hidden')
  }

  exitFullscreen() {
    if (document.exitFullscreen) {
      document.exitFullscreen();
    } else if (document.mozCancelFullScreen) { /* Firefox */
      document.mozCancelFullScreen();
    } else if (document.webkitExitFullscreen) { /* Chrome, Safari and Opera */
      document.webkitExitFullscreen();
    } else if (document.msExitFullscreen) { /* IE/Edge */
      document.msExitFullscreen();
    }
    document.getElementById('btn-exit-fullscreen').classList.add('hidden')
    document.getElementById('btn-go-fullscreen').classList.remove('hidden')
  }
}
