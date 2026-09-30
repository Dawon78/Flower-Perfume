<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/login.css">
    <link rel="stylesheet" href="./css/header_footer.css">
	    <script src="./js/header.js" defer></script>
</head>
<body>
      <header class="header">
        <div class="icon-bar">
            <div class="icon-container">
              <div class="logo"><a href="./index.html"><img src="./logo/logo.png" alt="Logo"></a></div>
              <form action="search1.jsp" method="get" accept-charset="EUC-KR">
                <img class="header-icon" src="icon/search.png" id="search">
                <input type="text" name="query" placeholder="search" class="input-search">
                <button type="submit" class="search-button" style="display: none;"></button>
            </form>
       
             <a href="./cart.jsp"><img src="./icon/shopping-cart.png" class="header-icon"></a>
             <a href="./mypage_updatemember.jsp"><img src="./icon/profile-white.png" class="header-icon"></a>
             <a href="./login.jsp">Login</a>
         
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
                        <a href="Spring_Perfume1.jsp">향수</a>
                        <a href="Spring_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Summer_Perfume1.jsp">향수</a>
                        <a href="Summer_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Autumn_Perfume1.jsp">향수</a>
                        <a href="Autumn_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="Winter_Perfume1.jsp">향수</a>
                        <a href="Winter_diffuser1.jsp">디퓨저</a>
                      </div>
                      <div class="submenu">
                        <a href="flowersBook1.jsp">사계 백과사전</a>
                      </div>
                      <div class="submenu">
                        <a href="my_perfume_notes1.jsp">향수의 기본 구조</a>
                        <a href="custom1.jsp">향수 커스텀</a>
                      </div>
                    </div>
                
                </nav>
            </div>
        </div>
    </header>
    <div class="login-container">
        <div class="login-box">
            <h1 class="login-logo"><img src="./logo/logo_black.png" alt="Logo"></h1>
            <p class="subtitle">맑고 깨끗한 마음으로 하루를 시작해 보세요.<br>진심이 전해지는 하루가 될 거예요</p>
            
            <form id="login-form" action="loginOK.jsp" method="post">
    <label for="memId">ID</label>
    <input type="text" id="memId" name="memId" required>
    
    <label for="memPasswd">PASSWORD</label>
    <input type="password" id="memPasswd" name="memPasswd"  required >
    
    <a href="./findIDPwd.jsp" class="forgot-password">Forgot Id/Password?</a>
   
    <button type="submit" class="sign-in">Sign in</button>
</form>
            
            
            <p class="signup">Don't have an account? <a href="./Join_membership.jsp" class="sing-up"> Sign up</a></p>
            <p class="p">ⓒ 2025 ALL RIGHTS RESERVED</p>
        </div>
        <div class="image-box">
            <img src="./image/Art.png" alt="Art">
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
                    <li><a href="./about1.jsp" title="회사소개">About Us</a></li>
                    <li><a href="./terms_privacy1.jsp" title="Terms and Privacy">Terms & Policy</a></li>

               <li><a href="./faq1.jsp" title="자주 묻는 질문">FAQs</a></li>
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