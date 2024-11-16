// app/javascript/controllers/track_search_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results", "trackId", "trackTitle", "artistName"]

  connect() {
    console.log("Track search controller connected")
  }

  removeMarginBottomClass() {
    const inputContainer = this.inputTarget.closest('.integer.optional.post_track_id')
    if (inputContainer) {
      inputContainer.classList.remove('mb-3')
    }
  }

  search() {
    const query = this.inputTarget.value
    console.log("query = " + query)
    if (query.length < 2) {
      this.resultsTarget.innerHTML = ""
      return
    }

    fetch(`/tracks/search?query=${query}`, {
      headers: {
        "Accept": "application/json"
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error("Network response was not ok")
      }
      return response.json()
    })
    .then(tracks => {
      console.log("tracks =", tracks)
      this.resultsTarget.innerHTML = ""

      tracks.forEach(track => {
        const resultItem = document.createElement("div")
        resultItem.classList.add("track-result-item")
        resultItem.textContent = `${track[1]} - ${track[2]}`  // Nom du track
        resultItem.dataset.trackId = track[0]  // ID du track
        resultItem.dataset.action = "click->track-search#select"
        this.resultsTarget.appendChild(resultItem)
      })
    })
    .catch(error => {
      console.error("Fetch error: ", error)
    })
  }

  select(event) {
    const selectedTrack = event.currentTarget
    this.inputTarget.value = selectedTrack.textContent
    this.trackIdTarget.value = selectedTrack.dataset.trackId
    this.resultsTarget.innerHTML = ""
  }
}
