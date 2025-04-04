import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["category", "games"]

  connect() {
    console.log("Game filter controller connected")
    // If a category is already selected (e.g., when editing), filter games immediately
    if (this.categoryTarget.value) {
      this.filterGames()
    }
  }

  filterGames() {
    console.log("Filtering games...")
    const selectedCategory = this.categoryTarget.value
    const gamesSelect = this.gamesTarget

    // If a category is selected, filter the games
    if (selectedCategory) {
      console.log(`Selected category: ${selectedCategory}`)

      // Show loading state
      $(gamesSelect).empty().append('<option>Loading games...</option>')
      $(gamesSelect).trigger('change')

      // Get games for the selected category from the server
      fetch(`/games.json?category=${encodeURIComponent(selectedCategory)}`)
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP error! Status: ${response.status}`)
          }
          return response.json()
        })
        .then(games => {
          console.log(`Received ${games.length} games for category ${selectedCategory}`)

          // Verify we actually got games back
          if (games.length === 0) {
            console.warn("No games found for this category. Check case sensitivity and exact matches.")
          }

          // Store the current selections
          const selectedValues = Array.from(gamesSelect.selectedOptions).map(option => option.value)

          // Clear the games select (destroy and reinitialize select2)
          $(gamesSelect).select2('destroy')
          $(gamesSelect).empty()

          // Add filtered games
          games.forEach(game => {
            const option = new Option(game.name, game.id)
            option.selected = selectedValues.includes(game.id.toString())
            gamesSelect.add(option)
          })

          // Reinitialize select2
          $(gamesSelect).select2()

          console.log("Games dropdown updated successfully")
        })
        .catch(error => {
          console.error("Error fetching games:", error)
          // Show error in dropdown
          $(gamesSelect).empty().append('<option>Error loading games</option>')
          $(gamesSelect).trigger('change')
        })
    }
  }
}
