<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="euc-kr">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/header_footer.css">
  <script src="./js/product.js" defer></script>
  <script src="./js/header.js" defer></script>
  <link rel="stylesheet" href="./css/fade-in.css">
  <script src="./js/fade-in.js"></script>
  <style>
  

    body, html {
      height: 100%;
      background-color: #1a1a1a;
    }

    .hero-section {
      position: relative;
      height: 100vh;
      background-image: url('./image/cus_main.png');
      max-width: 1920px;
      height: 900px;
      background-size: cover; 
      background-position: center;
      display: flex;
      justify-content: center;
      align-items: center;
      color: white;
    }

    .overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: linear-gradient(to bottom, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0));
      z-index: 1;
    }

    .text-box {
      position: relative;
      z-index: 2;
      text-align: center;
      background: rgba(255, 255, 255, 0.05);
      padding: 50px 70px;
      border-radius: 24px;
      max-width: 1440px;
      margin: 0 auto;
      border: 1px solid rgba(255, 255, 255, 0.2);
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
    }

    .text-box h1 {
      font-size: 60px;
      margin-bottom: 20px;
      font-weight: bold;
      text-shadow: 3px 3px 8px rgba(0,0,0,0.6);
    }

    .text-box p {
      font-size: 24px;
      margin-bottom: 40px;
      text-shadow: 2px 2px 6px rgba(0,0,0,0.5);
    }

    .btn-group {
      display: flex;
      justify-content: center;
      gap: 20px;
      flex-wrap: wrap;
    }

    .btn {
      padding: 14px 30px;
      font-size: 24px;
      border: none;
      background: rgba(255, 255, 255, 0.2);
      color: white;
      cursor: pointer;
      border-radius: 30px;
      backdrop-filter: blur(5px);
      transition: all 0.3s ease;
      border: 1px solid #ffffff55;
    }

    .btn:hover {
      background: white;
      color: #222;
    }

    @media (max-width: 500px) {
      .text-box h1 {
        font-size: 2rem;
      }

      .text-box p {
        font-size: 1.1rem;
      }

      .btn {
        width: 100%;
      }
    }
  </style>
</head>

<body>
<%
    String id = (String) session.getAttribute("sid");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
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
  <div class="hero-section">
    <div class="overlay"></div>
    <div class="text-box fade-in">
      <h1>나만의 향수 커스텀 만들기</h1>
      <p>당신의 취향을 담은 향기를 완성해 보세요</p>
      <div class="btn-group">
        <button class="btn" onclick="location.href='custom2.html'">직접 커스텀</button>
        <button class="btn" onclick="location.href='recipe.jsp'">커스텀 레시피 추천</button>
      </div>
    </div>
  </div>
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
