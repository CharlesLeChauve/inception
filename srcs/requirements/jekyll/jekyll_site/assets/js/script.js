document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll("pre").forEach((codeBlock) => {
    const button = document.createElement("button");
    button.className = "copy-btn";
    button.textContent = "Copier";
    
    button.addEventListener("click", () => {
      const code = codeBlock.querySelector("code");

      // Créer une plage de sélection et copier le texte
      const range = document.createRange();
      range.selectNodeContents(code);
      const selection = window.getSelection();
      selection.removeAllRanges();
      selection.addRange(range);

      // Essayer de copier dans le presse-papiers
      try {
        document.execCommand("copy");
        button.textContent = "Copié !";
      } catch (err) {
        console.error("Erreur lors de la copie :", err);
        button.textContent = "Erreur";
      }
      
      // Effacer la sélection après une courte pause
      setTimeout(() => {
        button.textContent = "Copier";
        selection.removeAllRanges();
      }, 2000);
    });
    
    codeBlock.appendChild(button);
    codeBlock.classList.add("code-container");
  });
});