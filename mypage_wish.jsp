<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/mypage_wish.css">
    <link rel="stylesheet" href="css/header_footer.css">
    <script src="./js/header_footer.js" defer></script>
	<script src="./js/header.js" defer></script>
	    <script type="text/javascript">
        function removeFromWishlist(prdNo) {
            if (confirm("정말로 찜 목록에서 삭제하시겠습니까?")) {
                // 삭제 요청을 위한 폼을 생성
                const form = document.createElement("form");
                form.method = "POST";
                form.action = "inWish.jsp";  // 상품 삭제를 처리하는 페이지

                // prdNo 값 전달
                const prdNoField = document.createElement("input");
                prdNoField.type = "hidden";
                prdNoField.name = "prdNo";
                prdNoField.value = prdNo;
                form.appendChild(prdNoField);

                // 삭제 액션 전달
                const actionField = document.createElement("input");
                actionField.type = "hidden";
                actionField.name = "action";
                actionField.value = "remove";  // 삭제 액션
                form.appendChild(actionField);

                // 폼 제출
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
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
        <div class="sidebar">
            <h3>마이페이지</h3>
             <ul class="mypage_side">
            <li ><a href="./mypage_updatemember.jsp"><img src="icon/pencil.png"> 프로필 수정</a></li>
            <li ><a href="./mypage_Question.jsp"><img src="icon/padlock.png"> 문의사항</a></li>
            <li><a href="./mypage_cart.jsp"><img src="icon/shopping-bag.png"> 장바구니</a></li>
            <li style="opacity: 1;"><a href="./mypage_wish.jsp"><img src="icon/heart.png"> 찜 내역</a></li>
			<li ><a href="./myReview.jsp"><img src="icon/favorites.png"> 리뷰</a></li>
            <li><a href="./mypage_order_history.jsp"><img src="icon/payment-method.png"> 구매 내역</a></li>
            <li><a href="./mypage_delivery_status.jsp"><img src="icon/car.png"> 배송 현황</a></li>
        </ul>
        </div>
        <div class="wish-box">
            <p>홈 > 마이페이지 > 찜 내역</p>
            
            <div class="profile">
 <h1 style="margin-top:30px;">찜 내역</h1>
</div>
<% 
    String DB_URL = "jdbc:mysql://localhost:3306/flower"; // DB명
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    // 현재 로그인된 사용자 ID 가져오기
    String memId = (String) session.getAttribute("sid");

    if (memId == null) {
%>
    <script>
        alert('로그인이 필요합니다. 로그인 후 이용해주세요.');
        window.location.href = 'login.jsp';
    </script>
<%
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String wishSql = "SELECT p.prdNo, p.prdName, p.prdImg, p.prdPrice, p.prdColor1, p.prdColor2, p.prdColor3 " +
                         "FROM wish w JOIN product p ON w.prdNo = p.prdNo WHERE w.memId = ?";
        pstmt = conn.prepareStatement(wishSql);
        pstmt.setString(1, memId);
        rs = pstmt.executeQuery();
%>



<div class="wishlist-container">
    <div class="wishlist-title">나의 찜 목록</div>
    <div class="wishlist-items" id="wishlist">
        <% 
        boolean hasItems = false;
        while (rs.next()) { 
            hasItems = true;
            String prdNo = rs.getString("prdNo"); 
            String color1 = rs.getString("prdColor1"); 
            String color2 = rs.getString("prdColor2"); 
            String color3 = rs.getString("prdColor3");
        %>
<div class="wishlist-item" 
    style="background-image: url('<%= rs.getString("prdImg") %>'); 
           cursor: pointer;"
    onclick="location.href='Product_detail.jsp?prdNo=<%= rs.getString("prdNo") %>'">
    
    <div class="item-title"><%= rs.getString("prdName") %></div>
            <div class="colors">
                <p>Colors</p>
                <% if (color1 != null && !color1.isEmpty()) { %>
                    <span class="color-dot" style="background-color: <%= color1 %>;"></span>
                <% } %>
                <% if (color2 != null && !color2.isEmpty()) { %>
                    <span class="color-dot" style="background-color: <%= color2 %>;"></span>
                <% } %>
                <% if (color3 != null && !color3.isEmpty()) { %>
                    <span class="color-dot" style="background-color: <%= color3 %>;"></span>
                <% } %>
                <% if ((color1 == null || color1.isEmpty()) && (color2 == null || color2.isEmpty()) && (color3 == null || color3.isEmpty())) { %>
                    <span>No Color</span>
                <% } %>
            </div>
            <div class="flex">
                <div class="price"><%= String.format("%,d원", rs.getInt("prdPrice")) %></div>
                
                <!-- 삭제 요청을 보내는 폼 -->
                <form action="deleteWish.jsp" method="post">
                    <input type="hidden" name="prdNo" value="<%= prdNo %>">
                    <button type="submit" class="wishlist-btn active">♥</button>
                </form>

            </div>
        </div>
        <% } %>

        <% if (!hasItems) { %>
            <p style="text-align: center; width: 100%;">찜한 상품이 없습니다.</p>
        <% } %>
    </div>
</div>

<!-- 최근 본 상품 -->
<div class="wishlist-container">
    <div class="wishlist-title">최근 본 상품</div>
    <div class="wishlist-items" id="recentlyViewed">
        <% 
            // 최근 본 상품 조회 쿼리 (색상 데이터 추가)
            String recentSql = "SELECT p.prdNo, p.prdName, p.prdImg, p.prdPrice, p.prdColor1, p.prdColor2, p.prdColor3 " +
                               "FROM recentlyviewed rv JOIN product p ON rv.prdNo = p.prdNo " +
                               "WHERE rv.memID = ? ORDER BY rv.viewedAt DESC LIMIT 10";
            pstmt = conn.prepareStatement(recentSql);
            pstmt.setString(1, memId);
            rs = pstmt.executeQuery();

            boolean hasRecentItems = false;
            while (rs.next()) {
                hasRecentItems = true;
                String recentPrdNo = rs.getString("prdNo");
                String color1 = rs.getString("prdColor1");
                String color2 = rs.getString("prdColor2");
                String color3 = rs.getString("prdColor3");
        %>
        <div class="wishlist-item" 
            style="background-image: url('<%= rs.getString("prdImg") %>'); cursor: pointer;"
            onclick="location.href='Product_detail.jsp?prdNo=<%= rs.getString("prdNo") %>'">
            
            <div class="item-title"><%= rs.getString("prdName") %></div>
            <div class="colors">
                <p>Colors</p>
                <% if (color1 != null && !color1.isEmpty()) { %>
                    <span class="color-dot" style="background-color: <%= color1 %>;"></span>
                <% } %>
                <% if (color2 != null && !color2.isEmpty()) { %>
                    <span class="color-dot" style="background-color: <%= color2 %>;"></span>
                <% } %>
                <% if (color3 != null && !color3.isEmpty()) { %>
                    <span class="color-dot" style="background-color: <%= color3 %>;"></span>
                <% } %>
                <% if ((color1 == null || color1.isEmpty()) && (color2 == null || color2.isEmpty()) && (color3 == null || color3.isEmpty())) { %>
                    <span>No Color</span>
                <% } %>
            </div>
            <div class="flex">
                <div class="price1"><%= String.format("%,d원", rs.getInt("prdPrice")) %></div>
            </div>
        </div>
        <% } %>

        <% if (!hasRecentItems) { %>
            <p style="text-align: center; width: 100%;">최근 본 상품이 없습니다.</p>
        <% } %>
    </div>
</div>

<% 
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        // 자원 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</div>
</div>

            </div>
        </div>
            </div>
        </div>
        </div>
   
        </div>
    </div>
<footer class="footer" style="margin-top: 80px;">
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
    document.querySelectorAll(".wishlist-btn").forEach(button => {
        button.addEventListener("click", function() {
            let prdNo = this.getAttribute("data-prdno");
            let btn = this;

            fetch("inWish.jsp", {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: "prdNo=" + prdNo
            })
            .then(response => response.text())
            .then(data => {
                if (btn.classList.contains("active")) {
                    btn.classList.remove("active");
                    btn.innerText = "♡";
                    btn.closest(".wishlist-item").remove(); // 삭제 후 UI에서 제거
                } else {
                    btn.classList.add("active");
                    btn.innerText = "♥";
                }
            })
            .catch(error => console.error("Error:", error));
        });
    });

	const slider = document.getElementById('wishlist');
let isDown = false;
let startX;
let scrollLeft;

slider.addEventListener('mousedown', (e) => {
    isDown = true;
    startX = e.clientX;
    scrollLeft = slider.scrollLeft;
    slider.style.cursor = 'pointer';
    e.preventDefault();
});

slider.addEventListener('mouseleave', () => {
    isDown = false;
    slider.style.cursor = 'pointer'; 
});

slider.addEventListener('mouseup', () => {
    isDown = false;
    slider.style.cursor = 'pointer'; 
});

slider.addEventListener('mousemove', (e) => {
    if (!isDown) return;
    e.preventDefault();
    const x = e.clientX;
    const walk = x - startX;
    slider.scrollLeft = scrollLeft - walk;
});
</script>

    </body>
    </html>