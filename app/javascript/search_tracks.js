document.addEventListener("turbo:load", function() {
  const input = document.getElementById("track-search-input");
  const suggestionsSelect = document.getElementById("track-suggestions");

  input.addEventListener("input", function() {
    const query = input.value;
    console.log("query = " + query);
    if (query.length < 2) {
      suggestionsSelect.innerHTML = "";
      return;
    }

    fetch("/tracks/search?query=" + query, {
      headers: {
        "Accept": "application/json"
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      return response.json();
    })
    .then(tracks => {
      console.log("tracks =", tracks);
      suggestionsSelect.innerHTML = "";

      const defaultOption = document.createElement("option");
      defaultOption.textContent = "Sélectionnez un track";
      defaultOption.value = "";
      suggestionsSelect.appendChild(defaultOption);

      tracks.forEach(track => {
        const optionItem = document.createElement("option");
        optionItem.textContent = track[1] + " - " + track[2];  // Nom du track
        optionItem.value = track[0];  // ID du track
        suggestionsSelect.appendChild(optionItem);
      });
    })
    .catch(error => {
      console.error("Fetch error: ", error);
    });
  });

  suggestionsSelect.addEventListener("change", function() {
    const selectedOption = suggestionsSelect.options[suggestionsSelect.selectedIndex];
    if (selectedOption.value) {
      input.value = selectedOption.text;
      document.getElementById("track-search-input").value = selectedOption.value;
    }
  });
});
