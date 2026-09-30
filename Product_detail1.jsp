<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <link rel="stylesheet" href="css/Product_detail.css">
    <link rel="stylesheet" href="css/header_footer.css">
<script src="./js_package.js" defer></script>
<script src="./js/header.js" defer></script>
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

<%
    String url = "jdbc:mysql://localhost:3306/flower";
    String user = "multi";
    String password = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String prdNo = request.getParameter("prdNo");
    int prdNoInt = Integer.parseInt(prdNo); 

    String prdName = "";
    String prdCategory = "";
    String prdDesc = "";
    String prdImg = "";
    int prdPrice = 0;
    String prdColor1 = "";
    String prdColor2 = "";
    String prdColor3 = "";
	String prdType = "";

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String sql = "SELECT prdName, prdType, prdCategory, prdDescription, prdImg, prdPrice, prdColor1, prdColor2, prdColor3 " +
                     "FROM product WHERE prdNo = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, prdNoInt); 
        rs = pstmt.executeQuery();

        if (rs.next()) {
            prdName = rs.getString("prdName");
            prdCategory = rs.getString("prdCategory");
            prdDesc = rs.getString("prdDescription");
            prdImg = rs.getString("prdImg");
            prdPrice = rs.getInt("prdPrice");
            prdColor1 = rs.getString("prdColor1");
            prdColor2 = rs.getString("prdColor2");
            prdColor3 = rs.getString("prdColor3");
			prdType = rs.getString("prdType");
        }

		String prdCategoryKor = "";

if ("Perfume".equals(prdCategory)) {
    prdCategoryKor = "향수";
} else if ("Diffuser".equals(prdCategory)) {
    prdCategoryKor = "디퓨저";
} else {
    prdCategoryKor = prdCategory; // 기본값 (변환 없음)
}

        rs.close();
        pstmt.close();

        double avgStar = 0.0;
        int reviewCount = 0;

        String reviewSql = "SELECT AVG(star) AS avgStar, COUNT(*) AS reviewCount " +
                           "FROM review WHERE prdNo = ?";
        pstmt = conn.prepareStatement(reviewSql);
        pstmt.setInt(1, prdNoInt);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            avgStar = rs.getDouble("avgStar");
            reviewCount = rs.getInt("reviewCount");
        }

        rs.close();
        pstmt.close();

        String individualReviewSql = "SELECT memId, reviewDate, longevity, content, scent " +
                                     "FROM review WHERE prdNo = ?";
        pstmt = conn.prepareStatement(individualReviewSql);
        pstmt.setInt(1, prdNoInt);
        rs = pstmt.executeQuery();


        rs.close();
        pstmt.close();

        String memID = (String) session.getAttribute("sid");

        if (memID != null) {
            String updateSql = "UPDATE recentlyviewed SET viewedAt = CURRENT_TIMESTAMP WHERE memID = ? AND prdNo = ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, memID);
            pstmt.setInt(2, prdNoInt);
            int updatedRows = pstmt.executeUpdate();

            if (updatedRows == 0) {
                String insertSql = "INSERT INTO recentlyviewed (memID, prdNo) VALUES (?, ?)";
                pstmt = conn.prepareStatement(insertSql);
                pstmt.setString(1, memID);
                pstmt.setInt(2, prdNoInt); 
                pstmt.executeUpdate();
            }

            String deleteSql = "DELETE FROM recentlyviewed WHERE memID = ? AND id NOT IN " +
                               "(SELECT id FROM (SELECT id FROM recentlyviewed WHERE memID = ? ORDER BY viewedAt DESC LIMIT 10) AS temp)";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setString(1, memID);
            pstmt.setString(2, memID);
            pstmt.executeUpdate();
        }

%>




    <div class="Product_info">
    <div class="container1">
    <p class="breadcrumb">Home > <%= prdType %> > <%= prdCategoryKor %> ><strong> <%= prdName %></strong></p>
        <div class="Product_Review">
        <div class="star-rating">
                <%
    int roundedStar = (int)Math.floor(avgStar);
    for (int i = 1; i <= 5; i++) {
        if (i <= roundedStar) {
        %>
            <span class="star filled">★</span>
         <%
        } else {
        %>
            <span class="star">☆</span>
        <%
          }
      }
        %>
            </div>
        <p class="Review"><%= reviewCount %> Reviews</p>
		<a href="./myReview.jsp">Write a Review</a>
    </div>


<form name="product" method="post">
<div class="Product_detail">
    <h1><%= prdName %></h1>
    <p><%= prdCategory %></p>
    <hr class="Product_detail_hr">
    
    <h2><%= String.format("%,d원", prdPrice) %></h2>
    
    <p><%= prdDesc %></p>
    <hr class="Product_detail_hr">

