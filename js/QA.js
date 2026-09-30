
function openPopup() {
    document.getElementById('popup').style.display = 'block';
    document.getElementById('popupOverlay').style.display = 'block';
}

function closePopup() {
    document.getElementById('popup').style.display = 'none';
    document.getElementById('popupOverlay').style.display = 'none';
}

document.addEventListener("DOMContentLoaded", function () {
const faqItems = document.querySelectorAll(".faq-item");
const popup = document.getElementById("popup");
const popupOverlay = document.getElementById("popupOverlay");
const popupContent = popup.querySelector(".p p");

const faqData = {
  "교환/환불이 가능한가요?": "미개봉 제품: 대부분의 온라인 쇼핑몰에서는 미개봉 상태의 향수나 디퓨저에 대해 교환이나 환불을 허용합니다. 제품이 개봉되었거나 사용된 경우, 위생적인 이유로 교환/환불이 불가능한 경우가 많습니다.<br><br> 디퓨저: 디퓨저는 대부분 미개봉 상태에서만 교환/환불이 가능하지만, 향이 강하게 나거나 불쾌한 향을 느꼈을 때의 환불 정책은 사이트마다 차이가 있을 수 있습니다. 디퓨저의 경우 리필 세트나 스틱 교환 등의 서비스가 제공되는 경우도 있습니다.<br><br>배송 중 손상: 배송 중에 제품이 파손되었거나 손상된 경우, 교환이나 환불이 가능할 수 있습니다. 이 경우에는 배송 후 일정 기간 내에 고객센터에 연락을 통해 문제를 해결할 수 있습니다. 배송상 문제로 인해 교환/환불을 요청할 때는 배송 영수증이나 사진 증거를 요구할 수 있습니다.<br><br>환불 처리: 환불이 승인되면, 일반적으로 결제 수단으로 환불이 이루어집니다. 카드 결제 시에는 환불 처리가 몇 일 정도 소요될 수 있습니다. 일부 사이트에서는 포인트 환불이나 스토어 크레딧 형태로 환불이 이루어지기도 합니다.<br><br>조건에 따른 제한: 교환/환불 정책은 구매한 제품의 종류, 고객의 구매 이력, 쇼핑몰의 정책에 따라 달라질 수 있습니다. 특히, 세일 상품이나 할인 품목은 환불이 불가능한 경우가 많고, 이와 관련된 별도의 안내가 제공됩니다.<br><br>",
  "선물용 포장 후 배송이 가능한가요?": "네, 선물용 포장 서비스를 제공합니다. 추가 비용이 발생할 수 있으며, 포장 옵션은 결제 페이지에서 선택할 수 있습니다.",
  "배송은 얼마나 걸리나요?": "배송은 일반적으로 결제 완료 후 2~5일 이내에 이루어집니다. 지역이나 배송업체 사정에 따라 차이가 있을 수 있으며, 연휴 및 공휴일에는 지연될 수 있습니다.",
  "향수나 디퓨저는 어떻게 보관해야 하나요?": "향수와 디퓨저는 직사광선을 피해 서늘하고 건조한 곳에 보관하는 것이 좋습니다. 온도 변화가 심한 곳이나 욕실과 같은 습한 환경은 피해주세요. 또한, 뚜껑을 꼭 닫아 보관하면 향이 오래 유지됩니다.",
  "상품 품절 시 재입고는 언제되나요?": "품절된 상품의 재입고 일정은 제품별로 다를 수 있습니다. 일반적으로 인기 상품은 1~2주 이내에 재입고되며, 상세한 일정은 고객센터나 상품 상세 페이지에서 확인 가능합니다.",
  "향수 성분이 어떻게 되나요?": "향수는 주로 천연 꽃 추출물과 에센셜 오일을 사용하여 제작됩니다. 대표적인 성분으로는 장미, 재스민, 라벤더, 일랑일랑 등이 포함될 수 있으며, 알코올과 정제수가 함유되어 지속력과 확산력을 높여줍니다."
};

faqItems.forEach(item => {
  item.addEventListener("click", function () {
      const question = this.querySelector("p").innerText;
      popupContent.innerHTML = faqData[question] || "해당 질문에 대한 답변이 준비되지 않았습니다.";
      popup.style.display = "block";
      popupOverlay.style.display = "block";
  });
});

function closePopup() {
  popup.style.display = "none";
  popupOverlay.style.display = "none";
}

document.querySelector(".close-btn").addEventListener("click", closePopup);
popupOverlay.addEventListener("click", closePopup);
});

