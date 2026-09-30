<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/header_footer.css">
    <link rel="stylesheet" href="./css/myReview.css">
    <script src="./js/header_footer.js" defer></script>
    <script src="./js/myReview.js" defer></script>
	<script src="./js/header.js" defer></script>
    <script src="https://kit.fontawesome.com/b470949ecb.js" crossorigin="anonymous"></script>
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
                <li style="opacity: 1;"><a href="./myReview.jsp"><img src="icon/favorites.png"> 리뷰</a></li>
                <li><a href="./mypage_order_history.jsp"><img src="icon/payment-method.png"> 구매 내역</a></li>
                <li><a href="./mypage_delivery_status.jsp"><img src="icon/car.png"> 배송 현황</a></li>
            </ul>
        </div>
        <div class="Review-con">
            <p>홈 > 마이페이지 > 리뷰</p>
            <div class="profile">
             <h1 style="margin-top:30px;">리뷰</h1>
        </div>
    <div class="review-container">
      <h2>구매하신 상품은 어떠셨나요?</h2>
<div class="tabs-box">
    <div class="tabs">
        <button class="active">리뷰 남기기</button>
    </div>

<%
String id = (String) session.getAttribute("sid");
if (id == null) {
    response.sendRedirect("login.jsp");
    return;
}

String DB_URL = "jdbc:mysql://localhost:3306/flower";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
boolean hasData = false;

try {
    Class.forName("org.gjt.mm.mysql.Driver");
    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String sql = "SELECT op.ctNo, op.prdNo, op.ctQty, op.prdImg, op.mapping_id, " +
                 "p.prdName, p.prdPrice, p.prdType, op.ordNo, " +
                 "m.color, m.size " +
                 "FROM orderproduct op " +
                 "JOIN product p ON op.prdNo = p.prdNo " +
                 "LEFT JOIN mapping_id m ON op.mapping_id = m.mappingId " +
                 "LEFT JOIN review r ON op.prdNo = r.prdNo AND op.memId = r.memId " +
                 "WHERE op.memId = ? AND r.reviewId IS NULL " +
                 "ORDER BY op.ordNo DESC";

    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, id);
    rs = pstmt.executeQuery();

    while (rs.next()) {
        hasData = true; //  구매 데이터가 있음을 표시
        int prdNo = rs.getInt("prdNo");
        String prdImg = rs.getString("prdImg");
        String prdName = rs.getString("prdName");
        String prdType = rs.getString("prdType");
        int ctQty = rs.getInt("ctQty");
        double prdPrice = rs.getDouble("prdPrice");
        String color = rs.getString("color");
        String size = rs.getString("size");
        int ordNo = rs.getInt("ordNo");
%>
<div class="review-card" id="card1">
    <img src="<%= prdImg %>" alt="상품 이미지">
    <div class="review-info">
        <div class="review-header">
            <h3 class="product-type"><%= prdName %> (<%= prdType %>)</h3>
        </div>
        <div class="product-options">
<p class="product-option">구매 수량: <%= ctQty %>개</p>

<%
    // 사이즈에 따른 가격 조정 로직
    int adjustedPrice = (int) prdPrice;

    if ("125ML".equals(size)) {
        adjustedPrice += 10000;
    } else if ("150ML".equals(size)) {
        adjustedPrice += 20000;
    } else if ("175ML".equals(size)) {
        adjustedPrice += 30000;
    } else if ("200ML".equals(size)) {
        adjustedPrice += 40000;
    }
%>

<p class="product-option">상품 가격: <%= String.format("%,d", adjustedPrice) %>원</p>
<p class="product-option">옵션: <%= color %> / <%= size %></p>
        </div>
    </div>
    <div class="review-actions">
        <button class="btn btn-edit" onclick="openReviewPopup(<%= prdNo %>)">리뷰 등록하기</button>
    </div>
</div>
<%
    }

    if (!hasData) {
%>
    <p style="text-align: left; font-size: 18px; margin-left: 10px;">구매한 상품이 없습니다.</p>
<%
    }

} catch (Exception e) {
    e.printStackTrace();
} finally {
    try { if (rs != null) rs.close(); } catch (SQLException e) {}
    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
    try { if (con != null) con.close(); } catch (SQLException e) {}
}
%>

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
function openReviewPopup(prdNo) {
    window.open("reviewSubmit.jsp?prdNo=" + prdNo, "리뷰 작성", "width=370,height=660");
}
</script>

</body>
</html>