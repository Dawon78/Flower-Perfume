let leftStep = 0;
let rightStep = 0;
const leftSlides = [
  document.querySelector('.left-alt-0'),
  document.querySelector('.left-alt'),
  document.querySelector('.left-alt-2'),
  document.querySelector('.left-alt-3')
];

const rightSlides = [
  document.querySelector('.right-alt-0'),
  document.querySelector('.right-alt'),
  document.querySelector('.right-alt-2'),
  document.querySelector('.right-alt-3')
];

setInterval(() => {
  leftSlides.forEach(slide => {
      slide.style.transform = 'translateX(-100%)';
  });
  leftSlides[leftStep].style.transform = 'translateX(0)';
  leftStep = (leftStep + 1) % 4;
}, 6000);

setTimeout(() => {
  setInterval(() => {
      rightSlides.forEach(slide => {
          slide.style.transform = 'translateX(100%)';
      });
      rightSlides[rightStep].style.transform = 'translateX(0)';
      rightStep = (rightStep + 1) % 4;
  }, 6000);
}, 3000);

document.addEventListener("DOMContentLoaded", function () {
  const hamburger = document.getElementById("hamburgerBtn");
  const menu = document.getElementById("menuContainer");

  hamburger.addEventListener("click", function () {
    menu.classList.toggle("active");
  });
});