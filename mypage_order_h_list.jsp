<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">

    <link rel="stylesheet" href="css/header_footer.css">
    <script src="./js/header_footer.js" defer></script>
    <style>
        /* 기존 스타일 유지 */
        .container1 {
            width: 100%;
            display: flex;
        }
        .product {
            display: flex;
            margin-bottom: 15px;
            border-radius: 10px;
            padding-bottom: 20px;
             height: 150px;
        }
       
        .product-info {
            flex: 1;
            border-bottom: 1px solid #ccc;
            margin-right: 50px;
        }
        .product-name {
            font-size: 30px;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .price {
            font-size: 20px;
            font-weight: bold;
          margin-top: 10px;
            margin-bottom: 30px;
        }
        

      .SC {
        display: flex;
        align-items: center;
        width: 100%;
      }

      .item-size, .item-color {
        font-size: 18px;
        flex: 0 0 auto;
        margin-right: 15px;
      }
        .review-btn {
            background: white;
            height: 60px;
            width: 250px;
            border: 1px solid black;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 8px;
            font-weight: bold;
        }
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            align-items: center;
            justify-content: center;
        }
        .modal-content {
         
          
            width: 100%;
            height: 100%;
            border-radius: 8px;
           
            position: relative;
        }
        .close-btn {
            position: absolute;
            top: 60px;
            right: 60px;
            font-size: 34px;
            font-weight: bold;
            cursor: pointer;
        }
        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
      body{
 -ms-overflow-style: none;
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

.button-column {
    display: flex;
    flex-direction: column;
    justify-content: center;
}


    </style>
</head>
<%
request.setCharacterEncoding("euc-kr");
String id = (String) session.getAttribute("sid");
if (id == null) {
    out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
    return;
}
%>
<body>
<div class="box">
<%
String DB_URL = "jdbc:mysql://localhost:3306/flower";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("org.gjt.mm.mysql.Driver");
    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

  String sql = "SELECT ordNo, memId, ordDate, total, status " +
             "FROM orderinfo WHERE memId = ? AND (isCanceled IS NULL OR isCanceled != 'Y') " +
             "ORDER BY ordNo DESC";


    pstmt = con.prepareStatement(sql);
    pstmt.setString(1, id);
    rs = pstmt.executeQuery();

    boolean hasData = false;
%>

    <%
    while (rs.next()) {
        hasData = true;
        int ordNo = rs.getInt("ordNo");
      Timestamp ordDate = rs.getTimestamp("ordDate");
         java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
        double total = rs.getDouble("total");
        String status = rs.getString("status") != null ? rs.getString("status") : "배송 준비 중";

        // 상품 요약 정보 가져오기
        String productSql =
            "SELECT name, SUM(count) AS total FROM (" +
            "  SELECT p.prdName AS name, COUNT(*) AS count " +
            "  FROM orderproduct o " +
            "  JOIN product p ON o.prdNo = p.prdNo " +
            "  WHERE o.ordNo = ? " +
            "  GROUP BY p.prdName " +
            "  UNION ALL " +
            "  SELECT c.cusName AS name, SUM(cp.cusQty) AS count " +
            "  FROM custom_product cp " +
            "  JOIN custom c ON cp.cusNo = c.cusNo " +
            "  WHERE cp.ordNo = ? " +
            "  GROUP BY c.cusName " +
            ") AS combined " +
            "GROUP BY name";

        PreparedStatement productPstmt = con.prepareStatement(productSql);
        productPstmt.setInt(1, ordNo);
        productPstmt.setInt(2, ordNo);
        ResultSet productRs = productPstmt.executeQuery();

        String mainProduct = "";
        int totalCount = 0;

        if (productRs.next()) {
            mainProduct = productRs.getString("name");
            totalCount = productRs.getInt("total");

            int otherCount = 0;
            while (productRs.next()) {
                otherCount += productRs.getInt("total");
            }

            if (otherCount > 0) {
                mainProduct += " 외 " + otherCount + "개";
            }
        }

        productRs.close();
        productPstmt.close();
%>
<div class="container">
    <div class="product">
        <div class="img"></div>
        <div class="product-info">
            <div class="product-name"><%= mainProduct %></div>
            <div class="price"><%= String.format("%,.0f", total) %>원</div>
            <div class="SC">
                <div class="item-size"><%= sdf.format(ordDate) %>&nbsp;&nbsp;주문</div>
                <div class="item-color"></div>
            </div>
        </div>
        <!-- 버튼 감싸는 영역 -->
        <div class="button-column">
            <button class="review-btn" onclick="openModal(<%= ordNo %>, true)">구매 상세정보</button>
			<% if ("배송 준비 중".equals(status)) { %>
            <button class="review-btn" onclick="cancelOrder(<%= ordNo %>)">주문 취소</button>
			<% } %>
        </div>
    </div>
</div>






<%
    }
%>

<%
    if (!hasData) {
%>
<p class="no-data">주문 내역이 없습니다.</p>
<%
    }
} catch (SQLException e) {
    out.println("<p class='no-data'>데이터베이스 오류 발생: " + e.getMessage() + "</p>");
    e.printStackTrace();
} catch (Exception e) {
    out.println("<p class='no-data'>알 수 없는 오류 발생: " + e.getMessage() + "</p>");
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    } catch (SQLException ignored) {}
}
%>

