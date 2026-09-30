<%@ page import="java.io., java.net., org.json." %>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.sql., javax.servlet.http." %>
<%@ page import="java.io." %>
<%@ page import="java.io.File" %>

<%
request.setCharacterEncoding("UTF-8");

String apiUrl = "https://kapi.kakao.com/v1/payment/approve";
String adminKey = "3c8f506a1e5eafde8da88c144a635b71";

String tid = (String) session.getAttribute("tid");

String itemDescription=null;
String itemName=null;
if (tid == null) {
out.println("<h2>결제 실패</h2>");
out.println("<p>tid 값이 없습니다.</p>");
return;
}

String pgToken = request.getParameter("pg_token");
if (pgToken == null || pgToken.isEmpty()) {
out.println("<h2>결제 실패</h2>");
out.println("<p>pg_token 값이 없습니다.</p>");
return;
}

String params = "cid=TC0ONETIME" +
"&tid=" + tid +
"&partner_order_id=1001" +
"&partner_user_id=testuser" +
"&pg_token=" + pgToken;

URL url = new URL(apiUrl);
HttpURLConnection conn = (HttpURLConnection) url.openConnection();
conn.setRequestMethod("POST");
conn.setRequestProperty("Authorization", "KakaoAK " + adminKey);
conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded;charset=UTF-8");
conn.setDoOutput(true);

OutputStreamWriter writer = new OutputStreamWriter(conn.getOutputStream());
writer.write(params);
writer.flush();
writer.close();

