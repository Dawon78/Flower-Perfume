<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/My_perfume_notes.css">
    <link rel="stylesheet" href="./css/header_footer.css">
    <link rel="stylesheet" href="./css/fade-in.css">
    <script src="./js/fade-in.js"></script>
    <script src="./js/header.js" defer></script>
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
                        <a href="Autumn_diffuser1.jsp">디퓨저</a>
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
    <div class="container">
        <div class="Main-image">
            <p class="Main-text fade-in">"향수의 깊이를 느끼다"</p>
            <p class="Main-text1 fade-in">완벽한 향을 위한 3단계</p>
            <p class="Main-text2 fade-in">향수는 단순히 향기를 풍기기 위한 제품이 아닙니다. 여러 가지 향료가 섬세하게 조화를 이루어, 사용자가 느끼는 향을 만들어냅니다.</p>
            <div class="arrow-container">
                <span class="arrow fade-in"><img src="./icon/down.png"></span>
                <span class="arrow fade-in"><img src="./icon/down.png"></span>
                <span class="arrow fade-in"><img src="./icon/down.png"></span>
              </div>
              
        </div>
   
<div class="background-img">


    <div class="intro">   
      <div class="right ">
        <div class="image-text fade-left">
            <h1>향수의 기본 구조<br>탑, 미들, 베이스 노트의 세계</h1>
            <p>완벽한 향을 찾다. 그리고 내 향을 찾다.</p>
            <img src="./image/make_perfume4.png" alt="향수 병들">
        </div>
        <div class="intro-text fade-right">
            <div class="note-container">
                <div class="note-header">
                    <div class="note-number">1</div>
                    <div class="note-title">탑 노트 (TOP NOTES)</div>
                </div>
                <div class="note-description">
                    탑 노트는 향수를 처음 뿌렸을 때 가장 먼저 느껴지는 향기입니다.<br> 일반적으로 상쾌하고 가벼운 향으로, 사람들에게 첫인상을 남깁니다. 하지만 탑 노트는 가장 빨리 사라지는 특징이 있습니다. 
                </div>
                <div class="note-example">예시: 시트러스(레몬, 오렌지), 민트, 라벤더, 베르가못</div>
            </div>
        
            <div class="note-container">
                <div class="note-header">
                    <div class="note-number">2</div>
                    <div class="note-title">미들 노트 (MIDDLE NOTES)</div>
                </div>
                <div class="note-description">
                    미들 노트는 탑 노트가 사라지고 나서 나타나는 향기로, 향수의 '심장'이라고도 불립니다. 미들 노트는 향수의 본연의 특징을 나타내며, 전체적인 향의 조화를 이룹니다. 
                </div>
                <div class="note-example">예시: 장미, 자스민, 리라악, 마조람, 향신료</div>
            </div>
        
            <div class="note-container">
                <div class="note-header">
                    <div class="note-number">3</div>
                    <div class="note-title">베이스 노트 (BASE NOTES)</div>
                </div>
                <div class="note-description">
                    베이스 노트는 향수의 지속력과 깊이를 책임지는 노트입니다.<br> 시간이 지나면서 점차적으로 나타나며, 다른 노트들과 조화를 이루어 전체적인 향을 안정시키며, 풍부한 여운을 남깁니다.
                </div>
                <div class="note-example">예시: 샌달우드, 바닐라, 앰버, 머스크, 시더우드</div>
            </div>
        </div>
      </div>
    </div>

 <div class="fragrance-time fade-in">
    <div class="img"><img src="./image/make_perfume3.png" alt="향수 분사"></div>
        
        <div class="text">
            <h2>향수의 발향 시간</h2>
            <p>향수는 처음 뿌렸을 때부터 시간이 지나면서 향이 달라집니다. 노트는 시간에 따라 차례로 변화하며 각각 다른 매력을 뽐냅니다. 노트의 조화는 향수의 개성을 결정짓고, 시간에 따라 다른 경험을 제공합니다.</p>
        </div>
    </div>   
    <div class="fragrance-time fade-in">
        <div class="text">
            <h2>향수의 사용과 보관</h2>
            <p>향수는 몸이나 옷에 뿌리면 그대로 남아 있는 것이 아니라 피부로부터 발산되는 체온 또는 체취와 함께 섞여서 향기가 난다. 향수는 손목 또는 목의 맥박이 뛰는 부분에 직접 뿌린다.<br><br>
                향수는 잘 보관하지 않으면 향기가 발산되고 변색되는 일이 많으므로 직사광선이 비치지 않게 서랍이나 어두운 곳에 보관하는 것이 좋다. 또 향수는 온도에도 영향을 받는데 보통 15°C 정도가 적당하고 향수를 사용한 후에는 마개를 꼭 막아두도록 유의한다.</p>
        </div>
        <img src="./image/make_perfume5.png" alt="향수 분사">
      
    </div>
    <div class="perfume-container fade-in">
        <div class="perfume-left">
          <img src="./image/youtube.png" onclick="window.location.href='https://www.youtube.com/watch?v=TYz_b7OvHGc&t=2s'" alt="향수 실험 장면" style="cursor: pointer;">
          <div class="perfume-youtube-icon"></div>
        </div>
        <div class="perfume-right">
          <small>향수의 세계에 더 깊이 빠져보세요!</small>
          <h1>향수의 조향 과정</h1>
          <p>Copyright By 향단 HyangDan</p>
        </div>
      </div>
      <section class="section-season fade-in">
        <div class="season-container  fade-in">
          <div class="season-title-wrapper">
              <p>나만의 향을 보여줘!</p>
              <img src="./icon/flower.png">
              <div class="season-title-line"></div>
          </div>
          <h1 class="season-title">나만의 향수 만들러가기</h1>
          <div class="season-button-wrapper">
              <div class="season-horizontal-line"></div>
              <a href="custom1.jsp" class="season-button">향 담으러가기</a>
          </div>
          <p class="season-description">나만의 향수를 커스텀 한 후에 직접 구매까지 할 수 있습니다.</p>
      </div>
    

    
      </section>
      
</div>
    </div>
</main>
       <footer class="footer">
    <div class="footer-container">
        <div class="footer-logo">
            <img src=".//logo/logo.png">
            <p>花은 계절 취향에 따라 이용자들의 취향을 파악하고, 취향에                <br>맞는 향수와 디퓨저를 추천해 고객 니즈를 완벽히 파악하는<br>
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