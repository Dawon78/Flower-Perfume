
     
const sliderWrapper = document.querySelector('.slider-wrapper');
const thumb = document.querySelector('.slider-thumb');
let currentIndex = 0;
const slideGroups = document.querySelectorAll('.slide-group').length;
const maxIndex = slideGroups - 1;
let isDragging = false;
let startX = 0;

function updateSlider() {
    sliderWrapper.style.transform = `translateX(-${currentIndex * 100}%)`;
    thumb.style.width = `${100 / (maxIndex + 1)}%`;
    thumb.style.transform = `translateX(${currentIndex * (100 / maxIndex)}%)`;

    // 텍스트 선택 해제는 텍스트 입력 필드가 아닐 경우에만
    if (!document.activeElement.matches('input, textarea')) {
        window.getSelection().removeAllRanges();
    }
}

sliderWrapper.addEventListener('mousedown', (e) => {
    // 슬라이더 드래그 시작
    isDragging = true;
    startX = e.clientX;
    sliderWrapper.style.cursor = 'grabbing';
});

window.addEventListener('mouseup', () => {
    // 마우스를 놓을 때 선택 해제
    isDragging = false;
    sliderWrapper.style.cursor = 'grab';

    // 슬라이더 외부 클릭 시 텍스트 선택 해제
    if (!document.activeElement.matches('input, textarea')) {
        window.getSelection().removeAllRanges();
    }
});

window.addEventListener('mousemove', (e) => {
    if (!isDragging) return;

    let moveX = e.clientX - startX;

    if (moveX < -50 && currentIndex < maxIndex) {
        currentIndex++;
        isDragging = false; 
    } else if (moveX > 50 && currentIndex > 0) {
        currentIndex--;
        isDragging = false; 
    }

    startX = e.clientX; 
    updateSlider();
});

document.addEventListener('keydown', (e) => {
    if (e.key === 'ArrowRight' && currentIndex < maxIndex) {
        currentIndex++;
    } else if (e.key === 'ArrowLeft' && currentIndex > 0) {
        currentIndex--;
    }
    updateSlider();
});

updateSlider();

document.addEventListener("DOMContentLoaded", function () {
    const openBtn = document.querySelector(".season-button");
    const popupOverlay = document.getElementById("popupOverlay");
    const closeBtn = document.getElementById("closePopup");

    // 팝업 열기
    openBtn.addEventListener("click", function () {
      const scrollY = window.scrollY;
      document.body.style.position = 'fixed';
      document.body.style.top = `-${scrollY}px`;
      document.body.style.left = '0';
      document.body.style.right = '0';
      document.body.style.width = '100%';
      document.body.dataset.scrollY = scrollY;

      popupOverlay.style.display = "flex";
    });

    // 팝업 닫기
    function closePopup() {
      const scrollY = document.body.dataset.scrollY;
      document.body.style.position = '';
      document.body.style.top = '';
      document.body.style.left = '';
      document.body.style.right = '';
      document.body.style.width = '';
      window.scrollTo(0, parseInt(scrollY || '0'));

      popupOverlay.style.display = "none";
    }

    closeBtn.addEventListener("click", closePopup);

    // 팝업 외부 클릭 시 닫기
    popupOverlay.addEventListener("click", function (e) {
      if (e.target === popupOverlay) {
        closePopup();
      }
    });
  });