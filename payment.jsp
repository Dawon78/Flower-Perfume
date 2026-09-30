<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./css/address.css">
    <link rel="stylesheet" href="./css/paymemt.css">
    <link rel="stylesheet" href="./css/header_footer.css">
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="./js/cart.js" defer></script>
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
<style>
.submit-btn{
margin-left:209px;
}
.total-price{
margin-top:8px;
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


    <form action="process_order.jsp" method="post" accept-charset="euc-kr">
        <section class="mmain-content">
            <div class="list">
                <div class="item">
                <div class="question">
                  <div class="text">Address</div>
                  <div class="dropdown">></div>
                </div>
                <div class="answer">
                
                  <div class="form-container">
                    
          <div class="form-row">
              <input type="text" name="ordSender" placeholder="주문자 성함*" required>
          </div>
          <div class="form-row">
              <input type="text" name="orderReceiver" placeholder="수신자 성함*" required>
          </div>
          <div class="form-row">
              <input type="text"  id="address" name="ordRcvAddress1" placeholder="도로명 주소*" required readonly>
              <input type="text" id="address2" name="ordRcvAddress2" placeholder="상세 주소*" required>
              <input type="button" value="우편번호검색"  onclick="searchPostcode()" style="background-color: white; border: 1px solid #000;">

          </div>
          <div class="form-row">
              <input type="tel" name="orderTel" placeholder="전화번호*" required>
              <input type="email" name="orderEmail" placeholder="이메일*" required>
          </div>
          <div class="form-row">
             <select name="orderSendask">
          <option value="없음">배송시 요청사항</option>
          <option value="문 앞에 두고 가주세요">문 앞에 두고 가주세요</option>
          <option value="배송 전 연락 주세요">배송 전 연락 주세요</option>
      </select>
              <input type="text" name="orderCompanyask" placeholder="업체 요청사항">
          </div>
          <textarea name="orderAsk" placeholder="문의 내용이 있을 시 작성해주세요."></textarea>
    
                </div>
                </div>
              </div>

              <div class="item">
                <div class="question">
                  <div class="text">Payment</div>
                  <div class="dropdown">></div>
                </div>
                <div class="answer">
                  <div class="payment-container">
                    <div class="payment-options">
                        <div class="payment-option">
                            <input type="radio" id="card" name="ordPay" onclick="togglePaymentForm()" value="card" checked>
                            <label for="card">Master Card</label>
                        </div>
                        <div class="payment-option">
                            <input type="radio" id="bank" name="ordPay" onclick="togglePaymentForm()"  value="bank">
                            <label for="bank">무통장 입금</label>
                        </div>
      
                         <button class="kakaopay-button" type="submit" formaction="kakao_pay.jsp"  name="ordpay" value="kakao">
                          <img src="./icon/payment_icon_yellow_large.png" alt="카카오페이 로고">
                        </button>
                    </div>
                    
                    <div id="card-form" class="payment-form">
                        <div class="row">
                            <input type="text" name="ordcardName" placeholder="성이름*">
                           
                        </div>
                        <input type="text" name="ordCardNo" class="cardNumber" placeholder="카드 번호*">
                        <div class="row">
                            <input type="text" name="ordCardExpiry" placeholder="유효 기간*">
                            <input type="text" name="ordCardPass" placeholder="CVC*">
                        </div>
                     
                    </div>
                    
                    <div id="bank-form" class="payment-form">
				
                      <input type="text" name="ordBank" class="cardNumber" placeholder="입금은행 : 신한은행">
                      <input type="text" name="ordBankNo"class="cardNumber" placeholder="계좌번호 (-없이) 1234567801011">
                      <input type="text" name="ordBankName" class="cardNumber"  placeholder="입금자 성함">
                      
         
                  </div>
                </div>              
                </div>            
              </div>    
            </div>
          
            <div class="container2">
              <div class="order-summary">
                <h2>내 장바구니 상품</h2>
                <hr class="order-hr">
                <div class="price-details">
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
                      <p>장바구니에 담긴 상품이 없습니다.</p>
<%
        } else {
            do {
                String prdImg = rs.getString("prdImg");
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
                    <img src="<%= prdImg %>" alt="<%= prdImg %>" class="product-image">
                    <div class="product-details">
                        <div class="top-row">
                            <span class="product-name"><%= prdName %></span>
                           <button onclick="removeItem(<%= ctNo %>)" class="remove-btn">&times;</button>

					<script>
					function removeItem(ctNo) {
					  if (!confirm("정말 삭제하시겠습니까?")) return;

					  fetch('removeFromCart.jsp', {
						method: 'POST',
						headers: {'Content-Type': 'application/x-www-form-urlencoded'},
						body: 'ctNo=' + ctNo
					  }).then(() => location.reload());
					}
					</script>

                        </div>
                         <div class="bottom-row">
            <span class="product-price" data-unit-price="<%= prdPrice %>"><%= df.format(prdPrice * ctQty) %>원</span>
            <input type="number" class="quantity-select" min="1" max="100" name="ctQty_<%= ctNo %>" value="<%= ctQty %>">

        </div>
                    </div>
                </div>
               <%
            } while (rs.next());
        }

        // 2. 커스텀 상품 조회
        String sql2 = "SELECT cc.ccNo, cc.cusNo, cc.cusQty, cu.cusimg, cu.cusName, cu.cusprice " +
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

            double itemTotalPrice = cusprice * cusQty;
            totalPrice += itemTotalPrice;
            String formattedCustomPrice = df.format(itemTotalPrice);
			
			
