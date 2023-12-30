// app/javascript/controllers/copy_to_clipboard_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  copy(event) {
    const teamCode = this.element.querySelector("b").innerText.trim();

    const tempTextArea = document.createElement("textarea");
    tempTextArea.value = teamCode;
    tempTextArea.style.position = "fixed";
    document.body.appendChild(tempTextArea);
    tempTextArea.select();
    document.execCommand("copy");
    document.body.removeChild(tempTextArea);

    alert(`Team code copied to clipboard: ${teamCode}`);
  }
}
