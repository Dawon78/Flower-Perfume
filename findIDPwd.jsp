<%@ page contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/findIDPwd.css">
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
         <h1 class="login-logo">아이디 찾기</h1>
         <p class="subtitle">가입 시 등록한 휴대폰 번호를 입력해 주세요</p>

         <form id="find-id-form" method="post">
             <label for="memPhone">휴대폰 번호</label>
             <input type="text" id="memPhone" name="memPhone" placeholder="ex) 010-1234-5678" required>
                         <%
             String memPhone = request.getParameter("memPhone");
             String memId = null;

             if (memPhone != null && !memPhone.isEmpty()) {
                 try {
                     Connection conn = DriverManager.getConnection(
                         "jdbc:mysql://localhost:3306/flower", "multi", "abcd");
                     PreparedStatement pstmt = conn.prepareStatement(
                         "SELECT memId FROM member WHERE memPhone = ?");
                     pstmt.setString(1, memPhone);
                     ResultSet rs = pstmt.executeQuery();

                     if (rs.next()) {
                         memId = rs.getString("memId");
                     }
                     rs.close();
                     pstmt.close();
                     conn.close();
                 } catch (Exception e) {
                     e.printStackTrace();
                 }
             }

             if (memId != null) {
         %>
             <p style="text-align: center; margin-top: 0px; margin-bottom: 20px;">회원님의 아이디는 <strong><%= memId %></strong> 입니다.</p>
         <% } else if (memPhone != null) { %>
             <p style="text-align: center; margin-top: 0px; margin-bottom: 20px;">해당 전화번호로 등록된 아이디가 없습니다.</p>
         <% } %>
             <button type="submit" class="sign-in">아이디 찾기</button>
             <a href="./login.jsp" data-page="login.jsp" class="go-back">로그인으로 돌아가기</a>
         </form>
     </div>


 <div class="separator"> </div>


<div class="login-box">
 <h1 class="login-logo">비밀번호 찾기</h1>
 <p class="subtitle">이메일을 입력해주세요.</p>
 
 <form id="login-form" method="post">
     <label for="memEmail">Email</label>
     <input type="email" id="memEmail" name="memEmail" placeholder="Example@email.com" required>
             <%
         String memEmail = request.getParameter("memEmail");
         String memPasswd = null;

         if (memEmail != null && !memEmail.trim().isEmpty()) {
             try {
                 Class.forName("org.gjt.mm.mysql.Driver");
                 Connection conn = DriverManager.getConnection(
                     "jdbc:mysql://localhost:3306/flower", "multi", "abcd");
                 PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT memPasswd FROM member WHERE memEmail = ?");
                 pstmt.setString(1, memEmail);
                 ResultSet rs = pstmt.executeQuery();

                 if (rs.next()) {
                     memPasswd = rs.getString("memPasswd");
                 }
                 rs.close();
                 pstmt.close();
                 conn.close();
             } catch (Exception e) {
                 e.printStackTrace();
             }
         }
     %>

     <% if (memPasswd != null) { %>
         <p style="text-align: center; margin-top: 0px; margin-bottom: 20px;">회원님의 비밀번호는 <strong><%= memPasswd %></strong> 입니다.</p>
     <% } else if (memEmail != null) { %>
         <p style="text-align: center; margin-top: 0px; margin-bottom: 20px;">해당 이메일로 등록된 비밀번호가 없습니다.</p>
     <% } %>
     <button type="submit" class="sign-in">비밀번호 찾기</button>
     <a href="./login.jsp" data-page="login.jsp" class="go-back">로그인으로 돌아가기</a>
     
 </form>
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