import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["container", "fileInput", "dragText"];

  connect() {
    this.containerTarget.addEventListener("dragover", this.handleDragOver);
    this.containerTarget.addEventListener("dragleave", this.handleDragLeave);
    this.containerTarget.addEventListener("drop", this.handleDrop);
    this.containerTarget.addEventListener("click", this.handleClick);
    this.fileInputTarget.addEventListener("change", this.handleFileChange);
  }

  handleDragOver = (event) => {
    event.preventDefault();
    this.containerTarget.classList.add("active");
  };

  handleDragLeave = () => {
    this.containerTarget.classList.remove("active");
  };

  handleDrop = (event) => {
    event.preventDefault();
    this.containerTarget.classList.remove("active");
    const files = event.dataTransfer.files;
    if (this.isFileImage(files[0])) {
      this.fileInputTarget.files = files;
      this.displaySuccessMessage(files[0].name);
    }
    else if (files[0].size > 5000000) {
      this.displayErrorMessage("Naložena datoteka je prevelika!");
    }
    else {
      this.displayErrorMessage("Naložena datoteka ni slika!");
    }
  };

  handleClick = () => {
    this.fileInputTarget.click();
  };

  handleFileChange = () => {
    const files = this.fileInputTarget.files;
    if (this.isFileImage(files[0])) {
      this.displaySuccessMessage(files[0].name);
    } else {
      this.displayErrorMessage("Naložena datoteka ni slika!");
    }
  };

  isFileImage(file) {
    const acceptedImageTypes = ["image/jpeg", "image/png", "image/gif"];
    if (file.size > 5000000) {
      this.displayErrorMessage("Naložena datoteka je prevelika!");
      return false;
    }
    return file && acceptedImageTypes.includes(file.type);
  }



  displaySuccessMessage(fileName) {
    this.dragTextTarget.innerHTML = `Naložena datoteka: ${fileName}`;
    this.dragTextTarget.classList.add("success");
  }

  displayErrorMessage(message) {
    this.dragTextTarget.innerHTML = `${message}`;
    this.resetMessageAfterDelay(3000);
  }

  resetMessageAfterDelay(delay) {
    setTimeout(() => {
      this.dragTextTarget.classList.remove("success");
      this.dragTextTarget.innerHTML =
        "Iz računalnika naloži sliko ali jo povleci v to polje (MAX 5MB)";
    }, delay);
  }
}
