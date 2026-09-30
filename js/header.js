document.addEventListener("DOMContentLoaded", function () {
  const searchIcon = document.getElementById("search");
  const searchInput = document.querySelector(".input-search");

  searchIcon.addEventListener("click", function () {
    searchInput.classList.toggle("active"); // input의 active 클래스 토글
  });
});


document.addEventListener("DOMContentLoaded", function () {
    const menuContainer = document.getElementById("menuContainer");
    const submenus = document.getElementById("submenus");

    // menu-item을 클릭했을 때만 작동하도록 설정
    menuContainer.addEventListener("click", function (event) {
      const clickedElement = event.target;

      if (clickedElement.classList.contains("menu-item")) {
        submenus.classList.toggle("active");
      }
    });
  });