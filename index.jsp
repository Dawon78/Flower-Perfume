<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/index.css">
    <link rel="stylesheet" href="./css/header_footer.css">
    <link rel="stylesheet" href="./css/fade-in.css">
      <script src="./js/index.js" defer></script>
      <script src="./js/header.js" defer></script>
      <script src="./js/fade-in.js" defer></script>
      <script src="./js/main.js" defer></script>
      <link rel="stylesheet" href="path/to/sakura.min.css">
      <link rel="stylesheet" href="dist/sakura.css" />
      <script src="dist/sakura.js" text="text/javascript"></script>
      <script src="path/to/sakura.min.js"></script>
</head>
<body>
<%
	String id = (String)session.getAttribute("sid");                                                                           
%>
    <header class="header">
        <div class="icon-bar">
            <div class="icon-container">
              <div class="logo"><a href="./index.jsp"><img src="./logo/logo.png" alt="Logo"></a></div>
              <form action="search.jsp" method="get" accept-charset="EUC-KR">
                <img class="header-icon" src="icon/search.png" id="search">
                <input type="text" name="query" placeholder="search" class="input-search search-button">
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

    <div class="main-container">
    
  <img src="./image/main_text.png" class="main-text fade-in">
        <div class="left">
            <div class="left-alt-0"><img src="./image/main_f1.png"></div>
            <div class="left-alt"><img src="./image/main_f2.png"></div>
            <div class="left-alt-2"><img src="./image/main_f3.png"></div>
            <div class="left-alt-3"><img src="./image/main_f4.png"></div>
        </div>
        <div class="right">
            <div class="right-alt-0"><img src="./image/main_p1.png"></div>
            <div class="right-alt"><img src="./image/main_p2.png"></div>
            <div class="right-alt-2"><img src="./image/main_p3.png"></div>
            <div class="right-alt-3"><img src="./image/main_p4.png"></div>
        </div>
    </div>
    <section>
        <div class="background1"><img src="./image/backgroundimg1.png"></div>
        <div class="background2"><img src="./image/backgroundimg2.png"></div>
        <div class="container">
    
          <div class="section1  fade-left">
              <div class="box box1"><img src="./image/box1.png"></div>
              <div class="box box2"><img src="./image/box2.png"></div>
              <div class="text1">
                  <div class="title">사계,<br> 탄생화에 대하여</div>
                  <div class="quote">"나만의 향기를 이해하는 새로운 방법, 계절 속에 숨겨진 나를 <br>만나보세요."</div>
                  <a href="./flowersBook.jsp" class="more">See More ></a>
              </div>
          </div>
          <div class="section2  fade-right">
              <div class="box box3"><img src="./image/box3.png"></div>
              <div class="box box4"><img src="./image/box4.png"></div>
              <div class="text2">
                  <div class="title">사계,나의 향이 되다</div>
                  <div class="quote">"꽃은 시간이 지나면서 더욱 아름다워지죠.<br> 당신의 성격과 맞는 꽃도 그렇게 시간이<br> 지나면서 점점 더 소중한 의미를 가질 거예요."</div>
              </div>
          </div>
      </div>
      </section>
      <section class="perfume-section  fade-in">
        
        <div class="text-boxs">
           <div class="text-box">
            <h2>Our Favorite<br> Perfumes</h2>
            <button class="see-more" onclick="location.href='./Spring_Product.jsp'">See More</button>
           </div>
        </div>
        <div class="image-box">
            <img src="./image/main_Perfume Bottle.png" alt="Perfume Bottle">
            <img src="./image/main_Diffuser.png" alt="Diffuser">
            <img src="./image/main_WomanWithShadows.png" alt="Woman with Shadows">
        </div>
    </section>
    <section>
      <div class="product-slider-container">
        <p class="go-to-product" onclick="location.href='./Spring_Product.jsp'">패키징 상품 미리 보기 ></p>
        <div class="slider-wrapper">
            <div class="slide-group fade-in">
                <div class="slide">
                    <img src="./image/main_p11.png">
                    <button class="view-button">골드 블룸 플로럴</button><!--수선화-->
                </div>
                <div class="slide"> 
                    <img src="./image/main_p22.png">
                    <button class="view-button">사쿠라 브리즈 플로럴</button>
                </div>
                <div class="slide">
                    <img src="./image/main_p33.png">
                    <button class="view-button">라벤더 드림 플로럴</button><!--연꽃-->
                </div>
            </div>
            <div class="slide-group fade-in">
                <div class="slide">
                    <img src="./image/main_p44.png">
                    <button class="view-button">히아신스 조이 플로럴</button>
                </div>
                <div class="slide">
                    <img src="./image/main_p55.png">
                    <button class="view-button">다알리아 플로럴</button>
                </div>
                <div class="slide">
                    <img src="./image/main_p66.png">
                    <button class="view-button">베르가못 플로럴</button>
                </div>
            </div>
        </div>
      
        <div class="slider-bar">
          <div class="slider-thumb"></div>
        </div>
        <div class="slider"></div>
      
    </div>
    </section>
    <section class="product-back">
      <div class="product">
        <div class="text-content">
            <p class="go-to-product">계절 한정 상품 ></p>
           <div class="line fade-left" >
            <h2>봄 한정 향수를 추천합니다!</h2>
            <p class="p">한정판으로 출시된 이 향수는 봄의 향기를 온전히 담아내어,<br> 이 특별한 계절을 더욱 아름답게 만들어줄 거예요. 
            봄만의 특별한 향기를 놓치지 말고 지금 바로 만나보세요!</p>
           <button class="see-more"> <a href="./Spring_Product.jsp" >See More</a></button>
           </div>
        </div>
        <div class="image-container fade-right">
            <img src="./image/product_box.png" alt="향수 이미지">
        </div>
      </div>
    </section>
    <section class="section-season">
      <div class="season-container  fade-in">
        <div class="season-title-wrapper">
            <p>사계 중 나의 계절은 뭘까?</p>
            <div class="season-title-line"></div>
        </div>
        <h1 class="season-title">사계 유형 테스트</h1>
        <div class="season-button-wrapper">
            <div class="season-horizontal-line"></div>
            <a class="season-button">테스트하러 가기</a>
        </div>
        <p class="season-description">테스트 후 나온 유형으로 계절 추천을 받으실 수 있습니다.</p>
    </div>
  
    <div class="popup-overlay" id="popupOverlay">
      <div class="popup">
          <span class="close-btn" id="closePopup">&times;</span>
          <iframe src="survey.html"></iframe>
      </div>
  </div>
  
    </section>
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

