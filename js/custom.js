let selectedOption = "";
function selectOption(element, option) {
    document.querySelectorAll(".option").forEach(el => el.classList.remove("selected"));
    element.classList.add("selected");
    selectedOption = option;
}
