import { Controller } from "stimulus"
import $ from 'jquery';

export default class extends Controller {

  connect() {
    document.onfullscreenchange = (event) => {
      this.toggleScreenButtonStatus();
    }
    if (this.data.get('expanded') == 0) {
      document.getElementById('navbar').classList.remove('expanded');
    }

    // Initialize Bootstrap tootips
    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })
  }

  expandedNavbar() {
    document.getElementById('navbar').classList.add('expanded');
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
  }

  toggleFullscreen() {
    if( (screen.availHeight || screen.height-30) <= window.innerHeight) {
      this.exitFullscreen()
    } else {
      this.goFullscreen()
    }
  }

  toggleScreenButtonStatus() {
    if( (screen.availHeight || screen.height-30) <= window.innerHeight) {
      document.getElementById('btn-exit-fullscreen').classList.remove('hidden')
      document.getElementById('btn-go-fullscreen').classList.add('hidden')
    } else {
      document.getElementById('btn-exit-fullscreen').classList.add('hidden')
      document.getElementById('btn-go-fullscreen').classList.remove('hidden')
    }
  }

  setNewReportClass() {
    document.querySelector('body').classList.add('new-report');
  }
}
