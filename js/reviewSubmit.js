// 별점 선택 시
const stars = document.querySelectorAll('.stars span');
const ratingValue = document.getElementById('rating-value');
const ratingInput = document.getElementById('rating-input'); // 이 줄 추가

stars.forEach(star => {
    star.addEventListener('click', function() {
        const value = this.getAttribute('data-value');
        ratingValue.textContent = `${value} / 5.0`;
        ratingInput.value = value; // 이 줄 추가!
        stars.forEach(s => s.classList.remove('active'));
        for (let i = 0; i < value; i++) {
            stars[i].classList.add('active');
        }
    });
});

document.querySelectorAll('.options').forEach(optionGroup => {
    optionGroup.addEventListener('click', function(e) {
        if (e.target.tagName === "BUTTON") {
            [...optionGroup.children].forEach(btn => btn.classList.remove('selected'));
            e.target.classList.add('selected');

            // 각 그룹에 따라 input에 값 넣기
            if (optionGroup.id === 'longevity-options') {
                document.getElementById('longevity-input').value = e.target.getAttribute('data-value');
            } else if (optionGroup.id === 'scent-options') {
                document.getElementById('scent-input').value = e.target.getAttribute('data-value');
            }
        }
    });
});


document.getElementById("review").addEventListener("input", function () {
    let textLength = this.value.length;
    document.getElementById("char-counter").textContent = `(${textLength}/1000)`; // 여기서 textLength를 동적으로 업데이트
});

    