<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLDecoder" %>
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
	
max-width: 100%;
    font-family: 'BookkMyungjo-Bd', serif;
      margin: 0;
      padding: 20px;
      background-color: #f5f5f5;
    }
    .container {
  
      margin: auto;
      background: #fff;
      padding: 20px;
      border-radius: 6px;

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
            font-size: 14px;
            border-radius: 4px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #e0e0e0;
            color: #333;
        }
        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        td {
           
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

    select {
      padding: 5px;
      font-size: 14px;
    }
      img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
        }
  </style>
</head>
<%
request.setCharacterEncoding("euc-kr");
String id = (String) session.getAttribute("sid");
if (id == null || !id.equals("manager")) {
    out.println("<script>alert('관리자만 접근할 수 있습니다.'); history.back();</script>");
    return;
}
String ordNoParam = request.getParameter("ordNo");
if (ordNoParam == null) {
    out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    return;
}
int ordNo = Integer.parseInt(ordNoParam);
%>
<body>
  <div class="container">
    <h2>상품주문정보 조회</h2>

    <%
String DB_URL = "jdbc:mysql://localhost:3306/flower";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

Connection con = null;
PreparedStatement pstmtProduct = null;
PreparedStatement pstmtCustom = null;
PreparedStatement pstmtOrderInfo = null;
ResultSet rsProduct = null;
ResultSet rsCustom = null;
ResultSet rsOrderInfo = null;

