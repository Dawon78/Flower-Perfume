


<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
  // 환불 요청 정보 저장용 리스트
    List<Map<String, Object>> refundRequests = new ArrayList<>();
    // 환불 아이템 정보 저장용 리스트
    List<Map<String, Object>> refundItems = new ArrayList<>();
    String id = (String) session.getAttribute("sid");
    String ordNo = request.getParameter("ordNo");

    if (id == null || ordNo == null) {
        response.sendRedirect("login.jsp");
        return;
    }
  int total = 0;
    int returnShippingFee = 6000;
    int refundAmount = 0;
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
       String sql = "SELECT status, total FROM orderinfo WHERE memId = ? AND ordNo = ?";

        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, ordNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            status = rs.getString("status");
			 total = rs.getInt("total");
        }

		 refundAmount = total - returnShippingFee;


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
         String productSql = "SELECT op.ctQty, op.prdImg, p.prdName, p.prdPrice, m.size, m.color, op.prdNo " +
                      "FROM orderproduct op " +
                      "JOIN product p ON op.prdNo = p.prdNo " +
                      "JOIN mapping_id m ON op.mapping_id = m.mappingId " +
                      "WHERE op.ordNo = ?";
     
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
				product.put("prdNo", rs.getString("prdNo"));

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
				customProduct.put("cusNo", rs.getString("cusNo"));

                customProducts.add(customProduct);
            }
			 // 3. 환불 요청 조회
        String refundSql = "SELECT refund_id, ordNo, memId, refund_reason, refund_amount, refund_status, " +
                           "request_date, processed_date, refund_products, bank, account_holder, account_number " +
                           "FROM refund_request WHERE ordNo = ? AND memId = ?";

        pstmt = con.prepareStatement(refundSql);
        pstmt.setString(1, ordNo);
        pstmt.setString(2, id);
        rs = pstmt.executeQuery();

        while (rs.next()) {
            Map<String, Object> refundRequest = new HashMap<>();
            refundRequest.put("refund_id", rs.getInt("refund_id"));
            refundRequest.put("ordNo", rs.getInt("ordNo"));
            refundRequest.put("memId", rs.getString("memId"));
            refundRequest.put("refund_reason", rs.getString("refund_reason"));
            refundRequest.put("refund_amount", rs.getInt("refund_amount"));
            refundRequest.put("refund_status", rs.getString("refund_status"));
            refundRequest.put("request_date", rs.getTimestamp("request_date"));
            refundRequest.put("processed_date", rs.getTimestamp("processed_date"));
            refundRequest.put("refund_products", rs.getString("refund_products"));
            refundRequest.put("bank", rs.getString("bank"));
            refundRequest.put("account_holder", rs.getString("account_holder"));
            refundRequest.put("account_number", rs.getString("account_number"));

            refundRequests.add(refundRequest);

            // refund_id 로 환불 아이템 조회
            int refundId = rs.getInt("refund_id");
           String refundItemSql = "SELECT refund_item_id, refund_id, prdNo, custom_prdNo, mappingId, quantity " +
                       "FROM refund_item WHERE refund_id = ?";

            try (PreparedStatement pstmt2 = con.prepareStatement(refundItemSql)) {
                pstmt2.setInt(1, refundId);
                try (ResultSet rs2 = pstmt2.executeQuery()) {
                    while (rs2.next()) {
                        Map<String, Object> refundItem = new HashMap<>();
                        refundItem.put("refund_item_id", rs2.getInt("refund_item_id"));
                        refundItem.put("prdNo", rs2.getObject("prdNo")); // int or null
                        refundItem.put("custom_prdNo", rs2.getObject("custom_prdNo")); // int or null
                        refundItem.put("mappingId", rs2.getObject("mappingId")); // int or null
                        refundItem.put("quantity", rs2.getInt("quantity"));
						refundItem.put("refund_id", rs2.getInt("refund_id"));
                        refundItems.add(refundItem);
                    }
                }
            }
        }

        rs.close();
        pstmt.close();

			
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
    max-width: 1000px;
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


  select {
    padding: 5px;
    font-size: 14px;
  }

  img {
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


 form {
  max-width: 100%;


  background: #fff;
  border-radius: 8px;
 
  color: #333;
}

form label {
  display: block;
  margin-bottom: 6px;
  font-weight: 600;
  color: #222;
}

form input[type="text"],
form textarea {
  width: 90%;
  padding: 10px 12px;
  margin-bottom: 16px;
  border: 1.8px solid #ccc;
  border-radius: 5px;
  font-size: 15px;
  transition: border-color 0.3s ease;
  resize: vertical;
}

form input[type="text"]:focus,
form textarea:focus {
  border-color: #3399ff;
  outline: none;
  box-shadow: 0 0 6px #a2c8ff;
}

form textarea {
  min-height: 80px;
}

.notice-box {
  border-left: 4px solid;
  padding: 12px 16px;
  margin-bottom: 20px;
  border-radius: 4px;
  font-size: 14px;
  line-height: 1.5;
}

.notice-box strong {
  display: block;
  margin-bottom: 8px;
  font-weight: 700;
}

.notice-box ul {
  padding-left: 20px;
  margin: 0;
}

.notice-box li {
  margin-bottom: 6px;
}

/* 색상별 공통 클래스 */
.notice-box.orange {
  background-color: #fff8f0;
  border-color: #ff6600;
  color: #663300;
}

.notice-box.blue {
  background-color: #eef9ff;
  border-color: #3399ff;
  color: #004080;
}

button.btn {
  width: 100%;
  padding: 12px;
  background-color: #3399ff;
  border: none;
  border-radius: 6px;
  color: white;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

button.btn:hover {
  background-color: #2673cc;
}

</style>

</head>
<body>
<form action="refund_process.jsp" method="post" accept-charset="UTF-8" id="refundForm">
<div class="box">
  <div class="container">
    <h2>환불 요청</h2>

   <div class="tabs">
  <div class="tab active" data-tab="basic">환불 상품 선택</div>
  <div class="tab" data-tab="claim">환불 요청</div>
  <div class="tab" data-tab="status">환불 현황</div> <!-- 추가된 탭 -->
</div>




		<!-- 주문 상품 정보 -->
		<div class="tab-content active" id="tab-basic">
			<div style="margin-bottom: 10px;">
	  <label>
		<input type="checkbox" id="selectAll"> 전체 선택
	  </label>
	</div>
		  <h2>주문한 일반 상품</h2>

		  <div class="product-list">
		
			<%
				if (products.isEmpty()) {
			%>
				<p>일반 상품이 없습니다.</p>
			<%
				} else {
				int generalIndex = 0; 
					for (Map<String, String> product : products) {
			%>
	<div class="container1">
		<div class="product">

	<input type="checkbox" name="prdNo" value="<%= product.get("prdNo") %>" class="generalCheckbox" />


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

    // 수량과 총 가격 계산
    int qty = Integer.parseInt(product.get("ctQty"));
    int totalPrice = adjustedPrice * qty;
%>
			  <div class="price">
	   <%= String.format("%,d", totalPrice) %>원 
	 <%= product.get("ctQty") %>개&nbsp; &nbsp; 
	  환불 수량: 
<input 
  type="number" 
  name="prdQty" 
  min="0" 
  max="<%= product.get("ctQty") %>" 
  value="0"
  class="prdQtyInput"
  data-price="<%= adjustedPrice %>" 
/>

	</div>

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
				  generalIndex++;  // ? 반복문 안에서 증가
					}
				}
			%>
		</div>

		  <h2>주문한 커스텀 상품</h2>
		
		  <div class="custom-product-list">
		   
			<%
				if (customProducts.isEmpty()) {
			%>
				<p>커스텀 상품이 없습니다.</p>
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
				<input type="checkbox" name="customPrdNo" value="<%= cp.get("cusNo") %>" class="customCheckbox" style="margin-right:10px;" />


					<img src="<%= cp.get("cusImg") %>" alt="<%= cp.get("cusName") %>" />
					<div class="product-info">
						<div class="product-name"><%= cp.get("cusName") %></div>
					  <div class="price">
					  <%
    int cusQty = Integer.parseInt(cp.get("cusQty"));
    double totalCusPrice = price * cusQty;
%>
	 <%= String.format("%,.0f", totalCusPrice) %>원 
	  <%= cp.get("cusQty") %>개 &nbsp; &nbsp; 
	  환불 수량: 
<input 
  type="number" 
  name="customQty" 
  min="0" 
  max="<%= cp.get("cusQty") %>" 
  value="0"
  class="customQtyInput"
  data-price="<%= cp.get("cusPrice") %>" 
/>

	</div>
						<div class="SC">
							<div class="item-size">Size: <%= cp.get("volume") %></div>
							<div class="item-color">
								Color:
								<span class="color-box" style="background-color: <%= colorCode %>;"></span>
							</div>
							<div class="item-size">Top Note: <%= cp.get("top_note") %></div>
							<div class="item-size">Middle Note: <%= cp.get("middle_note") %></div>
							<div class="item-size">Base Note: <%= cp.get("base_note") %></div>
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
<input type="hidden" name="memId" value="<%= id %>" />
<input type="hidden" name="ordNo" value="<%= ordNo %>" />

    <!-- 주문자 정보 -->
    <div class="tab-content" id="tab-claim">

   <label for="refund_reason">환불 사유:</label>
<textarea name="refund_reason" id="refund_reason" rows="4" required></textarea>


    <label for="bank">환불 받을 계좌 정보 <small>(무통장 입금/계좌이체 주문 시)</small></label>
    <input type="text" id="bank" name="bank" placeholder="은행명 예: 국민은행">
    <input type="text" id="accountHolder" name="accountHolder" placeholder="예금주명">
    <input type="text" id="accountNumber" name="accountNumber" placeholder="계좌번호">

    <label>환불 배송비</label>
    <p><%= String.format("%,d", returnShippingFee) %> 원 (환불 금액에서 차감)</p>

<label>환불 금액</label>
<p id="refundAmountText">0 원</p>
<input type="hidden" name="refund_amount" id="refundAmountInput" value="0" />


    <div class="notice-box" style="background-color: #f9f9f9; border-left: 4px solid #ff6600; padding: 10px; margin-top: 20px;">
        <strong>※ 환불 시 주의 사항</strong>
        <ul style="margin-top: 8px; padding-left: 18px;">
            <li>상품이 훼손된 경우 환불이 불가능할 수 있습니다.</li>
            <li>환불 배송비는 환불 금액에서 차감됩니다.</li>
            <li>환불 수거일로부터 3~5일 이내 환불이 완료됩니다.</li>
        </ul>
    </div>

    <div class="notice-box" style="background-color: #eef9ff; border-left: 4px solid #3399ff; padding: 10px; margin-top: 20px;">
        <strong>※ 결제 수단별 환불 안내</strong>
        <ul style="margin-top: 8px; padding-left: 18px;">
            <li><strong>카드 결제</strong> 시, 입력하신 계좌가 아닌 <strong>결제하신 카드로 환불</strong>됩니다.</li>
            <li>카드 환불은 카드사 정책에 따라 승인 취소 또는 환불 처리되며 <strong>3~7영업일</strong>이 소요될 수 있습니다.</li>
            <li><strong>무통장 입금/계좌이체</strong> 시에는 위의 계좌 정보를 정확히 입력해주세요.</li>
        </ul>
    </div>

    <button type="submit" class="btn">환불 요청 접수</button>


  </div>
<div class="tab-content" id="tab-status">


  <%-- 배송 로그 보여주기 --%>
<%
  if (logs.isEmpty()) {
%>
  <p>배송 로그가 없습니다.</p>
<%
  } else {
    for (Map<String, String> log : logs) {
      String message = log.get("logMessage");
      String date = log.get("logDate");
%>
  <div><%= message != null ? message : "" %> <%= date != null ? date : "" %></div>
<%
    }
  }


    // 미리 Map으로 변환
    Map<String, Map<String,String>> productMap = new HashMap<>();
    for (Map<String,String> p : products) {
      productMap.put(p.get("prdNo"), p);
    }
    Map<String, Map<String,String>> customProductMap = new HashMap<>();
    for (Map<String,String> cp : customProducts) {
      customProductMap.put(cp.get("cusNo"), cp);
    }

    if (refundRequests.isEmpty()) {
  %>
    <p>환불 요청 내역이 없습니다.</p>
  <%
    } else {
      for (Map<String, Object> refund : refundRequests) {
        int currentRefundId = (int) refund.get("refund_id");
  %>
    <div >
     
    
       <h3>환불 요청일: <%= refund.get("request_date") != null ? sdf.format(refund.get("request_date")) : "" %></h3>
	    <h3>환불 사유: <%= refund.get("refund_reason") %></h3>
	   <h3> 상태: <%= refund.get("refund_status") %></h3>
   

      <%
        for (Map<String, Object> item : refundItems) {
          int itemRefundId = (item.get("refund_id") instanceof Number) ? ((Number)item.get("refund_id")).intValue() : -1;
          if (itemRefundId != currentRefundId) continue;

          Integer prdNo = (item.get("prdNo") instanceof Number) ? ((Number)item.get("prdNo")).intValue() : null;
          Integer customPrdNo = (item.get("custom_prdNo") instanceof Number) ? ((Number)item.get("custom_prdNo")).intValue() : null;
          Integer quantity = (item.get("quantity") instanceof Number) ? ((Number)item.get("quantity")).intValue() : 0;

          // ? prdNo와 customPrdNo가 모두 null이면 출력하지 않음
          if (prdNo == null && customPrdNo == null) continue;

          if (prdNo != null) {
            Map<String,String> prod = productMap.get(String.valueOf(prdNo));
            if (prod != null) {
      %>



 <%
 String box_color =prod.get("color");
    
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
    %>
	  	  <div class="container1">
            <div class="product">
       <img src="<%= prod.get("prdImg") %>" >
                <div class="product-info">
                    <div class="product-name"><%= prod.get("prdName") %> </div>
                  <div class="price">
				  환불 금액: <%= refund.get("refund_amount") %>원
 
  <span> / 수량: <%= quantity %>개</span>&nbsp; &nbsp; 

</div>
                    <div class="SC">
                        <div class="item-size">Size:  <%= prod.get("size") %></div>
                         <div class="item-color">
                            Color:
                            <span class="color-box" style="background-color: <%= colorCode %>;"></span>
                        </div>
                       
                    </div>
                </div>
            </div>
      <%
            }
          } else if (customPrdNo != null) {
            Map<String,String> cprod = customProductMap.get(String.valueOf(customPrdNo));
            if (cprod != null) {
      %>
    
 <%
 String box_color =cprod.get("box_color");
    
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
    %>

	  <div class="container1">
            <div class="product">
       <img src="<%= cprod.get("cusImg") %>">
                <div class="product-info">
                    <div class="product-name"><%= cprod.get("cusName") %> </div>
                  <div class="price">
				  환불 금액: <%= refund.get("refund_amount") %>원
 
  <span> / 수량: <%= quantity %>개</span>&nbsp; &nbsp; 

</div>
                    <div class="SC">
                        <div class="item-size">Size: <%= cprod.get("volume") %></div>
                         <div class="item-color">
                            Color:
                            <span class="color-box" style="background-color: <%= colorCode %>;"></span>
                        </div>
                        <div class="item-size">Top Note: <%= cprod.get("top_note") %></div>
                        <div class="item-size">Middle Note: <%= cprod.get("middle_note") %></div>
                        <div class="item-size">Base Note: <%= cprod.get("base_note") %></div>
                    </div>
                </div>
            </div>
        </div>
      <%
            }
          }
        }
      %>
    </div>
  <%
      }
    }
  %>
</div>




</div>
</form>

</body>
<script>
  const tabs = document.querySelectorAll('.tab');
  const tabContents = document.querySelectorAll('.tab-content');

  tabs.forEach(tab => {
    tab.addEventListener('click', () => {
      const target = tab.getAttribute('data-tab');

      tabs.forEach(t => t.classList.remove('active'));
      tabContents.forEach(tc => tc.classList.remove('active'));

      tab.classList.add('active');
      document.getElementById('tab-' + target).classList.add('active');
    });
  });
</script>

<script>
  document.getElementById('selectAll').addEventListener('change', function() {
    var checked = this.checked;
    document.querySelectorAll('.generalCheckbox').forEach(cb => cb.checked = checked);
    document.querySelectorAll('.customCheckbox').forEach(cb => cb.checked = checked);
  });
</script>

<script>
document.querySelector('form').addEventListener('submit', function(e) {
  document.querySelectorAll('input[name="prdQty"]').forEach(input => input.disabled = true);
  document.querySelectorAll('.generalCheckbox').forEach((checkbox, idx) => {
    if (checkbox.checked) {
      document.querySelectorAll('input[name="prdQty"]')[idx].disabled = false;
    }
  });
});
</script>
<script>
  document.addEventListener("DOMContentLoaded", function() {
    // 일반 상품 체크박스, 수량
    const generalCheckboxes = document.querySelectorAll(".generalCheckbox");
    const generalQtyInputs = document.querySelectorAll("input[name='prdQty']");
    
    // 커스텀 상품 체크박스, 수량
    const customCheckboxes = document.querySelectorAll(".customCheckbox");
    const customQtyInputs = document.querySelectorAll("input[name='customQty']");
    
    function initCheckboxQty(checkboxes, qtyInputs) {
      qtyInputs.forEach((input, idx) => {
        if (!checkboxes[idx].checked) {
          input.disabled = true;
          input.value = 0;
        }
      });

      checkboxes.forEach((checkbox, idx) => {
        checkbox.addEventListener("change", () => {
          if (checkbox.checked) {
            qtyInputs[idx].disabled = false;
            if (qtyInputs[idx].value == 0) qtyInputs[idx].value = 1;
          } else {
            qtyInputs[idx].disabled = true;
            qtyInputs[idx].value = 0;
          }
        });
      });
    }

    initCheckboxQty(generalCheckboxes, generalQtyInputs);
    initCheckboxQty(customCheckboxes, customQtyInputs);

    // 제출 시 체크박스 & 수량 유효성 검사
    document.getElementById("refundForm").addEventListener("submit", function(event) {
      let anyChecked = false;
      let qtySum = 0;

      // 일반 상품 검사
      for (let i = 0; i < generalCheckboxes.length; i++) {
        if (generalCheckboxes[i].checked) {
          anyChecked = true;
          let qty = parseInt(generalQtyInputs[i].value, 10);
          if (!isNaN(qty)) qtySum += qty;
        }
      }

      // 커스텀 상품 검사
      for (let i = 0; i < customCheckboxes.length; i++) {
        if (customCheckboxes[i].checked) {
          anyChecked = true;
          let qty = parseInt(customQtyInputs[i].value, 10);
          if (!isNaN(qty)) qtySum += qty;
        }
      }

      if (!anyChecked) {
        alert("환불 요청할 상품을 하나 이상 선택해주세요.");
        event.preventDefault();
        return false;
      }

      if (qtySum === 0) {
        alert("선택한 상품의 환불 수량을 1개 이상 입력해주세요.");
        event.preventDefault();
        return false;
      }
    });
  });
</script>


<script>
document.addEventListener("DOMContentLoaded", function () {

  function updateRefundAmount() {
    let totalRefund = 0;

    // 일반 상품 환불 금액 계산
    document.querySelectorAll(".prdQtyInput").forEach(input => {
      const checkbox = input.closest(".product").querySelector(".generalCheckbox");
      if (checkbox && checkbox.checked) {
        const unitPrice = parseInt(input.dataset.price, 10) || 0;
        const refundQty = parseInt(input.value, 10) || 0;
        totalRefund += unitPrice * refundQty;
      }
    });

    // 커스텀 상품 환불 금액 계산
    document.querySelectorAll(".customQtyInput").forEach(input => {
      const checkbox = input.closest(".product").querySelector(".customCheckbox");
      if (checkbox && checkbox.checked) {
        const unitPrice = parseFloat(input.dataset.price) || 0;
        const refundQty = parseInt(input.value, 10) || 0;
        totalRefund += unitPrice * refundQty;
      }
    });

    // 배송비 6000원 차감, 음수 방지
    totalRefund = Math.max(totalRefund - 6000, 0);

    // 환불 금액 표시
    const refundTextElem = document.getElementById("refundAmountText");
    if (refundTextElem) {
      refundTextElem.innerText = totalRefund.toLocaleString() + " 원";
    }

    // 숨겨진 input 값 세팅
    const refundInputElem = document.getElementById("refundAmountInput");
    if (refundInputElem) {
      refundInputElem.value = totalRefund;
    }
  }

  // 전체 선택 체크박스 기능 (일반 + 커스텀)
  const selectAllCheckbox = document.getElementById("selectAll");
  if (selectAllCheckbox) {
    selectAllCheckbox.addEventListener("change", function() {
      const checked = this.checked;
      document.querySelectorAll(".generalCheckbox, .customCheckbox").forEach(cb => {
        cb.checked = checked;
      });
      updateRefundAmount();
    });
  }

  // 이벤트 리스너 등록 (수량 입력 및 체크박스 변경 시)
  document.querySelectorAll(".prdQtyInput, .customQtyInput, .generalCheckbox, .customCheckbox").forEach(el => {
    el.addEventListener("input", updateRefundAmount);
    el.addEventListener("change", updateRefundAmount);
  });

  // 초기 환불 금액 계산
  updateRefundAmount();
});
</script>




<script>
  document.addEventListener("DOMContentLoaded", function() {
    // 일반 상품 체크박스, 수량
    const generalCheckboxes = document.querySelectorAll(".generalCheckbox");
    const generalQtyInputs = document.querySelectorAll("input[name='prdQty']");
    
    // 커스텀 상품 체크박스, 수량
    const customCheckboxes = document.querySelectorAll(".customCheckbox");
    const customQtyInputs = document.querySelectorAll("input[name='customQty']");
    
    function initCheckboxQty(checkboxes, qtyInputs) {
      qtyInputs.forEach((input, idx) => {
        if (!checkboxes[idx].checked) {
          input.disabled = true;
          input.value = 0;
        }
      });

      checkboxes.forEach((checkbox, idx) => {
        checkbox.addEventListener("change", () => {
          if (checkbox.checked) {
            qtyInputs[idx].disabled = false;
            if (qtyInputs[idx].value == 0) qtyInputs[idx].value = 1;
          } else {
            qtyInputs[idx].disabled = true;
            qtyInputs[idx].value = 0;
          }
        });
      });
    }

    initCheckboxQty(generalCheckboxes, generalQtyInputs);
    initCheckboxQty(customCheckboxes, customQtyInputs);

    // 제출 시 체크박스 & 수량 유효성 검사
    document.getElementById("refundForm").addEventListener("submit", function(event) {
      let anyChecked = false;
      let qtySum = 0;

      // 일반 상품 검사
      for (let i = 0; i < generalCheckboxes.length; i++) {
        if (generalCheckboxes[i].checked) {
          anyChecked = true;
          let qty = parseInt(generalQtyInputs[i].value, 10);
          if (!isNaN(qty)) qtySum += qty;
        }
      }

      // 커스텀 상품 검사
      for (let i = 0; i < customCheckboxes.length; i++) {
        if (customCheckboxes[i].checked) {
          anyChecked = true;
          let qty = parseInt(customQtyInputs[i].value, 10);
          if (!isNaN(qty)) qtySum += qty;
        }
      }

      if (!anyChecked) {
        alert("환불 요청할 상품을 하나 이상 선택해주세요.");
        event.preventDefault();
        return false;
      }

      if (qtySum === 0) {
        alert("선택한 상품의 환불 수량을 1개 이상 입력해주세요.");
        event.preventDefault();
        return false;
      }
    });
  });
</script>

</html>
