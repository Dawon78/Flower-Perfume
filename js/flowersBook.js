const sliderWrapper = document.getElementById("sliderWrapper");

let isDown = false;
let startX;
let scrollLeft;

sliderWrapper.addEventListener("mousedown", (e) => {
    isDown = true;
    sliderWrapper.classList.add("dragging");
    startX = e.pageX - sliderWrapper.offsetLeft;
    scrollLeft = sliderWrapper.scrollLeft;
});

sliderWrapper.addEventListener("mouseleave", () => {
    isDown = false;
    sliderWrapper.classList.remove("dragging");
});

sliderWrapper.addEventListener("mouseup", () => {
    isDown = false;
    sliderWrapper.classList.remove("dragging");
});

sliderWrapper.addEventListener("mousemove", (e) => {
    if (!isDown) return;
    e.preventDefault();
    const x = e.pageX - sliderWrapper.offsetLeft;
    const walk = (x - startX) * 1.4; // 이동 속도 조절
    sliderWrapper.scrollLeft = scrollLeft - walk;
});
