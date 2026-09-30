document.addEventListener("DOMContentLoaded", function () {
  const colorBoxes = document.querySelectorAll(".color-box");

  colorBoxes.forEach((box) => {
    box.addEventListener("click", function () {
      // 기존 선택된 박스에서 'selected' 클래스 제거
      colorBoxes.forEach((b) => b.classList.remove("selected"));

      // 클릭한 박스에 'selected' 클래스 추가
      this.classList.add("selected");
    });
  });
});

document.querySelectorAll(".color-box").forEach((box) => {
  box.addEventListener("click", function () {
    // 모든 color-box에서 'shrunk' 클래스 제거 (다른 박스 초기화)
    document.querySelectorAll(".color-box").forEach((el) => {
      el.classList.remove("shrunk");
    });

    // 현재 클릭한 요소만 'shrunk' 클래스 추가
    this.classList.add("shrunk");
  });
});

