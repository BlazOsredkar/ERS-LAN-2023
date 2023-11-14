// app/javascript/controllers/carousel_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slide"];
  index = 0;
  slideWidth = 0;

  connect() {
    console.log("Carousel controller connected...");
    this.initCarousel();
    this.setSlideWidth();
    this.startCarousel();
    this.handleResize();
  }

  initCarousel() {
    this.index = 0;
  }

  setSlideWidth() {
    const slide = this.slideTargets[0];
    this.slideWidth = slide.offsetWidth;
  }

  startCarousel() {
    setInterval(() => {
      this.showNextSlide();
    }, 2000); // Change this value for different slide durations
  }

  showNextSlide() {
    const currentSlide = this.slideTargets[this.index];
    currentSlide.classList.remove("active");
    this.index = (this.index + 1) % this.slideTargets.length;
    const nextSlide = this.slideTargets[this.index];
    nextSlide.classList.add("active");
  }

  handleResize() {
    window.addEventListener("resize", () => {
      this.setSlideWidth();
    });
  }
}
