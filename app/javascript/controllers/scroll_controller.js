import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      // Supprimer la classe "no-scroll" du body
      document.body.classList.remove("no-scroll");

      // Rendre le contenu principal visible et défiler jusqu'à celui-ci
      const mainContent = this.element.querySelector(".main-content");
      if (mainContent) {
        mainContent.style.display = "block";

        window.scrollTo({
          top: mainContent.offsetTop,
          behavior: "smooth"
        });
      }
    }, 0);
  }
}