int responseCode = conn.getResponseCode();
if (responseCode == 200) {
BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
StringBuilder responseBody = new StringBuilder();
String line;
while ((line = br.readLine()) != null) {
responseBody.append(line);
}
br.close();

  out.println("<h3>응답 내용:</h3>");
  out.println("<pre>" + responseBody.toString() + "</pre>");

  try {
      JSONObject jsonResponse = new JSONObject(responseBody.toString());

      itemDescription = (String) session.getAttribute("item_description");
      out.println(itemDescription);

      itemName = jsonResponse.optString("item_name", "알 수 없음");
      JSONObject amount = jsonResponse.getJSONObject("amount");
      int totalAmount = amount.getInt("total");

      // 승인 여부 확인
      String approvedAt = jsonResponse.optString("approved_at", null);
      if (approvedAt != null) {
          // 승인 확인된 경우에만 주문 처리
          String orderAddress[] = itemDescription.split(",");

          String ordSender      = (orderAddress.length > 0) ? orderAddress[0] : "";
          String orderReceiver  = (orderAddress.length > 1) ? orderAddress[1] : "";
          String ordRcvAddress1 = (orderAddress.length > 2) ? orderAddress[2] : "";
          String ordRcvAddress2 = (orderAddress.length > 3) ? orderAddress[3] : "";
          String orderTel       = (orderAddress.length > 4) ? orderAddress[4] : "";
          String orderEmail     = (orderAddress.length > 5) ? orderAddress[5] : "";
          String orderSendask   = (orderAddress.length > 6) ? orderAddress[6] : "";
          String orderCompanyask = (orderAddress.length > 7) ? orderAddress[7] : "";
          String orderAsk       = (orderAddress.length > 8) ? orderAddress[8] : "없음";

          String DB_URL = "jdbc:mysql://localhost:3306/flower";
          String DB_ID = "multi";
          String DB_PASSWORD = "abcd";
          Class.forName("org.gjt.mm.mysql.Driver");
          Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

          int total_price = 0;
          String id = (String) session.getAttribute("sid");
          ResultSet rs = null;
          PreparedStatement pstmt = null;
          ResultSet prdrs = null;
          String pay = "카카오페이 결제";

          try {
              String sql = "SELECT c.ctNo, c.prdNo, c.ctQty, c.prdImg, c.mapping_id, m.color, m.size, p.prdName, p.prdPrice " +
                           "FROM cart c " +
                           "JOIN mapping_id m ON c.mapping_id = m.mappingId " +
                           "JOIN product p ON c.prdNo = p.prdNo " +
                           "WHERE c.memId = ?";
              pstmt = con.prepareStatement(sql);
              pstmt.setString(1, id);
              rs = pstmt.executeQuery();

              if (rs.next()) {
                  do {
                      String prdImg = rs.getString("prdImg");
                      int prdNo = rs.getInt("prdNo");
                      String prdName = rs.getString("prdName");
                      int prdPrice = rs.getInt("prdPrice");
                      int ctQty = rs.getInt("ctQty");
                      String color = rs.getString("color");
                      String size = rs.getString("size");
                      int ctNo = rs.getInt("ctNo");
                      String mapping_id = rs.getString("mapping_id");

                      double itemTotalPrice = prdPrice * ctQty;
                      total_price += itemTotalPrice;

                      String payproductSql = "INSERT INTO orderproduct (prdNo, ctQty, prdImg, mapping_id, memId, ordNo) values(?,?,?,?,?,?)";
                      PreparedStatement payproductpstmt = con.prepareStatement(payproductSql);
                      payproductpstmt.setInt(1, prdNo);
                      payproductpstmt.setInt(2, ctQty);
                      payproductpstmt.setString(3, prdImg);
                      payproductpstmt.setString(4, mapping_id);
                      payproductpstmt.setString(5, id);
                      payproductpstmt.setInt(6, ctNo);
                      payproductpstmt.executeUpdate();
                  } while (rs.next());
              }

              String jsql = "INSERT INTO orderinfo (ordSender, orderReceiver, ordRcvAddress1, ordRcvAddress2, orderTel, orderEmail, orderSendask, orderCompanyask, orderAsk, ordPay, total, memId) ";
              jsql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
              PreparedStatement orderinfopstmt = con.prepareStatement(jsql);
              orderinfopstmt.setString(1, ordSender);
              orderinfopstmt.setString(2, orderReceiver);
              orderinfopstmt.setString(3, ordRcvAddress1);
              orderinfopstmt.setString(4, ordRcvAddress2);
              orderinfopstmt.setString(5, orderTel);
              orderinfopstmt.setString(6, orderEmail);
              orderinfopstmt.setString(7, orderSendask);
              orderinfopstmt.setString(8, orderCompanyask);
              orderinfopstmt.setString(9, orderAsk);
              orderinfopstmt.setString(10, pay);
              orderinfopstmt.setInt(11, total_price);
              orderinfopstmt.setString(12, id);
              orderinfopstmt.executeUpdate();

              String deleteCartSQL = "DELETE FROM cart WHERE memId = ?";
              PreparedStatement deleteCartPstmt = con.prepareStatement(deleteCartSQL);
              deleteCartPstmt.setString(1, id);
              deleteCartPstmt.executeUpdate();

          } finally {
              if (rs != null) try { rs.close(); } catch (SQLException e) {}
              if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
              if (con != null) try { con.close(); } catch (SQLException e) {}
          }

      } else {
          out.println("<h2>결제 승인 실패</h2>");
          out.println("<p>결제 상태: 승인되지 않음</p>");
          return;
      }
  } catch (JSONException e) {
      out.println("<h2>카카오페이 응답 처리 오류</h2>");
      out.println("<p>응답 데이터 파싱 중 오류가 발생했습니다.</p>");
      out.println("<pre>" + e.getMessage() + "</pre>");
      return;
  }

} else {
BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
StringBuilder errorBody = new StringBuilder();
String line;
while ((line = br.readLine()) != null) {
errorBody.append(line);
}
br.close();
out.println("<h2>카카오페이 결제 승인 요청 실패</h2>");
out.println("<p>응답 코드: " + responseCode + "</p>");
out.println("<p>에러 메시지: " + errorBody.toString() + "</p>");
return;
}
%>

<script> window.onload = function() { alert("결제가 완료되었습니다."); if (window.opener) { window.opener.location.href = "mypage_order_history.jsp"; window.close(); } else { window.location.href = "mypage_order_history.jsp"; } } </script> </body> </html>