<div id="modal" class="modal">
    <div class="modal-content">
        <span class="close-btn">&times;</span>
        <iframe src="./mypage_order_h_list_detail.jsp"></iframe>
    </div>
</div>

<script>
    const reviewButtons = document.querySelectorAll(".review-btn");
    const closeButtons = document.querySelectorAll(".close-btn");

    reviewButtons.forEach(button => {
        button.addEventListener("click", function () {
            const modalId = this.getAttribute("data-modal-id");
            const modal = document.getElementById(modalId);
            if (modal) modal.style.display = "flex";
        });
    });

    closeButtons.forEach(button => {
        button.addEventListener("click", function () {
            this.closest(".modal").style.display = "none";
        });
    });

    window.addEventListener("click", function (event) {
        document.querySelectorAll(".modal").forEach(modal => {
            if (event.target === modal) {
                modal.style.display = "none";
            }
        });
    });

function openModal(ordNo, isCustom) {
    const modal = document.getElementById("modal");
    const iframe = modal.querySelector("iframe");
    if (isCustom) {
       iframe.src = "./mypage_order_detail.jsp?ordNo=" + ordNo;
    } 
    modal.style.display = "flex";
}


</script>
<script>
    function openModal(ordNo, isCustom) {
        // 팝업 창 크기 설정
        var popupW = 1000;
        var popupH = 650;

        // 화면 중앙으로 팝업 창 위치 설정
        var left = Math.ceil((window.screen.width - popupW) / 2);
        var top = Math.ceil((window.screen.height - popupH) / 2);

        // 주문 상세 정보를 보여줄 URL 생성
        let url = isCustom ? "./mypage_order_detail.jsp?ordNo=" + ordNo : "./mypage_order_h_list_detail.jsp?ordNo=" + ordNo;

        // 새 팝업 창 열기
        window.open(url, "OrderDetails", "width=" + popupW + ",height=" + popupH + ",left=" + left + ",top=" + top + ",scrollbars=yes,resizable=yes,toolbar=no,titlebar=no,menubar=no,location=no");
    }
	
</script>
<script>
function cancelOrder(ordNo) {
    if (confirm("정말로 주문을 취소하시겠습니까?")) {
        // 실제 취소 처리는 JSP 또는 서블릿에서 처리해야 함
        location.href = "order_cancel.jsp?ordNo=" + ordNo;
    }
}
</script>


</div>
</body>
</html>
