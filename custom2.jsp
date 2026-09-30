<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="euc-kr">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/header_footer.css">
  <script src="./js/product.js" defer></script>
  <script src="./js/header.js" defer></script>
  <style>
    main {
      margin: 0;
      font-family: sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      background: #fafafa;
    }

    .custom-page {
      display: flex;
      gap: 300px;
    }

    .left-panel {
      width: 700px;
    }

    .step {
      display: none;
    }
    .step.active {
      display: block;
    }
    h2{
      font-size: 34px;
      margin-bottom: 60px;
    }


    .step ul {
      list-style: none;
      padding: 0;
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
    }

    .step li {
  border: none; 
  background: none;

}
.card {
  position: relative;
  width: 200px;
  height: 200px;
  transform-style: preserve-3d;
  transition: transform 0.8s;
  border-radius: 50%;
  border: 1px solid #b9b9b9;
}
/*
.cap {
  position: absolute;
  top: -58px;
  left: 50%;
  transform: translateX(-50%);
  width: 50px;
  height: 60px;
  background: #f5f5f5;
  border: 1px solid #b9b9b9;
  border-bottom: none;
  border-radius: 6px 6px 2px 2px;
  z-index: 5; 
}
*/
.step li:hover .card {
  transform: rotateY(180deg);
}

.card-front,
.card-back {
  position: absolute;
  width: 100%;
  height: 100%;
  backface-visibility: hidden;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  box-sizing: border-box;
  cursor: pointer;
}

.card-front img {
  width: 30px;
  height: 30px;
  object-fit: cover;
  border-radius: 50%;
  margin-bottom: 12px;
}

.card-back {

  transform: rotateY(180deg);
  padding: 10px;
  text-align: center;
}
.bg{

  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  position: relative;
}


.tooltip {
  color: #000;
  font-size: 16px;
  line-height: 1.3;
  padding: 0;
  max-width: 100%;
  cursor: pointer;
}


.step span{
  font-size: 18px;
}

.step li img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  margin-bottom: 5px;
  border-radius: 50%;
  transition: transform 0.3s ease;
}


.step:not(.step-final) li.selected {

border: 3px solid #000;
  border-radius: 50%; 
}