<!--<div class="main-popup-overlay">
  <div class="main-popup-container">
    <img src="./image/Mainpopup.jpg" alt="Popup Image" onclick="location.href='.html'">
    <div class="main-popup-footer">
      <label><input type="checkbox" id="no-show-today"> 오늘 하루 보지 않기</label>
      <button class="main-popup-close">닫기</button>
    </div>
  </div>
</div>-->

</div>

    <script>
        var sakura = new Sakura('body', {
          colors: [
            {
              gradientColorStart: 'rgba(255, 183, 197, 0.9)',
              gradientColorEnd: 'rgba(255, 197, 208, 0.9)',
              gradientColorDegree: 120,
            },
            {
              gradientColorStart: 'rgba(255,189,189)',
              gradientColorEnd: 'rgba(227,170,181)',
              gradientColorDegree: 120,
            },
            {
              gradientColorStart: 'rgba(212,152,163)',
              gradientColorEnd: 'rgba(242,185,196)',
              gradientColorDegree: 120,
            },
          ],
          delay: 200,
        });

document.addEventListener("DOMContentLoaded", function () {
  const popupOverlay = document.querySelector(".main-popup-overlay");
  const closePopupBtn = document.querySelector(".main-popup-close");

  if (popupOverlay) {
    popupOverlay.style.display = "flex"; 
  }

  if (closePopupBtn) {
    closePopupBtn.addEventListener("click", function () {
      popupOverlay.style.display = "none"; 
    });
  }
});


				function encodeQuery() {
    var input = document.querySelector('.search').value;
    var encodedInput = encodeURIComponent(input); 
    window.location.href = 'search.jsp?query=' + encodedInput; 
}

document.querySelector('.search-button').onclick = function(event) {
    event.preventDefault(); 
    encodeQuery(); 
};
      
      
      </script>
</body>
</html>
