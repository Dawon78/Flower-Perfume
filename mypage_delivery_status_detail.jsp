<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*" %>

<%
    String id = (String) session.getAttribute("sid");
    String ordNo = request.getParameter("ordNo");

    if (id == null || ordNo == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String tracking_number = " ";
    String status = "배송 준비중";
    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 배송 로그 저장용 리스트
    List<Map<String, String>> logs = new ArrayList<>();
    // 상품 정보 저장용 리스트
    List<Map<String, String>> products = new ArrayList<>();
    List<Map<String, String>> customProducts = new ArrayList<>();

    int progress = 0; // progress 변수를 JSP에서 사용 가능하도록 선언

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 현재 배송 상태 조회
        String sql = "SELECT status FROM orderinfo WHERE memId = ? AND ordNo = ?";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, ordNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            status = rs.getString("status");
        }

        // 배송 상태에 따라 progress 값 설정
        if ("배송 시작".equals(status)) {
            progress = 40;
        } else if ("배송중".equals(status)) {
            progress = 70;
        } else if ("배송 완료".equals(status)) {
            progress = 100;
        }

        rs.close();
        pstmt.close();

        // 배송 로그 조회
        String logSql = "SELECT status, location, updated_at, tracking_number FROM delivery_log WHERE ordNo = ? ORDER BY updated_at DESC";
        pstmt = con.prepareStatement(logSql);
        pstmt.setString(1, ordNo);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, String> log = new HashMap<>();
            log.put("status", rs.getString("status"));
            log.put("location", rs.getString("location") != null ? rs.getString("location") : "-");

            String updatedAt = rs.getString("updated_at");
            if (updatedAt != null && updatedAt.endsWith(".0")) {
                updatedAt = updatedAt.substring(0, updatedAt.length() - 2);
                tracking_number = rs.getString("tracking_number"); // 여기에 추가
            }
            log.put("time", updatedAt);
            logs.add(log);
        }

        // 1. 일반 상품 조회
        String productSql = "SELECT op.ctQty, op.prdImg, p.prdName, p.prdPrice, m.size, m.color " +
                            "FROM orderproduct op " +
                            "JOIN product p ON op.prdNo = p.prdNo " +
                            "JOIN mapping_id m ON op.mapping_id = m.mappingId " +
                            "WHERE op.ordNo = ?";
        // 2. 커스텀 상품 조회
          // 2. 커스텀 상품 조회
             String customSql = "SELECT cp.cusQty, cp.*, c.* FROM custom_product cp " +
                                "JOIN custom c ON cp.cusNo = c.cusNo " +
                                "WHERE cp.ordNo = ?";

        try {
            // 기존 DB 연결 및 쿼리 실행
            pstmt = con.prepareStatement(productSql);
            pstmt.setString(1, ordNo);
            rs = pstmt.executeQuery();

            // 일반 상품 결과 처리
            while (rs.next()) {
                Map<String, String> product = new HashMap<>();
                product.put("ctQty", rs.getString("ctQty"));
                product.put("prdImg", rs.getString("prdImg"));
                product.put("prdName", rs.getString("prdName"));
                product.put("prdPrice", rs.getString("prdPrice"));
                product.put("size", rs.getString("size"));
                product.put("color", rs.getString("color"));
                products.add(product);
            }

            rs.close();
            pstmt.close();

            // 커스텀 상품 결과 처리
            pstmt = con.prepareStatement(customSql);
            pstmt.setString(1, ordNo);
            rs = pstmt.executeQuery();

                  while (rs.next()) {
                Map<String, String> customProduct = new HashMap<>();
                customProduct.put("cusQty", rs.getString("cusQty"));
                customProduct.put("cusName", rs.getString("cusName"));
                customProduct.put("cusPrice", rs.getString("cusPrice"));
                customProduct.put("cusImg", rs.getString("cusImg"));
                customProduct.put("top_note", rs.getString("top_note"));
                customProduct.put("middle_note", rs.getString("middle_note"));
                customProduct.put("base_note", rs.getString("base_note"));
                customProduct.put("volume", rs.getString("volume"));
                customProduct.put("box_color", rs.getString("box_color"));
                customProducts.add(customProduct);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { 
                if (rs != null) rs.close(); 
                if (pstmt != null) pstmt.close(); 
            } catch (SQLException ignored) {}
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="euc-kr">

  <style>
  @font-face {
    font-family: 'BookkMyungjo-Bd';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
  }

  body {
    background-color: white;
    margin: 0 auto;
    max-width: 100%;
    height: 100%;
    font-family: 'BookkMyungjo-Bd', serif;
    -ms-overflow-style: none;
  }

  ::-webkit-scrollbar {
    display: none;
  }

  .box {
    -ms-overflow-style: none;
  }

  .box::-webkit-scrollbar {
    display: none;
  }

  .container, .container1 {
    width: 100%;
    max-width: 1100px;
    margin: auto;
    background: #fff;
    padding: 20px;
    border-radius: 6px;
    box-sizing: border-box;
  }

  h2, h3, h4 {
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
    font-size: 14px;
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
    background: #007bff;
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

  img {
    width: 120px;
  }

  .profile {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    align-items: center;
    gap: 15px;
  }

  .profile h1 {
    font-size: 40px;
    margin: 20px 0;
  }

  .delivery {
    border-top: 7px solid #ccc;
    border-bottom: 7px solid #ccc;
    padding: 20px 0;
  }

  .delivery h3 {
    text-align: center;
    font-size: 30px;
    opacity: 0.7;
  }

  .progress {
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 20px 0;
  }

  .progress-bar {
    width: 100%;
    max-width: 800px;
    height: 30px;
    background-color: #eee;
    border-radius: 20px;
    overflow: hidden;
    position: relative;
  }

  .progress-bar-fill {
    width: <%= progress %>;
    height: 100%;
    background-color: #ffcc00;
    transition: width 0.5s ease-in-out;
  }

  .progress-text {
    display: flex;
    justify-content: space-around;
    flex-wrap: wrap;
    width: 100%;
    max-width: 800px;
    margin-top: 20px;
    font-size: 16px;
    color: gray;
  }

  .progress-text span.active {
    color: #ffcc00;
    font-weight: bold;
	  flex: 1;
  text-align: center;
	
  }

  .delivery-records,
  .product-list {
    margin-top: 40px;
  }

  .delivery-records h4,
  .product-list h4 {
    font-size: 26px;
    margin-bottom: 20px;
  }

  .record,
  .product-item {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    border-bottom: 1px solid #ddd;
    padding: 10px 0;
  }

  .record h4, .record h5,
  .product-item h4, .product-item h5 {
    font-size: 20px;
    margin: 10px;
  }

  .record {
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid #ddd;
  padding: 10px 0;
  position: relative;
}

.record h4.time, .record h5.status {
  width: 45%;
  margin: 0;
  font-size: 18px;
}

.middle-line {
  width: 1px;
  height: 40px;
  background-color: #ccc;
}


  .record h5,
  .product-item h5 {
    color: #7b7b7b;
  }

  .delivery-records-header {
  display: flex;
  align-items: center;
  gap: 20px;
  margin-bottom: 20px;
}

.vertical-line {
  height: 35px;
  width: 1px;
  background-color: #aaa;
  margin-top: 15px;
}

.delivery-records h4.time {
  margin: 0;
  font-size: 18px;
  font-weight: normal;
  margin-top: 10px;
}


  .time {
    width: 200px;
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
    margin: 10px 0 30px;
  }

  .SC {
    display: flex;
    align-items: center;
    width: 100%;
    gap: 14px;
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
  .delivery-records-list-header {
  display: flex;
  justify-content: space-between;
  padding: 10px 0 5px 0;
  font-weight: bold;
  font-size: 20px;
  border-bottom: 1px solid #ccc;
  color: #555;
}

.delivery-records-list-header .time-label {
  flex: 1;
  text-align: center;
}

.delivery-records-list-header .location-label {
  flex: 1;
  text-align: center;
}


  @media screen and (max-width: 768px) {
    .progress-text {
      font-size: 14px;
    }

    .profile,
    .record {
      flex-direction: column;
      align-items: flex-start;
    }
  }
</style>

</head>
<body>
<div class="box">
  <div class="container">
    <h2>배송 현황</h2>

    <div class="tabs">
	<div class="tab active" data-tab="claim">배송 정보</div>
      <div class="tab" data-tab="basic">상품 정보</div>
    </div>


    <!-- 주문자 정보 -->
    <div class="tab-content active" id="tab-claim">
      <div class="profile">
    </div>

    <div class="delivery">
        <h3><%= status %></h3>
        <div class="progress">
        <div class="progress-bar">
<div class="progress-bar-fill" style="width: <%= progress %>%;"></div>
</div>
<div class="progress-text">
  <span class="<%= progress >= 0 ? "active" : "" %>">배송 준비중</span>
  <span class="<%= progress >= 40 ? "active" : "" %>">배송 시작</span>
  <span class="<%= progress >= 70 ? "active" : "" %>">배송중</span>
  <span class="<%= progress >= 100 ? "active" : "" %>">배송 완료</span>
</div>
        </div>
    </div>

    <div class="delivery-records">
<div class="delivery-records-header">
  <h4>배송기록</h4>
  <div class="vertical-line"></div>
  <h4 class="time">송장번호: &nbsp;<%= tracking_number %></h4>
</div>

  <div class="delivery-records-list-header">
    <span class="time-label">배송 시각</span>
    <span class="location-label">배송 위치</span>
  </div>

        <% 
            if (logs.isEmpty()) { 
        %>
            <p>배송 이력이 없습니다.</p>
        <% 
            } else {
                for (int i = logs.size() - 1; i >= 0; i--) {
                    Map<String, String> log = logs.get(i);
        %>
  <div class="record">
    <h4 class="time"><%= log.get("time") %></h4>
    <div class="middle-line"></div>
    <h5 class="status"><%= log.get("status") %><br><%= log.get("location") %></h5>
  </div>
        <% 
                }
            } 
        %>
    </div>
    </div>
  </div>
</div>
    <!-- 주문 상품 정보 -->
    <div class="tab-content" id="tab-basic">
      <h2 style="margin-left:20px;">구매한 일반 상품</h2>
      <div class="product-list">
    
        <%
            if (products.isEmpty()) {
        %>
            <p style="margin-left:20px;">일반 상품이 없습니다.</p>
        <%
            } else {
                for (Map<String, String> product : products) {
        %>
<div class="container1">
    <div class="product">
        <img src="<%= product.get("prdImg") %>" alt="<%= product.get("prdName") %>" />
        <div class="product-info">
            <div class="product-name"><%= product.get("prdName") %></div>
            <%
                // 가격 계산
                int basePrice = Integer.parseInt(product.get("prdPrice").toString()); // 가격이 String일 경우, Integer로 변환
                String size = product.get("size");
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
            <div class="price"><%= String.format("%,d", adjustedPrice) %>원 <%= product.get("ctQty") %>개</div>

            <div class="SC">
                <div class="item-size">Size: <%= product.get("size") %></div>
                
                <%
                    // 색상 코드 계산
                    String color = product.get("color");
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





       
        <%
                }
            }
        %>
    </div>

       <h2 style="margin-left:20px;">구매한 커스텀 상품</h2>
      <div class="custom-product-list">
       
        <%
            if (customProducts.isEmpty()) {
        %>
            <p style="margin-left:20px;">커스텀 상품이 없습니다.</p>
        <%
            } else {
                for (int i = 0; i < customProducts.size(); i++) {
                    Map<String, String> cp = customProducts.get(i);
                    String box_color = cp.get("box_color");
    
                    // 중복되지 않도록 하나의 colorCode만 사용
                    String colorCode = "#ccc";
                    if ("WHITE".equals(box_color)) {
                        colorCode = "#f3f3f3";
                    } else if ("WHITE BEIGE".equals(box_color)) {
                        colorCode = "#f6f5ec";
                    } else if ("BEIGE".equals(box_color)) {
                        colorCode = "#f3ece3";
                    } else if ("ROSY".equals(box_color)) {
                        colorCode = "#c8a19c";
                    } else if ("BROWN".equals(box_color)) {
                        colorCode = "#91766e";
                    }
    
                    double price = Double.parseDouble(cp.get("cusPrice"));
        %>
    
        <div class="container1">
            <div class="product">
                <img src="<%= cp.get("cusImg") %>" alt="<%= cp.get("cusName") %>" />
                <div class="product-info">
                    <div class="product-name"><%= cp.get("cusName") %></div>
                    <div class="price"><%= String.format("%,.0f", price) %>원 <%= cp.get("cusQty") %>개</div>
                    <div class="SC">
                        <div class="item-size">Size: <%= cp.get("volume") %></div>
                        <div class="item-color">
                            Color:
                            <span class="color-box" style="background-color: <%= colorCode %>;"></span>
                        </div>
                        <div class="item-size">Top Note:&nbsp; <%= cp.get("top_note") %></div>
                        <div class="item-size">Middle Note:&nbsp; <%= cp.get("middle_note") %></div>
                        <div class="item-size">Base Note:&nbsp; <%= cp.get("base_note") %></div>
                    </div>
                </div>
            </div>
        </div>
    
        <%
                } // for 끝
            } // else 끝
        %>
    </div>
    </div>
</body>
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
</html>
