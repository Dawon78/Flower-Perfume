document.addEventListener("DOMContentLoaded", function () {
  const toggleButton = document.getElementById("navToggle");
  const navMenu = document.querySelector(".nav-menu");

  toggleButton.addEventListener("click", function () {
    navMenu.classList.toggle("open");
  });
});
document.addEventListener("DOMContentLoaded", function () {
    const headers = document.querySelectorAll(".footer-column h3");

    headers.forEach(header => {
      header.addEventListener("click", function () {
        // 모든 리스트 숨기기
        document.querySelectorAll(".footer-column ul").forEach(ul => {
          if (ul !== this.nextElementSibling) {
            ul.style.display = "none";
          }
        });

        // 현재 클릭한 항목만 토글
        const ul = this.nextElementSibling;
        ul.style.display = (ul.style.display === "block") ? "none" : "block";
      });
    });
  });