<h3>Box Color</h3>
<div class="color-options">
    <% if (prdColor1 != null && !prdColor1.isEmpty()) { %>
        <div class="color-box" data-color="<%= prdColor1 %>" style="background-color: <%= prdColor1 %>; "></div>
    <% } %>
    <% if (prdColor2 != null && !prdColor2.isEmpty()) { %>
        <div class="color-box" data-color="<%= prdColor2 %>" style="background-color: <%= prdColor2 %>; "></div>
    <% } %>
    <% if (prdColor3 != null && !prdColor3.isEmpty()) { %>
        <div class="color-box" data-color="<%= prdColor3 %>" style="background-color: <%= prdColor3 %>; "></div>
    <% } %>
</div>

<h3>Select Size</h3>
<div class="volume-options">
    <div class="volume-box selected" data-volume="100ML" data-addprice="0">100ML</div>
    <div class="volume-box" data-volume="125ML" data-addprice="10000">125ML</div>
    <div class="volume-box" data-volume="150ML" data-addprice="20000">150ML</div>
    <div class="volume-box" data-volume="175ML" data-addprice="30000">175ML</div>
    <div class="volume-box" data-volume="200ML" data-addprice="40000">200ML</div>
</div>

 <input type="hidden" name="prdNo" value="<%= prdNo %>"> 
    <input type="hidden" name="prdQty" value="1"> 
    <input type="hidden" name="prdColor" id="prdColor" value="">
	<input type="hidden" name="prdSize" id="prdSize" value="100ML">
    <input type="hidden" name="prdPrice" id="prdPrice" value="<%= prdPrice %>">
</form>

    <hr class="Product_detail_hr">
    <div class="cart_wish">

<button type="button" class="add-to-cart-btn" onclick="inCart()">
    <img src="icon/shopping-cart.png" alt="장바구니 아이콘" class="cart-icon">
    <span>장바구니 담기</span>
</button>

<section class="Wish-list">
    <button class="wishlist-btn" id="wishlist-btn" data-prdno="<%= prdNo %>">♡</button>
</section>
    </div>

    <hr class="Product_detail_hr">
</div>
</div>
<script>
   document.querySelectorAll('.color-box').forEach(box => {
    box.addEventListener('click', () => {
        document.querySelectorAll('.color-box').forEach(b => b.classList.remove('selected'));
        box.classList.add('selected');
        document.getElementById('prdColor').value = box.getAttribute('data-color');
    });
});

document.querySelectorAll('.volume-box').forEach(box => {
    box.addEventListener('click', () => {
        document.querySelectorAll('.volume-box').forEach(b => b.classList.remove('selected'));
        box.classList.add('selected');
        document.getElementById('prdSize').value = box.getAttribute('data-volume');
    });
});


   function inCart() {
        var frm = document.product;

        if (frm.prdColor.value === "" || frm.prdSize.value === "") {
            alert("색상과 사이즈를 선택해주세요.");
            return;
        }

        frm.action = "inCart.jsp";  
        frm.submit();
    }
</script>

<div class="container2">
    <div class="product-image">
        <img src="<%= prdImg %>" alt="<%= prdName %>" class="product-main-image">
    </div>
</div>
    </div>
    </div>
    <div class="container">
    <div class="review">
      <h1>별점 &nbsp;
	      <%
        
        out.print(String.format("%.1f", avgStar));
    %>
  / 5.0</h1>
      <h3>Reviews
</h3>
    </div>
<div class="container">
    <div class="review-section">

        <div class="review-list1" id="reviewList">
<%
int visibleReviewCount = 0; 

pstmt = conn.prepareStatement(
    "SELECT r.memId, r.reviewDate, r.scent, r.longevity, r.content " +
    "FROM review r " +
    "WHERE r.prdNo = ? " +
    "ORDER BY r.reviewDate DESC"
);
pstmt.setInt(1, prdNoInt);
rs = pstmt.executeQuery();

while (rs.next()) {
    String memId = rs.getString("memId");
    String reviewDate = rs.getString("reviewDate");
    String scent = rs.getString("scent");
    String longevity = rs.getString("longevity");
    String content = rs.getString("content");

    String[] dateParts = reviewDate.split(" ")[0].split("-");
    String formattedDate = dateParts[0] + "-" + dateParts[1] + "-" + dateParts[2];

    boolean hidden = visibleReviewCount >= 4;
%>
    <div class="review-item <%= hidden ? "hidden-review" : "" %>">
        <div class="profile-img"></div>
        <div class="review-content">
            <p class="review-name"><%= memId %></p>
            <p class="review-date"><%= formattedDate %></p>
            <p class="review-text"><strong>향기:</strong> <%= scent != null ? scent : "Not provided" %></p>
            <p class="review-text"><strong>지속력:</strong> <%= longevity != null ? longevity : "Not provided" %></p>
            <p class="review-text">"<%= content %>"</p>
        </div>
    </div>
<%
    visibleReviewCount++; 
}
rs.close();
pstmt.close();
%>
        </div>

        <% if (visibleReviewCount > 4) { %>
        <button class="show-more" id="showMoreBtn" onclick="showAllReviews()">Show All Reviews</button>
        <% } %>
    </div>
