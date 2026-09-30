<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/Join_membership.css">
    <link rel="stylesheet" href="css/header_footer.css">
    <script src="/js_package.js" defer></script>
	    <script src="./js/header.js" defer></script>

	<style>
	.form-group #memPasswd {
    width: 150px;
    height: 20px;
    font-size: 13px;
    border: 1px solid #ccc;
    border-radius: 40px;
    margin-left: 30px;
    padding-left: 10px; 
}

.form-group #memName {
    width: 150px;
    height: 20px;
    font-size: 13px;
    border: 1px solid #ccc;
    border-radius: 40px;
    margin-left: 52px;
    padding-left: 10px; 
}

input::placeholder {
    font-size: 13px;  
    color: gray;     
}

	</style>
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
 <form name="newMem" method="post" action="join_membership_result.jsp" onsubmit="return validateForm()">
    <div class="join">
        <div class="join_image">
            <img src="image/sub2.png" alt="가입 이미지">
        </div>
        <div class="membership">
            <div class="logo_membership">
                <img src="logo/logo_black.png">
                <h1>회원가입</h1>
            </div>

            <div class="form-group">
                <label for="memId">아이디</label>
                <input type="text" id="memId" name="memId" style="padding-left: 10px;"> 
                <button type="button" class="check-id-btn" onclick="checkID()">중복 확인</button>
            </div>
			<script>
    function checkID() {  
        var id = document.getElementById("memId").value;

        if (id === "") {  
            alert("ID를 입력해 주세요!"); 
            document.getElementById("memId").focus(); 
            return; 
        }

        window.open("checkId.jsp?id=" + encodeURIComponent(id), "win", 
                    "width=255, height=145, scrollbars=no, resizable=no");
    }
</script>
            <hr class="form-group-hr">

            <div class="form-group">
                <label for="memPasswd">비밀번호</label>
                <input type="password" id="memPasswd" name="memPasswd" style="padding-left: 10px;"> 
            </div>
            <hr class="form-group-hr">

            <div class="form-group">
                <label for="memName">이름</label>
                <input type="name" id="memName" name="memName" style="padding-left: 10px;">
            </div>
            <hr class="form-group-hr">

            <div class="form-group">
                <label for="memNick">닉네임</label>
                <input type="text" id="memNick" name="memNick" style="padding-left: 10px;">
            </div>
            <hr class="form-group-hr">

            <div class="form-group">
                <label for="phone">휴대폰 번호</label>
                <div class="phone-group" style="margin-left: 4px;">
                    <select id="phone-prefix" name="phone-prefix" style="padding-left: 10px;">
                        <option value="010">010</option>
                        <option value="011">011</option>
                        <option value="016">016</option>
                    </select>
                    <p> - </p>
                    <input type="tel" id="phone1" name="phone1" maxlength="4" style="padding-left: 10px;">
                    <p> - </p>
                    <input type="tel" id="phone2" name="phone2" maxlength="4" style="padding-left: 10px;">
                </div>
            </div>
            <hr class="form-group-hr">

            <div class="form-group">
                <label for="membirthYear">생년월일</label>
                <div class="birthdate-group">
                    <input type="number" style="margin-left:30px; padding-left: 10px;" id="membirthYear" name="membirthYear"  maxlength="4" required placeholder="YYYY">
                    <span>년</span>
                    <input type="number" style="padding-left: 10px;" id="membirthMonth" name="membirthMonth"  maxlength="2" required placeholder="MM">
                    <span>월</span>
                    <input type="number" style="padding-left: 10px;" id="membirthDay" name="membirthDay"  maxlength="4" required placeholder="DD">
                    <span>일</span>
                </div>
            </div>
            <hr class="form-group-hr">

             <div class="form-group">
                <label>이메일</label>
                <input type="email" id="memEmail" style="margin-left: 40px; width: 145px; padding-left: 10px; " name="memEmail" placeholder="example@email.com">
            </div>
            <hr class="form-group-hr">

            <div class="form-group">
                <label>성별</label>
                <div class="gender-group">
                    <label><input type="radio" name="memSex" value="남성"> 남성</label>
                    <label><input type="radio" name="memSex" value="여성"> 여성</label>
                </div>
            </div>

            <div class="insertmember">
                <button type="submit" class="signup-btn">회원가입</button>
                <a href="./login.jsp">이미 회원이신가요?&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;로그인</a>
            </div>
        </div>
    </div>
</form>
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
  
    <script>
    const membirthMonth = document.getElementById('membirthMonth');
    const membirthDay = document.getElementById('membirthDay');

const yearInput = document.getElementById('membirthYear');
    const monthInput = document.getElementById('membirthMonth');
    const dayInput = document.getElementById('membirthDay');

    yearInput.addEventListener('input', function () {
        if (this.value.length === 4) {
            monthInput.focus();
        }
    });

    monthInput.addEventListener('input', function () {
        if (this.value.length === 2) {
            dayInput.focus();
        }
    });
    const phone1 = document.getElementById('phone1');
    const phone2 = document.getElementById('phone2');

    phone1.addEventListener('input', function () {
        if (this.value.length === 4) {
            phone2.focus();
        }
    });

    yearInput.addEventListener('input', function () {

        if (this.value.length > 4) {
            this.value = this.value.slice(0, 4);
        }
    });

    monthInput.addEventListener('input', function () {
        if (this.value.length > 2) {
            this.value = this.value.slice(0, 2); 
        }
        if (parseInt(this.value) > 12) {
            this.value = '12'; 
        }
    });

    dayInput.addEventListener('input', function () {
        if (this.value.length > 2) {
            this.value = this.value.slice(0, 2); 
        }
        if (parseInt(this.value) > 31) {
            this.value = '31'; 
        }
    });

    function validateForm() {
    const memId = document.getElementById("memId").value.trim();
    const memPasswd = document.getElementById("memPasswd").value.trim();
    const memName = document.getElementById("memName").value.trim();
    const memNick = document.getElementById("memNick").value.trim();
    const phone1 = document.getElementById("phone1").value.trim();
    const phone2 = document.getElementById("phone2").value.trim();
    const birthYear = document.getElementById("membirthYear").value.trim();
    const birthMonth = document.getElementById("membirthMonth").value.trim();
    const birthDay = document.getElementById("membirthDay").value.trim();
    const memEmail = document.getElementById("memEmail").value.trim();
    const memSex = document.querySelector('input[name="memSex"]:checked');

    if (!memId) {
        alert("아이디를 입력해주세요.");
        return false;
    }
    if (!memPasswd) {
        alert("비밀번호를 입력해주세요.");
        return false;
    }
    if (!memName) {
        alert("이름을 입력해주세요.");
        return false;
    }
    if (!memNick) {
        alert("닉네임을 입력해주세요.");
        return false;
    }
    if (!phone1 || !phone2) {
        alert("휴대폰 번호를 모두 입력해주세요.");
        return false;
    }
    if (!birthYear || !birthMonth || !birthDay) {
        alert("생년월일을 모두 입력해주세요.");
        return false;
    }
    if (!memEmail) {
        alert("이메일을 입력해주세요.");
        return false;
    }
    if (!memSex) {
        alert("성별을 선택해주세요.");
        return false;
    }

    return true;
}
</script>

</body>
</html>