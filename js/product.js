document.querySelectorAll('.wishlist-btn').forEach(button => {
  button.addEventListener('click', function() {
      this.classList.toggle('active'); 
  });
});
function toggleCheckbox(id) {
  const checkbox = document.getElementById(id);
  checkbox.checked = !checkbox.checked;
}