%>
	  <div class="cart-item">
                    <img src="<%= cusimg %>" alt="<%= cusimg %>" class="product-image">
                    <div class="product-details">
                        <div class="top-row">
                            <span class="product-name"><%= cusName %></span>
                           <form action="removeFromCart.jsp" method="post">
                                          <input type="hidden" name="ctNo" value="<%= ccNo %>">
                                          <button type="submit" class="remove-btn">&times;</button>
                                      </form>
                        </div>
                         <div class="bottom-row">
            <span class="product-price" data-unit-price="<%= cusprice %>"><%= df.format(cusprice * cusQty) %>원</span>
            <input type="number" class="quantity-select" min="1" max="100" name="cusQty_<%= ccNo %>" value="<%= cusQty %>">

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
   int deliveryFee = 3000;
    double finalPrice = totalPrice + deliveryFee;
%>
	
                </div> 
                <hr class="order-hr">
<div class="total-price">
  <span>배송비</span>
    <span>+<%= df.format(deliveryFee) %>원</span>
</div>
<div class="total-price">
<span>총 결제 금액</span>
    <span id="total-price"><%= df.format(finalPrice) %>원</span>
	<input type="hidden" name="total" id="total-input" value="<%= finalPrice %>">
  
</div>

  <button type="submit" class="submit-btn" onclick="updateOrderInfo()">결제하기</button>
          </section>        
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
</div>
<script>
document.addEventListener("DOMContentLoaded", function () {
    // 모든 수량 입력 필드 가져오기
    const quantityInputs = document.querySelectorAll(".quantity-select");

    quantityInputs.forEach(input => {
        input.addEventListener("change", function () {
            let quantity = parseInt(this.value);
            if (isNaN(quantity) || quantity < 1) {
                this.value = 1;
                quantity = 1;
            }

            // 부모 요소에서 가격 요소 찾기
            const cartItem = this.closest(".cart-item");
            const priceElement = cartItem.querySelector(".product-price");
            const unitPrice = parseInt(priceElement.getAttribute("data-unit-price")); // 원래 가격 저장

            // 새 가격 계산
            const newTotalPrice = unitPrice * quantity;
            priceElement.textContent = newTotalPrice.toLocaleString() + "원"; // 가격 업데이트

            // 총 가격 업데이트
            updateTotalPrice(); // 총 가격 업데이트 함수 호출
        });
    });

    function updateTotalPrice() {
        let total = 0;
        // 모든 .product-price 요소에서 총합을 계산
        document.querySelectorAll(".product-price").forEach(priceElement => {
            // "원"과 쉼표 제거 후 숫자로 변환
            total += parseInt(priceElement.textContent.replace(/,/g, "").replace("원", ""));
        });

        // 총 가격 업데이트
        const totalPriceElement = document.getElementById("total-price");
        const totalInputElement = document.getElementById("total-input");

        // 총 가격을 화면에 업데이트
        totalPriceElement.textContent = total.toLocaleString() + "원";
        
        // hidden input에도 총 가격을 업데이트
        totalInputElement.value = total;
    }
});

  function togglePaymentForm() {
    const selectedPayment = document.querySelector('input[name="ordPay"]:checked').value;
    
    const cardForm = document.getElementById("card-form");
    const bankForm = document.getElementById("bank-form");

    if (selectedPayment === "card") {
      cardForm.style.display = "block";
      bankForm.style.display = "none";
    } else if (selectedPayment === "bank") {
      cardForm.style.display = "none";
      bankForm.style.display = "block";
    }
  }

  function payWithKakao() {
    alert("카카오페이 결제 진행");
    // 실제 카카오페이 API 연동 필요
  }

  // 라디오 버튼 변경 시 실행
  document.querySelectorAll('input[name="ordPay"]').forEach((radio) => {
    radio.addEventListener("change", togglePaymentForm);
  });

  // 페이지 로드 시 초기 설정
  document.addEventListener("DOMContentLoaded", togglePaymentForm);

function togglePaymentForm() {
    const cardRadio = document.getElementById('card');
    const bankRadio = document.getElementById('bank');
    const cardForm = document.getElementById('card-form');
    const bankForm = document.getElementById('bank-form');

    // 표시/숨김 처리
    cardForm.style.display = cardRadio.checked ? 'block' : 'none';
    bankForm.style.display = bankRadio.checked ? 'block' : 'none';

    // 입력 값 초기화
    if (!bankRadio.checked) {
        const bankInputs = bankForm.querySelectorAll('input');
        bankInputs.forEach(input => input.value = '');
    }
    if (!cardRadio.checked) {
        const cardInputs = cardForm.querySelectorAll('input');
        cardInputs.forEach(input => input.value = '');
    }
}

</script>
</body>
</html>