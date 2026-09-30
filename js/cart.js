let list = document.querySelectorAll('.item');

list.forEach(item => {
    const dropdown = item.querySelector('.dropdown');

    dropdown.addEventListener('click', function (event) {
        item.classList.toggle('active'); // 클릭할 때 active 추가/제거
        event.stopPropagation();
    });
});

// 버튼 및 모달 선택
const modal = document.getElementById("reviewModal");
const btn = document.querySelector(".review-btn"); // 첫 번째 버튼을 선택 (필요시 여러 개 처리 가능)
const closeBtn = document.querySelector(".close-btn");

// 페이지가 로드될 때 modal이 보이지 않도록 설정 (이미 되어있다면 필요 없음)
modal.style.display = "none"; // 모달 초기화 (새로고침시에도 숨김)

// 버튼 클릭 시 모달 열기
btn.addEventListener("click", () => {
    modal.style.display = "flex"; // 모달을 flex로 변경하여 중앙 정렬
});

// 닫기 버튼 클릭 시 모달 닫기
closeBtn.addEventListener("click", () => {
    modal.style.display = "none"; // 모달 숨기기
});

// 모달 외부 클릭 시 모달 닫기
window.addEventListener("click", (event) => {
    if (event.target === modal) { // 모달 영역 외부 클릭 시
        modal.style.display = "none"; // 모달 숨기기
    }
});