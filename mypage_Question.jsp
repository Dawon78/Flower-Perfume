<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/mypage_Question.css">
    <link rel="stylesheet" href="css/header_footer.css">
    <script src="./js/header_footer.js" defer></script>
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
             <a href="./login.jsp">Logout</a>
         
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
   
            <li style="opacity: 1;"><a href="./mypage_Question.jsp"><img src="icon/padlock.png"> 문의사항</a></li>
            <li><a href="./mypage_cart.jsp"><img src="icon/shopping-bag.png"> 장바구니</a></li>
            <li><a href="./mypage_wish.jsp"><img src="icon/heart.png"> 찜 내역</a></li>
			<li ><a href="./myReview.jsp"><img src="icon/favorites.png"> 리뷰</a></li>
            <li><a href="./mypage_order_history.jsp"><img src="icon/payment-method.png"> 구매 내역</a></li>
            <li><a href="./mypage_delivery_status.jsp"><img src="icon/car.png"> 배송 현황</a></li>
        </ul>
    </div>
    <div class="Question">
        <p>홈 > 마이페이지 > 문의사항</p>
        <div class="profile">
        <h1 style="margin-top:30px;">문의사항</h1>
        </div>

    <form action="submitQuestion.jsp" method="post">
        <div class="flex">
            <div class="form-group">
                <input type="name" id="memName" name="memName" placeholder="성함*" required>
            </div>
            <div class="form-group">
                <input type="text" id="memNick" name="memNick" placeholder="닉네임*" required>
            </div>
        </div>

        <div class="flex">
            <div class="form-group">
                <input type="number" id="memPhone" name="memPhone" placeholder="전화번호 (숫자만 입력)*" required>
            </div>
            <div class="form-group">
                <input type="email" id="memEmail" name="memEmail" placeholder="이메일*" required>
            </div>
        </div>

        <div class="flex">
            <div class="select-box">
                <select name="prdCategory" required>
                    <option selected disabled>문의 제품</option>
                    <option value="향수">향수</option>
                    <option value="디퓨저">디퓨저</option>
                </select>
            </div>
            <div class="form-group">
                <input type="text" id="prdName" name="prdName" placeholder="제품명*" required>
            </div>
        </div>
		
        <div class="form-group">
            <textarea id="questionText" name="questionText" placeholder="문의 내용을 작성해주세요.*" required></textarea>
        </div>

					<div class="notice">
                    <h1>개인정보 수집 이용에 대한 안내</h1>
                    <p>문의하신 내용의 답변을 위하여 고객님의 개인정보를 수집합니다.</p>
					<p>개인정보 수집에 동의하신 분에 한하여 문의 접수가 가능합니다.</p>
					<p>문의에 대한 답변은 제공하신 이메일을 통해 발송됩니다.</p>
                    <p>수집하는 개인정보 항목: 이름/연락처/이메일 </p>
                    <div class="radio-container">
                        <input type="radio" id="OK" name="OK" value="1">
                        <label for="OK" class="radio-label">동의합니다</label>
                    </div>
                    <br>
                    <button type="submit" class="submit-btn">제출하기</button>
					 </form>
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
        document.addEventListener("DOMContentLoaded", function () {
            document.querySelector(".submit-btn").addEventListener("click", function (event) {
                let radioChecked = document.querySelector("input[name='OK']:checked");
        
                if (!radioChecked) {
                    alert("개인정보 수집 이용에 동의해야 제출할 수 있습니다.");
                    event.preventDefault();
                }
            });
        });
        </script>
</body>
</html>