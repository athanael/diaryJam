console.log("carousel.js chargé");

document.addEventListener("DOMContentLoaded", function () {
  const trackItems = document.querySelectorAll(".track-item");
  const leftArrow = document.querySelector(".left-arrow");
  const rightArrow = document.querySelector(".right-arrow");
  let currentIndex = 0;

  function updateCarousel() {
      trackItems.forEach((item, index) => {
          item.style.display = index === currentIndex ? "block" : "none";
      });
  }

  function nextTrack() {
    console.log("nextTrack appelée");
    currentIndex = (currentIndex + 1) % trackItems.length;
    updateCarousel();
  }

  function previousTrack() {
    console.log("previousTrack appelée");
    currentIndex = (currentIndex - 1 + trackItems.length) % trackItems.length;
    updateCarousel();
  }

  rightArrow.addEventListener("click", nextTrack);
  leftArrow.addEventListener("click", previousTrack);

  // Défilement automatique toutes les 3 secondes
  setInterval(nextTrack, 4000);

  updateCarousel(); // Initialisation
});
