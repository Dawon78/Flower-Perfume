// ID 중복체크 함수 - 전역 등록
window.checkID = function () {
    var idInput = document.getElementById("memId"); // 올바르게 ID 필드 가져오기
    var id = idInput.value.trim(); // 공백 제거

    if (id === "") {
        alert("ID를 입력해 주세요!");
        idInput.focus();
        return;
    }

    // 중복 검사용 팝업 띄우기
    window.open("checkId.jsp?id=" + encodeURIComponent(id), "win", 
                "width=255, height=145, scrollbars=no, resizable=no");
};


// content와 pageLinks 초기화
const contentDiv = document.getElementById('content');
const defaultContent = contentDiv.innerHTML;

// 페이지를 동적으로 불러오는 함수 (스크립트 실행 추가)
function loadPage(page) {
    fetch(page)
        .then(response => {
            if (!response.ok) throw new Error('페이지 로드 실패');
            return response.blob();
        })
        .then(blob => blob.arrayBuffer())
        .then(buffer => {
            const decoder = new TextDecoder('euc-kr');
            const text = decoder.decode(buffer);
            contentDiv.innerHTML = text;

            // 동적으로 추가된 스크립트 실행
            const scripts = contentDiv.querySelectorAll('script');
            scripts.forEach(script => {
                const newScript = document.createElement('script');
                newScript.text = script.textContent;
                document.body.appendChild(newScript);
                document.body.removeChild(newScript);
            });
        })
        .catch(error => {
            contentDiv.innerHTML = `<p style="color:red;">${error.message}</p>`;
        });
}

// 이벤트 위임: contentDiv 내의 모든 data-page 링크 처리
contentDiv.addEventListener('click', function(e) {
    const target = e.target.closest('a[data-page]');
    if (target) {
        e.preventDefault();
        const page = target.getAttribute('data-page');
        loadPage(page);
    }
});

// 초기 페이지 로드 시, data-page 링크에 이벤트 리스너 추가
const pageLinks = document.querySelectorAll('a[data-page]');
pageLinks.forEach(link => {
    link.addEventListener('click', function(e) {
        e.preventDefault();
        const page = this.getAttribute('data-page');
        loadPage(page);
    });
});
