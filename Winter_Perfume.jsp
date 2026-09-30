<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
 <link rel="stylesheet" href="css/Product.css">
    <link rel="stylesheet" href="css/header_footer.css">
    <script src="./js/product.js" defer></script>
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
   

    <div class="container1">
    <p style="margin: 40px 0px 85px 150px; font-size:15px;">Home > 겨울 > <strong>향수</strong></p>
    <div class="container" style="display: flex;">
        <aside class="sidebar">
            <div class="filters-box"><p style="font-size: 18px; font-weight: bold; margin-left: 15px; margin-top: 10px;">WINTER</p></div>
            <h2 style="font-size: 18px; margin-top: 35px; margin-left: 2px;">Categories</h2>
            <ul class="category-list">
                <form action="search.jsp" method="get" accept-charset="EUC-KR">
                <img class="header-icon" src="icon/search.png" id="search">
                <input type="text" name="query" placeholder="search" class="search-box">
                <button type="submit" class="search-button" style="display: none;"></button>
				</form>
                
			<a href="Winter_Product.jsp">
                <li>
                         All (20)
                </li>
				</a>

                <a href="Winter_Perfume.jsp">
                <li>
                        Perfume (10)
                 
                </li>
				</a>

                 <a href="Winter_diffuser.jsp">
                <li>
                        Diffuser (10)
                </li>
				</a>
            </ul>
            <hr style="color: #e6e6e6; height: 1px; border:none; margin: 35px 0px; box-shadow: none;">

        </aside>
        <section class="product-grid">
<%
    String url = "jdbc:mysql://localhost:3306/flower";
    String user = "multi";
    String password = "abcd";
    
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(url, user, password);
        stmt = conn.createStatement();
        String sql = "SELECT prdNo, prdName, prdImg, prdPrice FROM product WHERE prdNo BETWEEN 31 AND 40"; 
        rs = stmt.executeQuery(sql);
%>

<section class="product-list">
    <% while (rs.next()) { %>
<a href="Product_detail.jsp?prdNo=<%= rs.getInt("prdNo") %>">
        <div class="product-card">
            <div class="product-image-wrapper">
                <img src="<%= rs.getString("prdImg") %>" alt="<%= rs.getString("prdName") %>" class="product-image">
            </div>
            <h3 class="product-title"><%= rs.getString("prdName") %></h3>
            <p class="product-price"><%= String.format("%,d원", rs.getInt("prdPrice")) %></p>
        </div>
		</a>
    <% } %>
</section>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>

    </div>
<a href="recipe.jsp">
  <div class="ad-box">
    <!-- 10% 할인쿠폰 -->
  </div>
</a>
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
  <script>
        window.addEventListener("DOMContentLoaded", () => {
          const header = document.querySelector(".header");
      
          const currentSeason = "winter"; // 여기에 "spring", "summer", "autumn", "winter" 중 하나 넣기
          const allSeasons = ["spring", "summer", "autumn", "winter"];
      
          setTimeout(() => {
            if (header) {
              // 기존 계절 클래스 제거
              allSeasons.forEach(season => {
                header.classList.remove(season);
              });
      
              // 현재 계절 클래스 추가
              header.classList.add(currentSeason);
              console.log(`?? 계절 테마 적용됨: ${currentSeason}`);
            }
          }, 100);
        });
      </script>
</body>
</html>