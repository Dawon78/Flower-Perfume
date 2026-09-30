<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="euc-kr">
  <title>상품주문정보 조회</title>
  <style>
@font-face {
    font-family: 'BookkMyungjo-Bd';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

    body {
    font-family: 'BookkMyungjo-Bd', serif;

      margin: 0;
    
      
    }
    .container {
      width: auto;
      height: auto;
      margin: 0px 20px;
      background: #fff;
      padding: 20px;
      border-radius: 6px;
      background: #fff;

    }
    h2 {
      margin-bottom: 20px;
    }
    .tabs {
      display: flex;
      border-bottom: 1px solid #ccc;
      margin-bottom: 20px;
	  
    }
    .tab {
      padding: 10px 20px;
      cursor: pointer;
      border: 1px solid #ccc;
      border-bottom: none;
      background: #f9f9f9;
      margin-right: 5px;
      border-radius: 5px 5px 0 0;
    }
    .tab.active {
      background: #fff;
    }
    .tab-content {
      display: none;
    }
    .tab-content.active {
      display: block;
    }
    .section {
      margin-bottom: 30px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 15px;
     

    }
    th, td {
      border: 1px solid #ccc;
      padding: 8px 10px;
      text-align: left;
      font-size: 14px;
     align-items: center;
      text-align: center;
    }
    th {
      background: #f1f1f1;
      font-weight: normal;
    }
    .right {
      text-align: right;
    }
    .blue-button {
      padding: 10px 24px;
      font-size: 18px;
      color: #fff;
      border: none;
      border-radius: 3px;
      cursor: pointer;
    }
    .gray-button {
      background: #ccc;
      color: #000;
    }
    textarea {
      width: 100%;
      height: 80px;
      font-size: 14px;
    }
    .bottom-buttons {
      text-align: center;
    }
    select {
      padding: 5px;
      font-size: 14px;
    }
   img{
   width: 120px;
    
   }
     
        .product {
            display: flex;
            margin-bottom: 15px;
            border-radius: 10px;
            padding-bottom: 20px;
        }
        .product img {
            width: 150px;
            height: 150px;
            border-radius: 15px;
            margin-right: 40px;
        }
        .product-info {
            flex: 1;
            border-bottom: 1px solid #ccc;
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
        gap:14px;
      }
      .color-box {
         display: inline-block;
         width: 20px;
         height: 20px;
         margin-left: 6px;
         border: 1px solid #ccc;
         vertical-align: middle;
         border-radius: 4px;
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

  </style>
</head>
<%
    request.setCharacterEncoding("euc-kr");
    String ordNoParam = request.getParameter("ordNo");

    if (ordNoParam == null || ordNoParam.trim().equals("")) {
        out.println("<p>주문번호가 제공되지 않았습니다.</p>");
        return;
    }

    int ordNo = Integer.parseInt(ordNoParam);

    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<body>
<div class="box">
  <div class="container">
    <h2>상품 구매 내역 조회</h2>

    <%
    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

      

         // 1. 일반 상품 조회
         String productSql = "SELECT op.ctQty, op.prdImg, p.prdName,p.prdPrice, m.size, m.color " +
                        "FROM orderproduct op " +
                        "JOIN product p ON op.prdNo = p.prdNo " +
                        "JOIN mapping_id m ON op.mapping_id = m.mappingId " +
                        "WHERE op.ordNo = ?";
        pstmt = con.prepareStatement(productSql);
        pstmt.setInt(1, ordNo);
        rs = pstmt.executeQuery();
%>
    <div class="tabs">
      <div class="tab active" data-tab="basic">구매 상품 정보</div>
      <div class="tab" data-tab="claim">구매자 정보</div>
      
    </div>

    <!-- 기본 정보 탭 -->
    <div class="tab-content active" id="tab-basic">
      <table>
        <h2>구매한 일반 상품</h2>

     <%
             boolean hasProduct = false;
             while (rs.next()) {
                 hasProduct = true;
     %>
           

<div class="container1">
    <div class="product">
       <img src="<%= rs.getString("prdImg") %>">
        <div class="product-info">
            <div class="product-name"><%= rs.getString("prdName") %></div>
           <%
    int basePrice = rs.getInt("prdPrice");
    String size = rs.getString("size");
    int adjustedPrice = basePrice;

    if ("125ML".equals(size)) {
        adjustedPrice += 10000;
    } else if ("150ML".equals(size)) {
        adjustedPrice += 20000;
    } else if ("175ML".equals(size)) {
        adjustedPrice += 30000;
    } else if ("200ML".equals(size)) {
        adjustedPrice += 40000;
    } // 100ML은 기본가격 유지
%>
<div class="price"><%= String.format("%,d", adjustedPrice) %>원 <%= rs.getInt("ctQty") %>개</div>

                   <div class="SC">
                <div class="item-size">Size: <%= rs.getString("size") %></div>
            
<%
    String color = rs.getString("color");
    String colorCode = "#ccc"; // 기본 색상

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
                <div class="item-color">
    Color:
    <span class="color-box" style="background-color:<%= colorCode %>;"></span>
   </div>
            </div>
         
        </div>
      
        </div>
       
    </div>
</div>

     <%
             }
     
             if (!hasProduct) {
     %>
             <tr><td colspan="5">구매한 일반 상품이 없습니다.</td></tr>
     <%
             }
             rs.close();
             pstmt.close();
     
             // 2. 커스텀 상품 조회
             String customSql = "SELECT cp.cusQty, cp.*, c.* FROM custom_product cp " +
                                "JOIN custom c ON cp.cusNo = c.cusNo " +
                                "WHERE cp.ordNo = ?";
             pstmt = con.prepareStatement(customSql);
             pstmt.setInt(1, ordNo);
             rs = pstmt.executeQuery();
     %>
       
      </table>
      <table>
        <h2>구매한 커스텀 상품</h2>

     <%
             boolean hasCustomProduct = false;
             while (rs.next()) {
                 hasCustomProduct = true;
                 String img = rs.getString("cusimg");
                 String name = rs.getString("cusName");
                 String volume = rs.getString("volume");
                 String color = rs.getString("box_color");
                 int qty = rs.getInt("cusQty");
                 String topNote = rs.getString("top_note");
                 String middleNote = rs.getString("middle_note");
                 String baseNote = rs.getString("base_note");
             double price = rs.getDouble("cusprice");


String size = rs.getString("volume");


     %>

<div class="container1">
    <div class="product">
        <img src="<%= img %>" alt="커스텀 이미지">
        <div class="product-info">
            <div class="product-name"><%= name %></div>
            <div class="price"><%= String.format("%,.0f", price) %>원 <%= qty %>개</div>
         
            <div class="SC">
                <div class="item-size">Size:  <%= size %></div>
            
            
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
                <div class="item-color">
    Color:
    <span class="color-box" style="background-color: <%= colorCode %>;"></span>
   </div>
            <div class="item-size">Top Note:&nbsp;  <%= topNote %></div>
              <div class="item-size">Middle Note:&nbsp;  <%= middleNote %></div>
               <div class="item-size">Base Note:&nbsp;  <%= baseNote %></div>
            </div>
        </div>
        
    </div>
</div>


    
     <%
             }
     
             if (!hasCustomProduct) {
     %>
             <tr><td colspan="8">구매한 커스텀 상품이 없습니다.</td></tr>
     <%
             }
     
             rs.close();
             pstmt.close();

             // 3. 주문자 정보 조회
             String infoSql = "SELECT * FROM orderinfo WHERE ordNo = ?";
             pstmt = con.prepareStatement(infoSql);
             pstmt.setInt(1, ordNo);
             rs = pstmt.executeQuery();
     
             if (rs.next()) {
     %>
      </table>
    </div>

    <div class="tab-content" id="tab-claim">
      <table>
        <h2>구매자 정보</h2>
              <tbody>
              <tr>
                  <th>구매자 ID</th><td><%= rs.getString("memId") %></td>
                  <th>구매자 성함</th><td><%= rs.getString("ordSender") %></td>
                  <th>수신자 성함</th><td><%= rs.getString("orderReceiver") %></td>
              </tr>
              <tr>
                  <th>주문번호</th><td colspan="3"><%= rs.getInt("ordNo") %></td>
                  <th>상품주문상태</th><td><%= rs.getString("status") %></td>
              </tr>
              <tr>
                  <th>도로명 주소</th><td colspan="3"><%= rs.getString("ordRcvAddress1") %></td>
                  <th>전화번호</th><td><%= rs.getString("orderTel") %></td>
              </tr>
              <tr>
                  <th>상세주소</th><td colspan="3"><%= rs.getString("ordRcvAddress2") %></td>
                  <th>이메일</th><td colspan="3"><%= rs.getString("orderEmail") != null ? rs.getString("orderEmail") : "없음" %></td>
              </tr>
              <tr>
                  <th>결제 방식</th><td><%= rs.getString("ordPay") %></td>
                  <th>총 주문금액</th><td><%= String.format("%,d", rs.getInt("total")) %>원</td>

                  <th>업체 요청사항</th><td><%= rs.getString("orderCompanyask") %></td>
              </tr>
              <tr>
                  <th>카드번호</th><td><%= rs.getString("ordCardNo") != null ? rs.getString("ordCardNo") : "없음" %></td>
                  <th>유효기간</th><td><%= rs.getString("ordCardExpiry") != null ? rs.getString("ordCardExpiry") : "없음" %></td>
                  <th>CVC</th><td><%= rs.getString("ordCardPass") != null ? rs.getString("ordCardPass") : "없음" %></td>
              </tr>
              <tr>
                  <th>입금은행</th><td><%= rs.getString("ordBank") != null ? rs.getString("ordBank") : "없음" %></td>
                  <th>계좌번호</th><td colspan="3"><%= rs.getString("ordBankNo") != null ? rs.getString("ordBankNo") : "없음" %></td>
              </tr>
              <tr>
                  <th>입금액</th><td><%= String.format("%,d", rs.getInt("total")) %>원</td>

                  <th>예금주</th><td>김화자</td>
                  <th>입금자명</th><td><%= rs.getString("ordBankName") != null ? rs.getString("ordBankName") : "없음" %></td>
              </tr>
              <tr>
                  <th>문의내용</th><td colspan="5"><%= rs.getString("orderAsk") != null ? rs.getString("orderAsk") : "없음" %></td>
              </tr>
              </tbody>
          </table>
    </div>

      
  </div>
  </div>
  <%
} else {
    out.println("<p>해당 주문번호의 정보가 없습니다.</p>");
}

} catch (Exception e) {
out.println("<p style='color:red;'>오류 발생: " + e.getMessage() + "</p>");
} finally {
try {
    if (rs != null) rs.close();
    if (pstmt != null) pstmt.close();
    if (con != null) con.close();
} catch (SQLException ignored) {}
}
%>
  
  <script>
    // 탭 전환 스크립트
    const tabs = document.querySelectorAll('.tab');
    const contents = document.querySelectorAll('.tab-content');

    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        tabs.forEach(t => t.classList.remove('active'));
        contents.forEach(c => c.classList.remove('active'));

        tab.classList.add('active');
        document.getElementById('tab-' + tab.dataset.tab).classList.add('active');
      });
    });
  </script>
</body>
</html>
