<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/mypage_updatemember.css">
    <link rel="stylesheet" href="css/header_footer.css">
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="./js/header.js" defer></script>
	<script>
    function searchPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById("address").value = data.address;
                document.getElementById("address2").focus();
            }
        }).open();
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
    </header>

   
    <div class="container1">
    <div class="sidebar">
        <h3>마이페이지</h3>
        <ul class="mypage_side">
            <li style="opacity: 1;"><a href="./mypage_updatemember.jsp"><img src="icon/pencil.png"> 프로필 수정</a></li>
 
            <li><a href="./mypage_Question.jsp"><img src="icon/padlock.png"> 문의사항</a></li>
            <li><a href="./mypage_cart.jsp"><img src="icon/shopping-bag.png"> 장바구니</a></li>
            <li><a href="./mypage_wish.jsp"><img src="icon/heart.png"> 찜 내역</a></li>
			<li ><a href="./myReview.jsp"><img src="icon/favorites.png"> 리뷰</a></li>
            <li><a href="./mypage_order_history.jsp"><img src="icon/payment-method.png"> 구매 내역</a></li>
            <li><a href="./mypage_delivery_status.jsp"><img src="icon/car.png"> 배송 현황</a></li>
        </ul>
    </div>
<div class="update_member">
    <p>홈 > 마이페이지 > 프로필 수정</p>
    <div class="profile">
        <h1 style="margin-top:30px;">프로필 수정</h1>
        <img src="icon/profile-user.png">
    </div>
<%
    String id = (String) session.getAttribute("sid");

    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String memName = "";
    String memNick = "";
    String memEmail = "";
    String memAddress1 = "";
    String memAddress2 = "";
    String memPhone = "";
    int membirthYear = 0;
    int membirthMonth = 0;
    int membirthDay = 0;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql = "SELECT memName, memNick, memEmail, memAddress1, memAddress2, memPhone, membirthYear, membirthMonth, membirthDay FROM member WHERE memId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            memName = rs.getString("memName");
            memNick = rs.getString("memNick");
            memEmail = rs.getString("memEmail");
            memAddress1 = rs.getString("memAddress1") != null ? rs.getString("memAddress1") : "";
            memAddress2 = rs.getString("memAddress2") != null ? rs.getString("memAddress2") : "";
            memPhone = rs.getString("memPhone");
            membirthYear = rs.getInt("membirthYear");
            membirthMonth = rs.getInt("membirthMonth");
            membirthDay = rs.getInt("membirthDay");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<form action="updatememberResult.jsp" method="post">
    <div class="flex" style="padding-top: 0px;">
        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" id="name" name="memName" value="<%= memName %>" readonly>
        </div>
        <div class="form-group">
            <label for="nickname">닉네임</label>
            <input type="text" id="nickname" name="memNick" value="<%= memNick %>">
        </div>
    </div>
    <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" id="email" name="memEmail" value="<%= memEmail %>" readonly>
    </div>
 <div class="flex">
        <div class="form-group">
            <label for="address">우편번호</label>
            <div class="flex">
                <input type="text" id="address" name="memAddress1" value="<%= memAddress1 %>" placeholder="우편번호 입력">
                <button type="button" class="postcode-btn" onclick="searchPostcode()">우편번호 검색</button>
            </div>
        </div>
        <div class="form-group">
            <label for="address2">상세주소</label>
            <input type="text" id="address2" name="memAddress2" value="<%= memAddress2 %>" placeholder="상세주소 입력">
        </div>
    </div>
    <div class="form-group">
        <label for="phone">전화번호</label>
        <input type="tel" id="tel" name="memPhone" value="<%= memPhone %>" readonly>
    </div>
    <div class="flex">
        <div class="form-group">
            <label for="birth-year">출생연도</label>
            <input type="text" id="birth-year" name="membirthYear" value="<%= membirthYear %>년" readonly>
        </div>
        <div class="form-group">
            <label for="birthday">생월일</label>
            <input type="text" id="birthday" name="membirthMonth" value="<%= membirthMonth %>월  <%= membirthDay %>일" readonly>
        </div>
    </div>
    <div class="form-group">
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="memPasswd" placeholder="새 비밀번호 입력">
    </div>
	<button type="submit" class="submit-btn">저장하기</button>
   <button type="button" class="reset-btn" onclick="location.href='deleteMember.jsp?memId=<%= id %>'">회원탈퇴</button>

</form>
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
</body>
</html>