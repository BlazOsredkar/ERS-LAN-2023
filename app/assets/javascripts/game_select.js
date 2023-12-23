// game_selection.js

document.addEventListener("DOMContentLoaded", function () {
  const gameButtons = document.querySelectorAll(".game-button");
  let selectedGameId = null;

  gameButtons.forEach((button) => {
    button.addEventListener("click", function () {
      // Remove selection from all buttons
      gameButtons.forEach((btn) => {
        btn.classList.remove("selected");
      });

      // Add selection to the clicked button
      button.classList.add("selected");
      selectedGameId = button.getAttribute("data-game-id");
    });
  });

  // Handling the Create Team button click to trigger the action with the selected game
  document
    .getElementById("create-team-button")
    .addEventListener("click", function () {
      // Check if a game is selected
      if (selectedGameId !== null) {
        // Use selectedGameId in your form submission or other logic
        console.log("Selected Game ID:", selectedGameId);
        // Perform form submission or any other action here
      } else {
        // Notify the user to select a game before proceeding
        alert("Please select a game.");
        // Prevent form submission if necessary
        event.preventDefault();
      }
    });
});
