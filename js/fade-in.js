document.addEventListener("DOMContentLoaded", function () {
  const elements = document.querySelectorAll(".fade-in");

  const observer = new IntersectionObserver(
    (entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("show");
          observer.unobserve(entry.target); // 한 번 나타난 요소는 다시 감지하지 않음
        }
      });
    },
    { threshold: 0.2 } // 요소가 20% 이상 보이면 효과 적용
  );

  elements.forEach((el) => observer.observe(el));
});

document.addEventListener("DOMContentLoaded", function () {
  const elements = document.querySelectorAll(".fade-left, .fade-right");

  const observer = new IntersectionObserver(
    (entries, observer) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("show");
          observer.unobserve(entry.target); // 한 번 나타난 요소는 다시 감지하지 않음
        }
      });
    },
    { threshold: 0.2 } // 20% 이상 보이면 효과 적용
  );

  elements.forEach((el) => observer.observe(el));
});