<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.URLDecoder" %>
<%
    // 요청 파라미터의 인코딩을 UTF-8로 설정
    request.setCharacterEncoding("UTF-8");

    // URLDecoder를 사용하여 URL 인코딩된 값을 디코딩하고, "%20"을 제거
    String topNote = request.getParameter("top") != null ? 
        URLDecoder.decode(request.getParameter("top"), "UTF-8").replace("%20", " ") : "";
    String middleNote = request.getParameter("middle") != null ? 
        URLDecoder.decode(request.getParameter("middle"), "UTF-8").replace("%20", " ") : "";
    String baseNote = request.getParameter("base") != null ? 
        URLDecoder.decode(request.getParameter("base"), "UTF-8").replace("%20", " ") : "";
    String volume = request.getParameter("volume");
    String box = request.getParameter("box") != null ? 
        URLDecoder.decode(request.getParameter("box"), "UTF-8").replace("%20", " ") : "";
    String cusName = request.getParameter("cusName") != null ? 
        URLDecoder.decode(request.getParameter("cusName"), "UTF-8").replace("%20", " ") : "";
    
    // 세션에서 사용자 아이디 가져오기
    String sid = (String) session.getAttribute("sid");
    if (sid == null) {
        sid = "알 수 없음"; // 세션에 sid 값이 없을 경우 기본값을 설정
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/header_footer.css">
  <script src="./js/header.js" defer></script>
  <link rel="stylesheet" href="./css/fade-in.css">
  <link rel="stylesheet" href="./css/cus_result.css">
  <script src="./js/fade-in.js"></script>


</head>
<body>
  <%
  String image = request.getParameter("image") != null ? 
      URLDecoder.decode(request.getParameter("image"), "UTF-8") : "./image/main_p22.png"; // 기본 이미지

  String priceParam = request.getParameter("price");
  int cusprice = 89000; // 기본값
  if (priceParam != null && !priceParam.equals("")) {
      cusprice = Integer.parseInt(priceParam);
  }
%>
  <div class="wrap">
    <div class="circle"></div>
    <div class="loading-text">향수 제조 중...</div>
  </div>

  <div class="content fade-in">
    <header class="header">
      <div class="icon-bar">
          <div class="icon-container">
            <div class="logo"><a href="./index.jsp"><img src="./logo/logo.png" alt="Logo"></a></div>
            <form action="search.jsp" method="get" accept-charset="EUC-KR">
              <img class="header-icon" src="icon/search.png" id="search">
              <input type="text" name="query" placeholder="search" class="input-search search-button">
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
    <h1>나만의 향수가 완성되었습니다!</h1>
    <div class="container">
      <div class="image-box"><img src="./image/main_p22.png" alt=""></div>

      <div class="info-box">
        <p><strong>이름:</strong>&nbsp;&nbsp;&nbsp; <%= cusName %></p>
		
		
<%
String topNoteImg = "";
if ("벚꽃".equals(topNote)) {
    topNoteImg = "./image/custom/t_f9.png";
} else if ("프리지아".equals(topNote)) {
    topNoteImg = "./image/custom/t_f10.png";
} else if ("코스모스".equals(topNote)) {
    topNoteImg = "./image/custom/t_f11.png";
} else if ("포인세티아".equals(topNote)) {
    topNoteImg = "./image/custom/t_f12.png";
} else if ("수선화".equals(topNote)) {
    topNoteImg = "./image/custom/t_f21.png";
} else if ("백합".equals(topNote)) {
    topNoteImg = "./image/custom/t_f22.png";
} else if ("네롤리".equals(topNote)) {
    topNoteImg = "./image/custom/t_f23.png";
} else if ("시클라멘".equals(topNote)) {
    topNoteImg = "./image/custom/t_f24.png";
} else {
    topNoteImg = "./image/default.png";
}

String middleNoteImg = "";
if ("장미".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f5.png";
} else if ("튤립".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f6.png";
} else if ("국화".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f7.png";
} else if ("겨울 자스민".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f8.png";
} else if ("은방울꽃".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f17.png";
} else if ("해바라기".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f18.png";
} else if ("핑크뮬리".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f19.png";
} else if ("겨울매화".equals(middleNote)) {
    middleNoteImg = "./image/custom/m_f20.png";
} else {
    middleNoteImg = "./image/default.png";
}

String baseNoteImg = "";
if ("데이지".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f1.png";
} else if ("라벤더".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f2.png";
} else if ("다알리아".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f3.png";
} else if ("흰 동백꽃".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f4.png";
} else if ("카네이션".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f13.png";
} else if ("수국".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f14.png";
} else if ("메리골드".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f15.png";
} else if ("아이리스".equals(baseNote)) {
    baseNoteImg = "./image/custom/b_f16.png";
} else {
    baseNoteImg = "./image/default.png";
}

 String colorCode = "#ccc"; // 기본값

    if ("WHITE".equals(box)) {
    colorCode = "#f3f3f3";
} else if ("WHITE BEIGE".equals(box)) {
    colorCode = "#f6f5ec";
} else if ("BEIGE".equals(box)) {
    colorCode = "#f3ece3";
} else if ("ROSY".equals(box)) {
    colorCode = "#c8a19c";
} else if ("BROWN".equals(box)) {
    colorCode = "#91766e";
}
%>


		<p class="note-line">
  <span class="note-text"><strong style="color: #E63946;">TOP NOTE:</strong>&nbsp;&nbsp;&nbsp; <%= topNote %></span>

  <img src="<%= topNoteImg %>" alt="<%= topNote %>">
</p>

<p class="note-line">
  <span class="note-text"><strong style="color: #6A0572;">MIDDLE NOTE:</strong>&nbsp;&nbsp;&nbsp; <%= middleNote %></span>

  <img src="<%= middleNoteImg %>" alt="<%= middleNote %>">
</p>

<p class="note-line">
  <span class="note-text"><strong style="color: #355C7D;">BASE NOTE:</strong>&nbsp;&nbsp;&nbsp; <%= baseNote %></span>

  <img src="<%= baseNoteImg %>" alt="<%= baseNote %>">
</p>

<p class="note-line">
  <span class="note-text"><strong>용량:</strong>&nbsp;&nbsp;&nbsp; <%= volume %> &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; <strong>박스:</strong>&nbsp;&nbsp;&nbsp; <%= box %></span>
  <span class="color-box" style="background-color: <%= colorCode %>;"></span>
</p>


       
        <div class="price">가격: &nbsp;&nbsp;  89,000원</div>
        <%@ page import="java.sql.*" %>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet generatedKeys = null;
            int lastCusNo = 0; // 🟡 여기 추가
            String url = "jdbc:mysql://localhost:3306/flower";
            String user = "multi";
            String password = "abcd";
        
            try {
                Class.forName("org.gjt.mm.mysql.Driver");
                conn = DriverManager.getConnection(url, user, password);
        
                String sql = "INSERT INTO custom (cusName, top_note, middle_note, base_note, volume, box_color, cusimg, cusprice) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
                // 🟡 auto_increment된 primary key를 가져오기 위해 옵션 추가
                pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setString(1, cusName);
                pstmt.setString(2, topNote);
                pstmt.setString(3, middleNote);
                pstmt.setString(4, baseNote);
                pstmt.setString(5, volume);
                pstmt.setString(6, box);
                pstmt.setString(7, image);
                pstmt.setInt(8, cusprice);
        
                int result = pstmt.executeUpdate();
        
                if (result > 0) {
                    // 🟡 방금 INSERT된 레코드의 PK 값(cusNo) 가져오기
                    generatedKeys = pstmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        lastCusNo = generatedKeys.getInt(1);
                    }
                   
                } else {
                    out.println("<p>저장 실패</p>");
                }
        
            } catch (Exception e) {
                out.println("<p>오류 발생: " + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                try {
                    if (generatedKeys != null) generatedKeys.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>
        <div class="ok">
          <input type="radio" id="confirm" name="confirm">
          <label for="confirm">측정된 가격과 선택한 재료를 확인하셨나요?</label>
        </div>

        

        <div class="bottom-group">
          <button onclick="window.location.href='custom2.html'" class="reset-btn">다시하기</button>
          <form action="incustomcart.jsp" method="post">
            <input type="hidden" name="cusNo" value="<%= lastCusNo %>">
            <input type="hidden" name="memId" value="<%= sid %>">
            <button type="submit" class="cart-btn">장바구니</button>
          </form>
        </div>
      </div>
    </div>
    <footer class="footer">
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
  </div>

  <script>
    // 로딩 화면 3초 후 숨기고 실제 내용 표시
    setTimeout(function () {
      document.querySelector('.wrap').style.display = 'none';
      document.querySelector('.loading-text').style.display = 'none';
      document.querySelector('.content').style.display = 'block';
    }, 3000);

    // 확인 체크 안 했을 때 장바구니 제출 방지
    document.addEventListener("DOMContentLoaded", function () {
      const cartForm = document.querySelector("form[action='incustomcart.jsp']");
      const confirmCheck = document.getElementById("confirm");

      cartForm.addEventListener("submit", function (e) {
        if (!confirmCheck.checked) {
          e.preventDefault();
          alert("측정된 가격과 선택한 재료를 확인 후 체크해주세요");
        }
      });
    });
  </script>
</body>
</html>
