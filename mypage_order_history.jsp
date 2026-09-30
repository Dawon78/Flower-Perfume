<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/mypage_order_history.css">
    <link rel="stylesheet" href="css/header_footer.css">
    <script src="./js/header_footer.js" defer></script>
    <link rel="stylesheet" href="css/address.css">
    <script src="./js/cart.js" defer></script>
	<script src="./js/header.js" defer></script>
	<style>
	.my-frame {
     height: 850px;
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
            <li><a href="./mypage_updatemember.jsp"><img src="icon/pencil.png"> 프로필 수정</a></li>
            <li><a href="./mypage_Question.jsp"><img src="icon/padlock.png"> 문의사항</a></li>
            <li><a href="./mypage_cart.jsp"><img src="icon/shopping-bag.png"> 장바구니</a></li>
            <li><a href="./mypage_wish.jsp"><img src="icon/heart.png"> 찜 내역</a></li>
						<li ><a href="./myReview.jsp"><img src="icon/favorites.png"> 리뷰</a></li>
            <li style="opacity: 1;"><a href="./mypage_order_history.jsp"><img src="icon/payment-method.png"> 구매 내역</a></li>
            <li><a href="./mypage_delivery_status.jsp"><img src="icon/car.png"> 배송 현황</a></li>
        </ul>
    </div>
    <div class="cart-box">
        <p>홈 > 마이페이지 > 구매 내역</p>
        <div class="profile">
         <h1 style="margin-top:30px;">구매 내역</h1>
        </div>
        
        <div class="container">
            <%
    String id = (String) session.getAttribute("sid");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // DB 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        
        String sql = "SELECT op.ordNo, oi.ordDate " +
             "FROM orderproduct op " +
             "JOIN orderinfo oi ON op.ordNo = oi.ordNo " +
             "WHERE op.memId = ? " +
             "ORDER BY op.ordNo DESC " +
             "LIMIT 1";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id); 
        rs = pstmt.executeQuery();

        if (rs.next()) {
            int ordNo = rs.getInt("ordNo");
			Date ordDate = rs.getDate("ordDate");
            %>
           
            
            <div class="order-info" ></div><!--구매갯수-->

         <iframe   class="my-frame" src="./mypage_order_h_list.jsp" ></iframe>
	 </div>
            <%
        } else {
            out.println("<p style= 'margin-top: 70px;'>구매 내역이 없습니다.</p>");
        }

    } catch (SQLException e) {
        out.println("<p style='color: red;'> 데이터베이스 오류 발생: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException ignored) {}
    }
%>
        </div>
    </div>
    </div>
<footer class="footer" style="margin-top:80px;">
    <div class="footer-container">
        <div class="footer-logo">
            <img src=".//logo/logo.png">
            <p>꽃·향은 꽃말 취향에 따라 이용자들의 취향을 파악하고, 취향에
                <br>맞는 향수와 디퓨저를 추천해 고객 니즈를 완벽히 파악하는<br>
                취지의 회사입니다.</p>
        </div>

        <div class="footer-links">
            <div class="footer-column col1">
                <h3>COMPANY</h3>
                <ul> 
                    <li><a href="./about.jsp" title="회사소개">About Us</a></li>
                    <li><a href="./terms.jsp" title="이용약관">Terms of Service</a></li>
                    <li><a href="./privacy.jsp" title="개인정보처리방침">Privacy Policy</a></li>
                    <li><a href="./manager_login.jsp" title="관리자 로그인">Manager</a></li>
                </ul>
            </div>

            <div class="footer-column col2">
                <h3>NOTICE</h3>
                <ul>
                    <li><a href="./contact.jsp" title="고객문의">Contact Us</a></li>
                    <li><a href="./faq.jsp" title="자주 묻는 질문">FAQs</a></li>
                    <li><a href="./shipping.jsp" title="배송 안내">Shipping Guide</a></li>
                    <li><a href="./return.jsp" title="교환/환불 정책">Return & Refund Policy</a></li>
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