</div>




<div class="Similar_Products" style="margin-bottom: 100px;">
    <h1>Season Products</h1>
    <section class="product-grid">
        <%
            int rangeStart = ((prdNoInt - 1) / 10) * 10 + 1;
            int rangeEnd = rangeStart + 9;

            String ssql = "SELECT prdNo, prdName, prdImg, prdPrice FROM product " +
                         "WHERE prdNo BETWEEN ? AND ? AND prdNo <> ? " + 
                         "ORDER BY RAND() LIMIT 5";
            pstmt = conn.prepareStatement(ssql);
            pstmt.setInt(1, rangeStart);
            pstmt.setInt(2, rangeEnd);    
            pstmt.setInt(3, prdNoInt); 
            rs = pstmt.executeQuery();

            if (!rs.next()) {
                out.println("추천 상품이 없습니다.");
            } else {
                do {
        %>
                    <a href="Product_detail1.jsp?prdNo=<%= rs.getInt("prdNo") %>">
                        <div class="product-card">
                            <div class="product-image-wrapper"> 
                                <img src="<%= rs.getString("prdImg") %>" alt="<%= rs.getString("prdName") %>" class="product-image">
                            </div>
                            <h3 class="product-title"><%= rs.getString("prdName") %></h3>
                            <p class="product-price"><%= String.format("%,d원", rs.getInt("prdPrice")) %></p>
                        </div>
                    </a>
        <%
                } while (rs.next());
            }
            rs.close();
            pstmt.close();
        %>
    </section>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>


</div>

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
    document.querySelectorAll('.wishlist-btn').forEach(button => {
        button.addEventListener('click', function() {
            this.classList.toggle('active'); 
        });
    });

    function scrollReviews(direction) {
        const reviewList = document.getElementById('reviewList');
        const scrollAmount = 200;
        reviewList.scrollBy({ left: direction * scrollAmount, behavior: 'smooth' });
    }
</script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const wishlistButtons = document.querySelectorAll(".wishlist-btn");

    wishlistButtons.forEach(button => {
        const prdNo = button.getAttribute("data-prdno");

        if (button.classList.contains("active")) {
            button.innerText = "♥"; 
        } else {
            button.innerText = "♡";  
        }

        button.addEventListener("click", function (event) {
            event.preventDefault();

            const isWishListed = button.innerText === "♥";

            const form = document.createElement("form");
            form.method = "POST";
            form.action = "inWish.jsp"; 

            const prdNoField = document.createElement("input");
            prdNoField.type = "hidden";
            prdNoField.name = "prdNo";
            prdNoField.value = prdNo;
            form.appendChild(prdNoField);

            const actionField = document.createElement("input");
            actionField.type = "hidden";
            actionField.name = "action";
            actionField.value = isWishListed ? "remove" : "add"; 
            form.appendChild(actionField);

            document.body.appendChild(form);
            form.submit(); 

            if (isWishListed) {
                button.innerText = "♡"; 
            } else {
                button.innerText = "♥"; 
            }
        });
    });
});
</script>
<script>
let reviewOffset = 4; 

function loadMoreReviews() {

    const xhr = new XMLHttpRequest();
    xhr.open('GET', `loadMoreReviews.jsp?prdNo=<%= prdNoInt %>&offset=${reviewOffset}`, true);
    xhr.onload = function() {
        if (xhr.status === 200) {
            const newReviews = xhr.responseText;
            document.getElementById('reviewList').innerHTML += newReviews;
            reviewOffset += 4; 
        } else {
            console.error('Failed to load reviews');
        }
    };
    xhr.send();
}

const basePrice = <%= prdPrice %>; 

document.querySelectorAll('.volume-box').forEach(box => {
    box.addEventListener('click', () => {
        document.querySelectorAll('.volume-box').forEach(b => b.classList.remove('selected'));
        box.classList.add('selected');

        const addPrice = parseInt(box.getAttribute('data-addprice'), 10);
        const volume = box.getAttribute('data-volume');
        const newPrice = basePrice + addPrice;

        document.getElementById('prdSize').value = volume;
        document.getElementById('prdPrice').value = newPrice;
        document.querySelector("h2").innerText = newPrice.toLocaleString() + "원";
    });
});

window.addEventListener('DOMContentLoaded', () => {
    const selectedBox = document.querySelector('.volume-box.selected');
    const initPrice = basePrice + parseInt(selectedBox.getAttribute('data-addprice'), 10);
    document.querySelector("h2").innerText = initPrice.toLocaleString() + "원";
});

function showAllReviews() {
    const hiddenReviews = document.querySelectorAll('.hidden-review');
    hiddenReviews.forEach(review => {
        review.classList.remove('hidden-review');
    });
    document.getElementById('showMoreBtn').style.display = 'none';
}
</script>

</body>
</html>