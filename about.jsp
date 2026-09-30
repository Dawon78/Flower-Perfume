<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="./js/header.js" defer></script>
    <link rel="stylesheet" href="./css/header_footer.css">
</head>
<style>
       @font-face {
    font-family: 'BookkMyungjo-Bd';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
body {
    margin: 0;
    padding: 0;
    font-family: 'BookkMyungjo-Bd', serif;
    background-image: url('./image/allback.png'); /* 이미지 경로에 맞게 수정 */
    background-size: cover;         /* 화면에 꽉 차게 */
    background-repeat: no-repeat;   /* 반복 없음 */
    background-attachment: fixed;   /* 스크롤해도 고정 */
    background-position: bottom;    /* 가운데 정렬 */
}

    .about-section {
  color: #000;
  padding: 60px 20px;
  font-family: 'BookkMyungjo-Bd', serif;
  max-width: 1020px;
  margin: 0 auto;
  border-radius: 10px;
}

.about-container h1 {
  font-size: 32px;
  margin-bottom: 30px;
  text-align: center;
}

.about-intro {
  text-align: center;
  font-size: 16px;
  margin-bottom: 50px;
  line-height: 1.8;
}

.about-row {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  margin-bottom: 50px;
  gap: 30px;
}

.about-text {
  flex: 1 1 30%;
}

.about-text h2 {
  font-size: 24px;
  margin-bottom: 10px;
}

.about-text p,
.about-text ul {
  font-size: 16px;
  line-height: 2.4;
}

.about-text ul {
  list-style-type: disc;
  padding-left: 20px;
}

.about-img {
  flex: 1 1 30%;
}

.about-img img {
  width: 100%;
  border-radius: 10px;
  object-fit: cover;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

</style>
<body>
    <header class="header">
        <div class="icon-bar">
            <div class="icon-container">
              <div class="logo"><a href="./index.jsp"><img src="./logo/logo.png" alt="Logo"></a></div>
              <form action="search.jsp" method="get" accept-charset="UTF-8">
                <img class="header-icon" src="icon/search.png" id="search">
                <input type="text" name="query" placeholder="search" class="input-search">
                <button type="submit" class="search-button" style="display: none;"></button>
            </form>
       
             <a href="./cart.jsp"><img src="./icon/shopping-cart.png" class="header-icon"></a>
             <a href="./mypage_updatemember.jsp"><img src="./icon/profile-white.png" class="header-icon"></a>
			 
             <a href="./logout.jsp">Logout</a>
         
            </div>
            <button class="hamburger" id="hamburgerBtn">
              <img src="./icon/header__toggle.png" alt="">
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

    <main class="about-section">
        <div class="about-container">
          <h1>회사소개</h1>
          <p class="about-intro">
花, 사계절의 꽃 향을 가득 담아 감성적인 향을
자극하며,<br> 탄생화로 연결 지어 나의 향으로 만들
수 있는 꽃 향을 가득 담은 향수와 디퓨저 판매
사이트입니다.
          </p>
      
          <div class="about-row">
            <div class="about-text">
<h2>우리의 미션</h2>
<p>
  花는 향기의 힘을 믿습니다. 향기는 단순한 냄새를 넘어, <br>사람의 감정을 위로하고 추억을 불러일으키며,<br> 공간을 특별하게 만듭니다.<br>
  우리는 자연에서 영감을 받은 향으로 사람과 사람,<br> 사람과 자연을 이어주는 다리가 되고자 합니다.<br>
  고객 한 사람, 한 사람의 감성을 담은 맞춤형 향수와<br> 디퓨저를 통해, 일상 속 특별한 순간을 선물합니다.
</p>

            </div>
            <div class="about-img">
              <img src="./image/make_perfume2.jpg" alt="우리의 미션 이미지">
            </div>
          </div>
      
          <div class="about-row">
            <div class="about-img"  style="margin-right: 10px;">
              <img src="./image/b.jpg" alt="회사 연혁 이미지">
            </div>
            <div class="about-text">
<h2>우리가 전하는 향기</h2>
<p>
  향기는 보이지 않지만, 마음 깊은 곳에 닿는 언어입니다.<br>
  花는 계절의 감정, 사람의 기억,<br> 그리고 자연의 숨결을 향기로 표현합니다.<br>
  어떤 향은 첫사랑을, 어떤 향은 여행의 순간을 떠오르게 합니다.<br>
  우리의 향기는 단순한 제품이 아니라, <br>고객의 이야기를 담은 감정의 편지입니다.<br>
  일상의 무심한 순간에 스며들어 따뜻한 위로가 되기를 바랍니다.
</p>

            </div>
          </div>
      
          <div class="about-row">
            <div class="about-text">
<h2>핵심 가치</h2>
<ul>
  <li><strong>고객 중심:</strong> 고객의 목소리를 가장 먼저 듣고,<br> 가장 깊이 반영합니다.</li><br>
  <li><strong>자연 친화:</strong> 자연에서 온 원료만을 사용하여<br> 지구와의 조화를 추구합니다.</li><br>
  <li><strong>정직한 원료:</strong> 인공 향보다 자연의 향을 담기 위해, <br>믿을 수 있는 성분만을 고집합니다.</li><br>
  <li><strong>감성 디자인:</strong> 시각과 후각이 어우러지는 <br>아름다움을 추구합니다.</li>
</ul>

            </div>
            <div class="about-img">
              <img src="./image/a.jpg" alt="핵심 가치 이미지">
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
</body>
</html>