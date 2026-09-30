const url = "https://jomalone-kr.netlify.app/";

function setShare() {
  const resultImg = document.querySelector("#resultImg");
  const resultAlt = resultImg.firstElementChild.alt;
  const shareDesc = infoList[resultAlt].desc;
  const shareImg = url + "img/result-" + resultAlt + ".png";
  const shareURL = url + "page/result-" + resultAlt + ".html";


}