.step-final li.selected {
  background: #e0d4fc;
  border-color: #8e4eff;
  color: #4b208c;
  box-shadow: 0 6px 10px rgba(142, 78, 255, 0.3);
  border-radius: 20px; 
}

    

    .prev-btn{
      margin-top: 20px;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
    }
    .next-btn {
      margin-top: 20px;
      padding: 10px 20px;
      font-size: 16px;
      cursor: pointer;
    }

    .right-panel .bottle {
      position: relative;
      width: 350px;
      height: 600px;
      border: 3px solid #333;
      border-radius: 20px;
      overflow: hidden;
      background: #fff;
    }

    .fill {
      position: absolute;
      width: 100%;
      transition: height 3s ease;
      
    }
    
    .top-fill {
      bottom: 0;
      background: linear-gradient(to top, #9cc0ff5f, #ffffff00);
      height: 0;
      z-index: 3;
    }

    .middle-fill {
      bottom: 0;
      background: linear-gradient(to top,#9cc0ff5f, #ffffff00);
      height: 0;
      z-index: 2;
    }

    .base-fill {
      bottom: 0;
      background: linear-gradient(to top, #9cc0ff5f, #c5a0f55f);
      height: 0;
      z-index: 1;
    }

    .volume-options li,
.box-color-options li {
  background: #fff;
  border: 2px solid #ccc;
  border-radius: 20px;
  padding: 20px;
  text-align: center;
  font-size: 18px;
  font-weight: bold;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  display: flex;
  align-items: center;
  justify-content: center;
}

.volume-options,
.box-color-options {
  display: flex;
  gap: 20px;
  margin-bottom: 40px;
}


.floating-flowers {
  position: relative; 
      width: 100%;
      height: 100%;
      pointer-events: none;
      z-index: 10;
    }

    .floating-flowers img {
      position: absolute;
      width: 60px;
      height: 60px;
      opacity: 0;
      pointer-events: none;
    }


    .floating-flowers img.drop-in {
  position: absolute;
  opacity: 0;
  transform: translateY(0);  
  animation: float 5s ease-in-out infinite;  

@keyframes float {
  0% {
    transform: translateY(0) rotate(0deg);
  }
  50% {
    transform: translateY(-20px) rotate(15deg); 
  }
  100% {
    transform: translateY(0) rotate(0deg); 
  }
}


  </style>
</head>
<body>

  <header class="header">
    <div class="icon-bar">
        <div class="icon-container">
          <div class="logo"><a href="./index.jsp"><img src="./logo/logo.png" alt="Logo"></a></div>
          <form action="search.jsp" method="get" accept-charset="EUC-KR">
            <img class="header-icon" src="icon/search.png" id="search">
            <input type="text" name="query" placeholder="search" class="input-search">
            <button type="submit" class="search-button" style="display: none;"></button>
        </form>
   
         <a href="./cart.jsp"><img src="./icon/shopping-cart.png" class="header-icon"></a>
         <a href="./mypage_updatemember.jsp"><img src="./icon/profile-white.png" class="header-icon"></a>
		 
         <a href="./logout.jsp">Logout</a>
     
        </div>
        <button class="hamburger" id="hamburgerBtn">
          <img src="./icon/header__toggle.png" >
        </button>
    </div>
    
    <div class="nav-bar">
       
        <div class="menu-container" id="menuContainer">
            <nav>
                <ul class="menu">
                    <li class="menu-item">봄</li>
                    <li class="menu-item">여름</li>
                    <li class="menu-item">가을</li>
                    <li class="menu-item">겨울</li>
                    <li  class="menu-item">사계의 꽃</a></li>
                    <li class="menu-item">나만의 향수 공방</a></li>
                </ul>
                <div class="submenus" id="submenus">
                  <div class="submenu">
                    <a href="Spring_Perfume.jsp">향수</a>
                    <a href="Spring_diffuser.jsp">디퓨저</a>
                  </div>
                  <div class="submenu">
                    <a href="Summer_Perfume.jsp">향수</a>
                    <a href="Summer_diffuser.jsp">디퓨저</a>
                  </div>
                  <div class="submenu">
                    <a href="Autumn_Perfume.jsp">향수</a>
                    <a href="Autumn_diffuser.jsp">디퓨저</a>
                  </div>
                  <div class="submenu">
                    <a href="Winter_Perfume.jsp">향수</a>
                    <a href="Winter_diffuser.jsp">디퓨저</a>
                  </div>
                  <div class="submenu">
                    <a href="flowersBook.jsp">사계 백과사전</a>
                  </div>
                  <div class="submenu">
                    <a href="my_perfume_notes.jsp">향수의 기본 구조</a>
                    <a href="custom1.jsp">향수 커스텀</a>
                  </div>
                </div>
            
            </nav>
        </div>
    </div>
</header>
 <main>
  <div class="custom-page">
    <div class="left-panel">
      <div class="step step-top active">
        <h2>Base Note를 선택하세요</h2>
        <h3>가장 오랜 시간 남아 깊은 인상을 주는 향. 향수의 분위기와 무드를 결정짓습니다.</h3>
        <ul>
          <li>
            <div class="card">
              <div class="card-front">
                <img src="image/flower1.png" />
                <span>벤조인</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">달콤하고 부드러운 바닐라 향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="card-front">
                <img src="image/flower2.png" />
                <span>금목서</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">따뜻하고 달콤한 꿀향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="card-front">
                <img src="image/flower1.png" />
                <span>카네이션</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">스파이시하면서도 따뜻한 향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="card-front">
                <img src="image/flower2.png" />
                <span>스노우드롭</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">가운, 맑고 청초한 느낌의 꽃향</div>
              </div>
            </div>
          </li>
          
        </ul>
   
      </div>

      <div class="step step-middle">
        <h2>Middle Note를 선택하세요</h2>
        <h3> 향수의 중심을 이루는 향으로, 시간이 지나면서 자연스럽게 피어오르며 조화를 이룹니다.</h3>
        <ul>
        
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower1.png" />
                <span>장미</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">풍부하고 달콤한 장미향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower2.png" />
                <span>백합</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">깨끗하고 우아한 백합향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower1.png" />
                <span>수선화</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">부드럽고 따뜻한 풀향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower2.png" />
                <span>튤립</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">신선하고 생동감 넘치는 사과향</div>
              </div>
            </div>
          </li>
        </ul>
      </div>

      <div class="step step-base">
        <h2>Top Note를 선택하세요</h2>
        <h3>처음 향수를 뿌렸을 때 느껴지는 산뜻한 첫인상. 가장 먼저 다가오지만 가장 빨리 사라지는 향입니다.</h3> 
        <ul>
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower1.png" />
                <span>베르가못</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">상큼하고 상쾌한 레몬향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower2.png" />
                <span>라벤더</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">시원하고 허브향이 나는 허브향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower1.png" />
                <span>은방울꽃</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">신선하고 깨끗한 꽃향</div>
              </div>
            </div>
          </li>
          <li>
            <div class="card">
              <div class="cap"></div> 
              <div class="card-front">
                <img src="image/flower2.png" />
                <span>프리지아</span>
              </div>
              <div class="card-back bg">
                <div class="tooltip">달콤하고 상큼한 오렌지향</div>
              </div>
            </div>
          </li>
        </ul>
      
       
      </div>

      <div class="step step-final">
        <h2>용량을 선택하세요</h2>
        <ul class="volume-options">
          <li>30ml</li>
          <li>50ml</li>
          <li>100ml</li>
        </ul>

        <h2>박스 색상을 선택하세요</h2>
        <ul class="box-color-options">
          <li>화이트 박스</li>
          <li>핑크 박스</li>
          <li>블랙 박스</li>
        </ul>
      </div>

<button class="prev-btn" style="display: none;">이전</button>
<button class="next-btn">다음</button>

    </div>

 <div class="right-panel">
      <div class="bottle">
        <div class="fill top-fill">
          <div class="floating-flowers"></div>
        </div>
        <div class="fill middle-fill">
          <div class="floating-flowers"></div>
        </div>
        <div class="fill base-fill">
          <div class="floating-flowers"></div>
        </div>
      </div>
    </div>
  </div>
 </main>
       <footer class="footer">
    <div class="footer-container">
        <div class="footer-logo">
            <img src=".//logo/logo.png">
            <p>花은 계절 취향에 따라 이용자들의 취향을 파악하고, 취향에
                <br>맞는 향수와 디퓨저를 추천해 고객 니즈를 완벽히 파악하는<br>
                취지의 회사입니다.</p>
        </div>

        <div class="footer-links">
            <div class="footer-column col1">
                <h3>COMPANY</h3>
                <ul> 
                    <li><a href="./about.jsp" title="회사소개">About Us</a></li>
                    <li><a href="./terms_privacy.jsp" title="Terms and Privacy">Terms & Policy</a></li>

               <li><a href="./faq.jsp" title="자주 묻는 질문">FAQs</a></li>
                    <li><a href="./manager_login.jsp" title="관리자 로그인">Manager</a></li>
                </ul>
            </div>

            <div class="footer-column col3">
                <h3>CONTACT INFO</h3>
                <ul>
                    <li>Phone: 010-0000-0000</li>
                    <li>Email: flower@nsu.ac.kr</li>
                    <li>Location: Namseoul University</li>
                </ul>
                <div class="footer-social">
                    <a href="https://www.facebook.com" target="_blank" title="Facebook">
                        <img src="./icon/fb%20icon.png" alt="Facebook">
                    </a>
                    <a href="https://www.twitter.com" target="_blank" title="Twitter">
                        <img src="./icon/twitter%20icon.png" alt="Twitter">
                    </a>
                    <a href="https://www.instagram.com" target="_blank" title="Instagram">
                        <img src="./icon/insta%20icon.png" alt="Instagram">
                    </a>
                    <a href="https://www.linkedin.com" target="_blank" title="LinkedIn">
                        <img src="./icon/linkedin%20icoon.png" alt="LinkedIn">
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="footer-bottom">
        <p>ⓒ 2025 teamRockCrab | All rights reserved</p>
    </div>
</footer>
  <script>
    const steps = document.querySelectorAll(".step");
    const nextBtn = document.querySelector(".next-btn");
    const prevBtn = document.querySelector(".prev-btn");
  
    const fills = {
      top: document.querySelector(".top-fill"),
      middle: document.querySelector(".middle-fill"),
      base: document.querySelector(".base-fill")
    };
  
    let step = 0;
  
    // 향수 노트 선택 (스텝당 전체 항목 중 1개만 선택 가능)
    steps.forEach((stepEl, index) => {
      const allLis = stepEl.querySelectorAll("li");
  
      // 마지막 스텝은 예외 처리
      if (index === 3) {
        const volumeOptions = stepEl.querySelector(".volume-options");
        const boxOptions = stepEl.querySelector(".box-color-options");
  
        volumeOptions.querySelectorAll("li").forEach(li => {
          li.addEventListener("click", () => {
            volumeOptions.querySelectorAll("li").forEach(el => el.classList.remove("selected"));
            li.classList.add("selected");
          });
        });
  
        boxOptions.querySelectorAll("li").forEach(li => {
          li.addEventListener("click", () => {
            boxOptions.querySelectorAll("li").forEach(el => el.classList.remove("selected"));
            li.classList.add("selected");
          });
        });
      } else {
        allLis.forEach(li => {
          li.addEventListener("click", () => {
            // 스텝 전체에서 하나만 선택
            allLis.forEach(el => el.classList.remove("selected"));
            li.classList.add("selected");

            
      // 병 채우기 로직 추가
      if (index === 0) {
        fills.top.style.height = "30%";
      } else if (index === 1) {
        fills.middle.style.height = "70%";
      } else if (index === 2) {
        fills.base.style.height = "100%";
      }
          });
        });
      }
    });
  
    nextBtn.addEventListener("click", () => {
      const currentStep = steps[step];
      let valid = true;
  
      if (step < 3) {
        const selected = currentStep.querySelector(".selected");
        if (!selected) valid = false;
      } else if (step === 3) {
        const volumeSelected = currentStep.querySelector(".volume-options .selected");
        const boxSelected = currentStep.querySelector(".box-color-options .selected");
        if (!volumeSelected || !boxSelected) valid = false;
      }
  
      if (!valid) {
        alert("옵션을 모두 선택해주세요!");
        return;
      }
  
      steps[step].classList.remove("active");
      step++;
  
      if (step < steps.length) {
        steps[step].classList.add("active");
      } else {
        nextBtn.style.display = "none";
      }
  
      prevBtn.style.display = step > 0 ? "inline-block" : "none";
  
      if (step === 1) {
        fills.top.style.height = "30%";
      } else if (step === 2) {
        fills.middle.style.height = "70%";
      } else if (step === 3) {
        fills.base.style.height = "100%";
      }
    });
  
    prevBtn.addEventListener("click", () => {
      if (step > 0) {
        steps[step].classList.remove("active");
        step--;
        steps[step].classList.add("active");
        nextBtn.style.display = "inline-block";
      }
  
      prevBtn.style.display = step > 0 ? "inline-block" : "none";
  
      if (step === 0) {
        fills.top.style.height = "0";
      } else if (step === 1) {
        fills.middle.style.height = "30%";
        fills.base.style.height = "0";
      } else if (step === 2) {
        fills.base.style.height = "70%";
      }
    });

    // 꽃 이미지를 떠다니게 만드는 함수
    function addFloatingFlowers(container, imageSrc) {
  container.innerHTML = "";
  for (let i = 0; i < 6; i++) { // 6개의 꽃 이미지를 추가
    const flower = document.createElement("img");
    flower.src = imageSrc;

    // X축, Y축 랜덤 위치
    const randomLeft = Math.random() * 100; // 0% ~ 100%
    const randomTop = Math.random() * 20 + 10; // 10% ~ 30% (애니메이션 시작 위치)
    
    flower.style.left = `${randomLeft}%`;
    flower.style.top = `${randomTop}%`;  // 초기 위치
    flower.style.opacity = 0;

    flower.classList.add("drop-in"); 
    flower.style.animationDelay = `${Math.random() * 0.5}s`; 
    
    container.appendChild(flower);

    // JavaScript로 top 위치를 변경하여 애니메이션을 트리거
    setTimeout(() => {
      flower.style.transition = 'top 1s ease, opacity 1s ease'; 
      flower.style.top = `${Math.random() * 40 + 30}%`;  // 떨어지는 위치 (60% ~ 100%)
      flower.style.opacity = 0.85;  // 투명도
    }, 50); 
  }
}


steps.forEach((stepEl, index) => {
  const allLis = stepEl.querySelectorAll("li");

  allLis.forEach(li => {
    li.addEventListener("click", () => {

      const img = li.querySelector("img");
      const flowerImgSrc = img?.src || "image/flower1.png"; 

     
      if (index === 0) {  
        fills.top.style.height = "30%";
        const container = fills.top.querySelector(".floating-flowers");
        addFloatingFlowers(container, flowerImgSrc);
      } else if (index === 1) { 
        fills.middle.style.height = "70%";
        const container = fills.middle.querySelector(".floating-flowers");
        addFloatingFlowers(container, flowerImgSrc);
      } else if (index === 2) { 
        fills.base.style.height = "100%";
        const container = fills.base.querySelector(".floating-flowers");
        addFloatingFlowers(container, flowerImgSrc);
      }
    });
  });
});

  </script>
  
</body>
</html>
