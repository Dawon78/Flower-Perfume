<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./css/cart.css">
    <script src="./js/header.js" defer></script>
    <script src="./js/cart.js" defer></script>
    <link rel="stylesheet" href="./css/header_footer.css">
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

	<div id="content" class="content">

    <section class="mmain-content">
        <div class="list">
            <div class="item">
                <div class="question">
                    <div class="text">CART</div>
                    <div class="dropdown">></div>
                </div>
				 <div class="answer">
<%
 java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
    double totalPrice = 0;

    request.setCharacterEncoding("euc-kr");
    String id = (String) session.getAttribute("sid");
	



       if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }
        
		
  Connection con = null;
    PreparedStatement pstmt = null;
    PreparedStatement pstmt2 = null;
    ResultSet rs = null;
    ResultSet rs2 = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 일반 상품 조회
        String sql = "SELECT c.ctNo, c.prdNo, c.ctQty, c.prdImg, c.mapping_id, m.color, m.size, p.prdName, c.prdPrice " +
             "FROM cart c " +
             "JOIN mapping_id m ON c.mapping_id = m.mappingId " +
             "JOIN product p ON c.prdNo = p.prdNo " +
             "WHERE c.memId = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
%>
              <p style="margin-left: 20px;">장바구니에 담긴 상품이 없습니다.</p>
<%
        } else {
            do {
                String prdImg = rs.getString("prdImg");
				String prdNo = rs.getString("prdNo");
                String prdName = rs.getString("prdName");
                double prdPrice = rs.getDouble("prdPrice");
                int ctQty = rs.getInt("ctQty");
                String color = rs.getString("color");
                String size = rs.getString("size");
                int ctNo = rs.getInt("ctNo");

                double itemTotalPrice = prdPrice * ctQty;
                totalPrice += itemTotalPrice;
                String formattedTotalPrice = df.format(itemTotalPrice);
%>
	              
				   <div class="cart-item">
                         <div class="item-info">
            <a href="Product_detail.jsp?prdNo=<%= prdNo %>">
                <img src="<%= prdImg %>" alt="<%= prdName %>">
            </a>
                        <div class="item-details">

						      <form action="removeFromCart.jsp" method="post">
                                    <input type="hidden" name="ctNo" value="<%= ctNo %>">
                                    <button type="submit" class="remove-btn">&times;</button>
                                </form>
                       
                                          <a href="Product_detail.jsp?prdNo=<%= prdNo %>" style="text-decoration: none; color: inherit;">
                    <div class="item-name"><%= prdName %></div>
                </a>
                       
                          <div class="price">
                            <span class="item-price final-price"><%= formattedTotalPrice %>원</span> 
                     
     
                        </div>
                        
       <%
    String colorCode = "#ccc"; // 기본값

    if ("#f3f3f3".equals(color)) {
        colorCode = "#f3f3f3";
    } else if ("#91766E".equals(color)) {
        colorCode = "#91766E";
    } else if ("#F3ECE3".equals(color)) {
        colorCode = "#F3ECE3";
    } else if ("#F6F5EC".equals(color)) {
        colorCode = "#F6F5EC";
    } else if ("#C8A19C".equals(color)) {
        colorCode = "#C8A19C";
    }
%>


     <div class="SC">
    <div class="item-size">Size: <%= size %></div>
    <div class="item-color">
    Color:
    <span class="color-box" style="background-color: <%= colorCode %>;"></span>
	</div>
    <div class="item-exchange">[ 7일 이내 교환 가능 상품 ]</div>
	</div>
                </div>
            </div>
        </div>

<%
            } while (rs.next());
        }

        // 2. 커스텀 상품 조회
        String sql2 = "SELECT cc.ccNo, cc.cusNo, cc.cusQty, cu.cusimg, cu.cusName, cu.cusprice, cu.volume, cu.box_color " +
                      "FROM custom_cart cc " +
                      "JOIN custom cu ON cc.cusNo = cu.cusNo " +
                      "WHERE cc.memId = ?";
        pstmt2 = con.prepareStatement(sql2);
        pstmt2.setString(1, id);
        rs2 = pstmt2.executeQuery();

        while (rs2.next()) {
            String cusimg = rs2.getString("cusimg");
            String cusName = rs2.getString("cusName");
            double cusprice = rs2.getDouble("cusprice");
            int cusQty = rs2.getInt("cusQty");
            int ccNo = rs2.getInt("ccNo");
			String size = rs2.getString("volume"); 
            String color = rs2.getString("box_color");


            double itemTotalPrice = cusprice * cusQty;
            totalPrice += itemTotalPrice;
            String formattedCustomPrice = df.format(itemTotalPrice);
%>
        <div class="cart-item">
            <div class="item-info">
                <img src="<%= cusimg %>" alt="<%= cusName %>">
                <div class="item-details">

                    <form action="removeFromCart.jsp" method="post">
                        <input type="hidden" name="ccNo" value="<%= ccNo %>">
                        <button type="submit" class="remove-btn">&times;</button>
                    </form>

                    <div class="item-name"><%= cusName %></div>
                    <div class="price">
                        <span class="item-price final-price"><%= formattedCustomPrice %>원</span>
                    </div>

<%
    String colorCode = "#ccc"; // 기본값

    if ("WHITE".equals(color)) {
        colorCode = "#f3f3f3";
    } else if ("WHITE BEIGE".equals(color)) {
        colorCode = "#f6f5ec";
    } else if ("BEIGE".equals(color)) {
        colorCode = "#f3ece3";
    } else if ("ROSY".equals(color)) {
        colorCode = "#c8a19c";
    } else if ("BROWN".equals(color)) {
        colorCode = "#91766e";
    }
%>


     <div class="SC">
    <div class="item-size">Size: <%= size %></div>
    <div class="item-color">
    Color:
    <span class="color-box" style="background-color: <%= colorCode %>;"></span>
	</div>
    <div class="item-exchange">[ 7일 이내 교환 가능 상품 ]</div>
	</div>
                </div>
            </div>
        </div>
<%
        }
    } catch (Exception e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
    } finally {
        if (rs2 != null) try { rs2.close(); } catch (Exception e) {}
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt2 != null) try { pstmt2.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>

						 <a href="Spring_Product.jsp"><button class="checkout-btn" style="margin-left: 20px;">더 담으러가기</button></a>
				    </div>
                            </div>


  
		</div>
  
<div class="container2">
        <div class="order-summary">
          <h2>내 주문서</h2>
          <hr class="order-hr">
          <div class="total-price">
            <span>총 가격</span>
         <span><%= df.format(totalPrice) %>원</span>
          </div>
         <button class="order-btn" onclick="window.location.href='./payment.jsp'">주문하기</button>

        </div>
      </div>
    </section>


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
