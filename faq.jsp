<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.util.*, java.net.URLEncoder, java.net.URLDecoder" %>
<%
    request.setCharacterEncoding("euc-kr");

    Map<String, String> faqMap = new LinkedHashMap<>();
    faqMap.put("최소/환불이 가능한가요?", "미개봉 제품: 대부분의 온라인 쇼핑몰에서는 미개봉 상태의 향수나 디퓨저에 대해 최소 및 환불을 허용합니다. 제품이 개봉되었거나 사용된 경우, 위생적인 이유로 최소/환불이 불가능한 경우가 많습니다.<br><br>디퓨저: 디퓨저는 대부분 미개봉 상태에서만 최소/환불이 가능하지만, 향이 강하게 나거나 불쾌한 향을 느꼈을 때의 환불 정책은 사이트마다 차이가 있을 수 있습니다.<br><br>배송 중 손상: 배송 중에 제품이 파손되었거나 손상된 경우, 최소이나 환불이 가능할 수 있습니다. 이 경우에는 배송 후 일정 기간 내에 고객센터에 연락을 통해 문제를 해결할 수 있습니다. 배송상 문제로 인해 최소/환불을 요청할 때는 배송 영수증이나 사진 증거를 요구할 수 있습니다.<br><br>환불 처리: 환불이 승인되면, 일반적으로 결제 수단으로 환불이 이루어집니다. 카드 결제 시에는 환불 처리가 몇 일 정도 소요될 수 있습니다. 일부 사이트에서는 포인트 환불이나 스토어 크레딧 형태로 환불이 이루어지기도 합니다.<br><br>조건에 따른 제한: 최소/환불 정책은 구매한 제품의 종류, 고객의 구매 이력, 쇼핑몰의 정책에 따라 달라질 수 있습니다. 특히, 세일 상품이나 할인 품목은 환불이 불가능한 경우가 많고, 이와 관련된 별도의 안내가 제공됩니다.");
    faqMap.put("배송은 얼마나 걸리나요?", "배송은 일반적으로 결제 완료 후 2~5일 이내에 이루어집니다. 지역이나 배송업체 사정에 따라 차이가 있을 수 있으며, 연휴 및 공휴일에는 지연될 수 있습니다.");
    faqMap.put("향수나 디퓨저는 어떻게 보관해야 하나요?", "향수와 디퓨저는 직사광선을 피해 서늘하고 건조한 곳에 보관하는 것이 좋습니다. 온도 변화가 심한 곳이나 욕실과 같은 습한 환경은 피해주세요. 또한, 뚜껑을 꼭 닫아 보관하면 향이 오래 유지됩니다.");
    faqMap.put("상품 품절 시 재입고는 언제되나요?", "품절된 상품의 재입고 일정은 제품별로 다를 수 있습니다. 일반적으로 인기 상품은 1~2주 이내에 재입고되며, 상세한 일정은 고객센터나 상품 상세 페이지에서 확인 가능합니다.");
    faqMap.put("향수 성분이 어떻게 되나요?", "향수는 주로 천연 꽃 추출물과 에센셜 오일을 사용하여 제작됩니다. 대표적인 성분으로는 장미, 재스민, 라벤더, 일랑일랑 등이 포함될 수 있으며, 알코올과 정제수가 함유되어 지속력과 확산력을 높여줍니다.");

    String encodedQuestion = request.getParameter("question");
    String decodedQuestion = encodedQuestion != null ? URLDecoder.decode(encodedQuestion, "euc-kr") : null;
    String answer = decodedQuestion != null ? faqMap.get(decodedQuestion) : null;
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="euc-kr">
 
 <link rel="stylesheet" href="./css/header_footer.css">
<script src="./js/header.js" defer></script>
  <style>

body{
 -ms-overflow-style: none;
   background-image: url('./image/allback.png');
		background-size: cover;      
	  background-repeat: no-repeat;
 }
 
::-webkit-scrollbar {
  display: none;
}

/*특정 부분 스크롤바 없애기*/

.box{
   -ms-overflow-style: none;
          
}
.box::-webkit-scrollbar{
  display:none;
}

    .faq-container {
      width: 1280px;
      background: #F1F1F1;
      padding: 80px;
      border-radius: 20px;
      margin: 140px auto 174px auto;
    }
    .faq-title {
      font-size: 50px;
      color: #121212;
      margin-bottom: 100px;
      text-align: center;
    }
    .faq-item {
      padding: 0px 20px 0px 80px;
      background-color: #ffffff;
      border-radius: 0px 30px 30px 30px;
      margin-bottom: 45px;
    }
    .faq-item a {
      display: flex;
      justify-content: space-between;
      align-items: center;
      font-size: 28px;
      text-decoration: none;
      color: #000;
    }
    .faq-item:hover {
      box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.2);
      transition: box-shadow 0.3s ease-in-out;
    }
    .faq-item img {
      width: 40px;
      height: 40px;
    }
    .popup {
      display: block;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 90%;
      max-width: 1529px;
      max-height: 80vh;
      background: #F6F6F6;
      padding: 30px 0 48px 0;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      z-index: 1000;
      overflow-y: auto;
    }
    .popup-overlay {
      display: block;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.5);
      z-index: 999;
    }
    .popup img {
      margin-top: 20px;
      margin-left: 76px;
    }
    .close-btn {
      float: right;
      cursor: pointer;
      font-size: 38px;
      font-weight: bold;
      margin-right: 30px;
    }
    .p {
      width: 1089px;
      background-color: #ffffff;
      margin: 0 auto;
      padding-top: 88px;
      padding-bottom: 88px;
      border-radius: 0px 30px 30px 30px;
    }
    .p p {
      width: 773px;
      font-size: 20px;
      margin: 0 auto;
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
 <div class="box">
  <div class="faq-container">
    <div class="faq-title">자주하는 질문</div>
    <%
      for (Map.Entry<String, String> entry : faqMap.entrySet()) {
        String encoded = URLEncoder.encode(entry.getKey(), "euc-kr");
    %>
      <div class="faq-item">
        <a href="faq.jsp?question=<%= encoded %>">
          <p><%= entry.getKey() %></p>
          <img src="./icon/QA.png" alt="">
        </a>
      </div>
    <% } %>
  </div>

  <% if (answer != null) { %>
    <div class="popup-overlay" onclick="location.href='faq.jsp'"></div>
    <div class="popup">
      <span class="close-btn" onclick="location.href='faq.jsp'">&times;</span>
      <img src="./image/QA_popup.png" alt="">
      <div class="p">
        <p><%= answer %></p>
      </div>
    </div>
	   </div>
  <% } %>
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
</body>
</html>