try {
    Class.forName("org.gjt.mm.mysql.Driver");
    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // 주문 기본 정보 가져오기
    String sqlOrderInfo = "SELECT * FROM orderinfo WHERE ordNo = ?";
    pstmtOrderInfo = con.prepareStatement(sqlOrderInfo);
    pstmtOrderInfo.setInt(1, ordNo);
    rsOrderInfo = pstmtOrderInfo.executeQuery();

   String sqlDeliveryLog = "SELECT * FROM orderinfo WHERE ordNo = ?";
PreparedStatement pstmtDeliveryLog = con.prepareStatement(sqlDeliveryLog);
pstmtDeliveryLog.setInt(1, ordNo);
ResultSet rsDeliveryLog = pstmtDeliveryLog.executeQuery();


    String status = "";
    int total = 0;
    if (rsOrderInfo.next()) {
        status = rsOrderInfo.getString("status");
        total = rsOrderInfo.getInt("total");
    }

    // 일반 상품 정보
    String sqlProduct = "SELECT op.memId,p.prdNo, p.prdName, op.ctQty, op.prdImg, m.size, m.color, p.prdPrice " +
                        "FROM orderproduct op " +
                        "JOIN product p ON op.prdNo = p.prdNo " +
                        "JOIN mapping_id m ON op.mapping_id = m.mappingId " +
                        "WHERE op.ordNo = ?";
    pstmtProduct = con.prepareStatement(sqlProduct);
    pstmtProduct.setInt(1, ordNo);
    rsProduct = pstmtProduct.executeQuery();

    boolean hasData = false;
%>
    <div class="tabs">
      <div class="tab active" data-tab="basic">주문 상품 정보</div>
      <div class="tab" data-tab="claim">주문자 정보</div>
      <div class="tab" data-tab="history">배송 정보</div>
    </div>

    <!-- 기본 정보 탭 -->
    <div class="tab-content active" id="tab-basic">
      <div class="section">
        <h4>| 일반 주문 상세내역</h4>
        <table>
          <thead>
            <tr>
          <th>상품번호</th>
              <th>상품명</th>
              <th>이미지</th>
              <th>수량</th>
              <th>용량</th>
              <th>박스 색상</th>
              <th>가격</th>
            </tr>
          </thead>
          <%
        while (rsProduct.next()) {
            hasData = true;
            int basePrice = rsProduct.getInt("prdPrice");
String size = rsProduct.getString("size");
int qty = rsProduct.getInt("ctQty");

int additional = 0;
switch (size) {
    case "125ML": additional = 10000; break;
    case "150ML": additional = 20000; break;
    case "175ML": additional = 30000; break;
    case "200ML": additional = 40000; break;
}
int price = (basePrice + additional) * qty;

            // 컬러 값을 URL 디코딩하여 가져옵니다.
            String color = URLDecoder.decode(rsProduct.getString("color"), "UTF-8");

            String colorName = "";
            switch (color) {
                case "#F3F3F3":
                    colorName = "WHITE";
                    break;
                case "#F6F5EC":
                    colorName = "WHITE BEIGE";
                    break;
                case "#f3ECE3":
                    colorName = "BEIGE";
                    break;
                case "#C8A19C":
                    colorName = "ROSY";
                    break;
                case "#91766E":
                    colorName = "BROWN";
                    break;
                default:
                    colorName = "UNKNOWN"; // 정의되지 않은 색상에 대해 기본 값 설정
                    break;
            }
        %>
        <tr>
          <td><%= rsProduct.getInt("prdNo") %></td>
          <td><%= rsProduct.getString("prdName") %></td>
          <td><img src="<%= rsProduct.getString("prdImg") %>" alt="상품 이미지"></td>
          <td><%= rsProduct.getInt("ctQty") %></td>
          <td><%= rsProduct.getString("size") %></td>
          <!-- 컬러 이름을 직접 출력 -->
          <td><%= colorName %></td>
          <td><%= String.format("%,d", price) %>원</td>
        </tr>
            <%
            }

            // 커스텀 상품 정보
            String sqlCustom = "SELECT cp.memId, c.cusNo, c.cusName, cp.cusQty, c.cusImg, c.top_note, c.middle_note, c.base_note, c.volume, c.box_color, c.cusPrice " +
                               "FROM custom_product cp " +
                               "JOIN custom c ON cp.cusNo = c.cusNo " +
                               "WHERE cp.ordNo = ?";
            pstmtCustom = con.prepareStatement(sqlCustom);
            pstmtCustom.setInt(1, ordNo);
            rsCustom = pstmtCustom.executeQuery();
            %>
          </tbody>
        </table>
      </div>

      <div class="section">
        <h4>| 커스텀 주문 상세내역</h4>
        <table>
          <thead>
            <tr>
         <th>커스텀 번호</th>
              <th>상품명</th>
              <th>이미지</th>
              <th>수량</th>
              <th>Top Note</th>
              <th>Middle Note</th>
              <th>Base Note</th>
              <th>용량</th>
              <th>박스 색상</th>
              <th>가격</th>
            </tr>
          </thead>
          <tbody>
            <%
            while (rsCustom.next()) {
                hasData = true;
        %>
            <tr>
         <td><%= rsCustom.getInt("cusNo") %></td>
              <td><%= rsCustom.getString("cusName") %></td>
              <td><img src="<%= rsCustom.getString("cusImg") %>" alt="커스텀 이미지"></td>
              <td><%= rsCustom.getInt("cusQty") %></td>
              <td><%= rsCustom.getString("top_note") %></td>
              <td><%= rsCustom.getString("middle_note") %></td>
              <td><%= rsCustom.getString("base_note") %></td>
              <td><%= rsCustom.getString("volume") %></td>
             <td><%= URLDecoder.decode(rsCustom.getString("box_color"), "UTF-8") %></td>

              <%
int cusPrice = rsCustom.getInt("cusPrice");
int cusQty = rsCustom.getInt("cusQty");
int totalCusPrice = cusPrice * cusQty;
%>
<td><%= String.format("%,d", totalCusPrice) %>원</td>
            </tr>
            <%
            }
            rsCustom.close();
            pstmtCustom.close();
            %>
          </tbody>
        </table>
      </div>
    </div>

    <div class="tab-content" id="tab-claim">
      <div class="section">
        <h4>| 주문 상세정보</h4>
        <table>
          <tbody>
        <tr>
              <th>주문자 ID</th><td><%= rsOrderInfo.getString("memId") %></td>
              <th>주문자 성함</th><td><%= rsOrderInfo.getString("ordSender") %></td>
              <th>수신자 성함</th><td><%= rsOrderInfo.getString("orderReceiver") %></td>
            </tr>
            <tr>
              <th>주문번호</th><td colspan="3"><%= rsOrderInfo.getInt("ordNo") %></td>
              
              <th>상품주문상태</th><td><%= rsOrderInfo.getString("status") %></td>
            </tr>
            
     
             <tr>
  <th>도로명 주소</th><td colspan="3"><%= rsOrderInfo.getString("ordRcvAddress1") %></td>
  <th>전화번호</th><td><%= rsOrderInfo.getString("orderTel") %></td>
</tr>
            <tr>
              <th>상세주소</th><td colspan="3"><%= rsOrderInfo.getString("ordRcvAddress2") %></td>
              <th>이메일</th><td colspan="3"><%= rsOrderInfo.getString("orderEmail") != null ? rsOrderInfo.getString("orderEmail") : "없음" %></td>
            </tr>
            <tr>
              <th>결제 방식</th><td><%= rsOrderInfo.getString("ordPay") %></td>
          <th>총 주문금액</th>
<td><%= String.format("%,d", total) %>원</td>
              <th>업체 요청사항</th><td><%= rsOrderInfo.getString("orderCompanyask") %></td>
            </tr>
            <tr>
              <th>카드번호</th><td><%= rsOrderInfo.getString("ordCardNo") != null ? rsOrderInfo.getString("ordCardNo") : "없음" %></td>
              <th>유효기간</th><td><%= rsOrderInfo.getString("ordCardExpiry") != null ? rsOrderInfo.getString("ordCardExpiry") : "없음" %></td>
              <th>CVC</th><td ><%= rsOrderInfo.getString("ordCardPass") != null ? rsOrderInfo.getString("ordCardPass") : "없음" %></td>
            </tr>
<%
    java.sql.Timestamp orderDate = rsOrderInfo.getTimestamp("ordDate");
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String formattedOrderDate = orderDate != null ? sdf.format(orderDate) : "없음";
%>

<tr>
  <th>입금은행</th><td><%= rsOrderInfo.getString("ordBank") != null ? rsOrderInfo.getString("ordBank") : "없음" %></td>
  <th>계좌번호</th><td colspan="1"><%= rsOrderInfo.getString("ordBankNo") != null ? rsOrderInfo.getString("ordBankNo") : "없음" %></td>
  <th>주문날짜</th>
  <td colspan="1"><%= formattedOrderDate %></td>
</tr>
            <tr>
             <th>입금액</th>
<td><%= String.format("%,d", total) %>원</td>

              <th>예금주</th><td>김화자</td>
              <th>입금자명</th><td><%= rsOrderInfo.getString("ordBankName") != null ? rsOrderInfo.getString("ordBankName") : "없음" %></td>
            </tr>

            <tr>
              <th>문의내용</th><td colspan="5"><%= rsOrderInfo.getString("orderAsk") != null ? rsOrderInfo.getString("orderAsk") : "없음" %></td>
            </tr>
           
          </tbody>
        </table>
      </div>
    </div>

       <div class="tab-content" id="tab-history">
      <div class="section">
        <h4>| 배송정보</h4>
        <table>
          <tbody>
           
           <% 
          if (rsDeliveryLog.next()) {
        %>
            <form method="POST" action="update_status.jsp">
              <tr>
                <th>송장번호</th><td><input type="text" name="tracking_number" placeholder="송장번호"></td>
                <th>배송현황</th><td>
                 
                      <input type="hidden" name="ordNo" value="<%= ordNo %>">
                      <select name="status">
                          <option value="배송 준비 중" <%= "배송 준비 중".equals(status) ? "selected" : "" %>>배송 준비 중</option>
                          <option value="배송 시작" <%= "배송 시작".equals(status) ? "selected" : "" %>>배송 시작</option>
                          <option value="배송중" <%= "배송중".equals(status) ? "selected" : "" %>>배송중</option>
                          <option value="배송 완료" <%= "배송 완료".equals(status) ? "selected" : "" %>>배송 완료</option>
                      </select>
    
              </td>
                <th>위치</th><td><input type="text" name="location" placeholder="배송 위치 입력" required> &nbsp;<button type="submit">변경</button></td>
              </tr>
            </form>
            <tr>
              <th>송장번호</th><td><%= rsOrderInfo.getString("tracking_number") %></td>
              <th>배송현황</th><td ><%= rsOrderInfo.getString("status") %></td>
           <th>배송위치</th><td ><%= rsOrderInfo.getString("location") %></td>
            </tr>
           
            <tr>
         <th>배송비</th><td>3,000원</td>
              <th>배송 요청사항</th><td colspan="4"><%= rsOrderInfo.getString("orderSendask") != null ? rsOrderInfo.getString("orderSendask") : "없음" %></td>
            </tr>
            <% 
          } else {
        %>
        <tr>
          <td colspan="5">배송 정보가 없습니다.</td>
        </tr>
        <% 
          }
        %>
          </tbody>
        </table>
      </div>
    </div>


  </div>

  <%
} catch (Exception e) {
    e.printStackTrace();
} finally {
    try {
        if (rsProduct != null) rsProduct.close();
        if (rsCustom != null) rsCustom.close();
        if (rsOrderInfo != null) rsOrderInfo.close();
        if (pstmtProduct != null) pstmtProduct.close();
        if (pstmtCustom != null) pstmtCustom.close();
        if (pstmtOrderInfo != null) pstmtOrderInfo.close();
        if (con != null) con.close();
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
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
