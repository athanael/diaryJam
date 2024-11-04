document.addEventListener("DOMContentLoaded", function() {
  setTimeout(() => {
      document.body.classList.remove("no-scroll");

      const mainContent = document.querySelector(".main-content");
      if (mainContent) {
        mainContent.style.display = "block";

        window.scrollTo({
          top: mainContent.offsetTop,
          behavior: "smooth"
        });
      }
    }, 1000);
  });
