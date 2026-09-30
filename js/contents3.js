let currentSlide = 0;
const productContainer = document.querySelector('.product-container');
const productItems = document.querySelectorAll('.product-item');
const itemWidth = 293 + 70; // 각 상품의 너비 + margin-right
const itemsPerSlide = 3;
const maxSlide = Math.ceil(productItems.length / itemsPerSlide) - 1;

function updateProductSlider() {
  const offset = -(currentSlide * itemWidth * itemsPerSlide);
  productContainer.style.transform = `translateX(${offset}px)`;
}

function prevSlide() {
  currentSlide = (currentSlide > 0) ? currentSlide - 1 : maxSlide;
  updateProductSlider();
}

function nextSlide() {
  currentSlide = (currentSlide < maxSlide) ? currentSlide + 1 : 0;
  updateProductSlider();
}