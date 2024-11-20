import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["trackItem"];

  connect() {
    console.log("Stimulus carousel controller connecté");

    this.currentIndex = 0;

    this.leftArrow = this.element.querySelector(".left-arrow");
    this.rightArrow = this.element.querySelector(".right-arrow");

    this.updateCarousel();

    this.rightArrow.addEventListener("click", () => this.nextTrack());
    this.leftArrow.addEventListener("click", () => this.previousTrack());

    // // Défilement automatique
    // this.autoScroll = setInterval(() => this.nextTrack(), 5000);
    // console.log("autoScroll", this.autoScroll);
  }

  disconnect() {
    this.rightArrow.removeEventListener("click", () => this.nextTrack());
    this.leftArrow.removeEventListener("click", () => this.previousTrack());
    clearInterval(this.autoScroll);
  }

  updateCarousel() {
    this.trackItemTargets.forEach((item, index) => {
      item.style.display = index === this.currentIndex ? "block" : "none";
    });
  }

  nextTrack() {
    console.log("nextTrack appelée");
    this.currentIndex = (this.currentIndex + 1) % this.trackItemTargets.length;
    this.updateCarousel();
  }

  previousTrack() {
    console.log("previousTrack appelée");
    this.currentIndex = (this.currentIndex - 1 + this.trackItemTargets.length) % this.trackItemTargets.length;
    this.updateCarousel();
  }
}
