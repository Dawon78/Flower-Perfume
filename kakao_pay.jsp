<%@ page import="java.io.*, java.net.*, org.json.*" %>
<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay</title>
   
</head>
<%
  request.setCharacterEncoding("euc-kr");
  String ordSender=request.getParameter("ordSender");
  String orderReceiver=request.getParameter("orderReceiver");
  String ordRcvAddress1=request.getParameter("ordRcvAddress1");
  String ordRcvAddress2=request.getParameter("ordRcvAddress2");
  String orderTel=request.getParameter("orderTel");
  String orderEmail=request.getParameter("orderEmail");
  String orderSendask=request.getParameter("orderSendask");
  String orderCompanyask=request.getParameter("orderCompanyask");
  if(orderCompanyask==null){
    orderCompanyask="없음";
  }
  String orderAsk=request.getParameter("orderAsk");
   if(orderAsk==null){
    orderAsk="없음";
  }

String product_qty_price=ordSender+","+orderReceiver+","+ordRcvAddress1+","+ordRcvAddress2+","+orderTel+","+orderEmail+","+orderSendask+","+orderCompanyask+","+orderAsk;
 
 
              // DB 연결 정보
              String DB_URL = "jdbc:mysql://localhost:3306/flower";
              String DB_ID = "multi";
              String DB_PASSWORD = "abcd";
              Class.forName("org.gjt.mm.mysql.Driver");
              Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

      int total_price=0;
          String id = (String) session.getAttribute("sid");
           ResultSet rs=null;
             PreparedStatement pstmt=null;

                 ResultSet prdrs=null;
             PreparedStatement prdpstmt=null;
String proList="";
String qtyList="";
  String productList="";
              try {
                  // 장바구니에 담긴 상품들과 상품명, 가격을 조회하는 쿼리
                  String sql = "SELECT c.ctNo, c.prdNo, c.ctQty, c.prdImg, c.mapping_id, m.color, m.size, p.prdName, p.prdPrice " +
                               "FROM cart c " +
                               "JOIN mapping_id m ON c.mapping_id = m.mappingId " +
                               "JOIN product p ON c.prdNo = p.prdNo " +
                               "WHERE c.memId = ?";
               pstmt = con.prepareStatement(sql);
                  pstmt.setString(1, id);
                 rs = pstmt.executeQuery();
                  
      int count=0;
               
      if (rs.next()) { 
                   do {
                    String prdImg = rs.getString("prdImg");
                    String prdNo = rs.getString("prdNo");
                    String prdName = rs.getString("prdName"); 
                    int prdPrice = rs.getInt("prdPrice");
                    int ctQty = rs.getInt("ctQty");
                    String color = rs.getString("color");
                    String size = rs.getString("size");
                    int ctNo = rs.getInt("ctNo");
					proList+=prdName+",";
				qtyList+=ctQty+",";
                  double itemTotalPrice = prdPrice * ctQty;
                    total_price += itemTotalPrice;

                    count++;
                      } while (rs.next());
                      }

                      String proListArray[]=proList.split(",");
                      String qtyListArray[]=qtyList.split(",");
      
                productList = (count == 1) ? proListArray[0]
                              : proListArray[0] + " 외 " + (count - 1) + "건";

                  out.println(productList);
                  out.println(total_price);

                  
      }
     
      finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
          if (prdrs != null) try { prdrs.close(); } catch (SQLException e) {}
        if (prdpstmt != null) try { prdpstmt.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
      }
             


  String apiUrl = "https://kapi.kakao.com/v1/payment/ready";
  String adminKey = "3c8f506a1e5eafde8da88c144a635b71"; // ?뼱?뱶誘쇰?? ?궎

  
  
  session.setAttribute("item_description", product_qty_price);

  String approvalUrl = "http://localhost:8081/Flower/kakao_success.jsp";
  String failUrl = "http://localhost:8081/Flower/kakao_fail.jsp";
  String cancelUrl = "http://localhost:8081/Flower/kakao_cancel.jsp";

  String params = "cid=TC0ONETIME" + 
                  "&partner_order_id=1001" + 
                  "&partner_user_id=testuser" + 
                  "&item_name=" + URLEncoder.encode(productList, "UTF-8") +  
                  "&item_description=" + URLEncoder.encode(product_qty_price, "UTF-8") + 
                  "&quantity=1" + 
                  "&total_amount="+total_price + 
                  "&vat_amount=100" + 
                  "&tax_free_amount=0" + 
                  "&approval_url=" + URLEncoder.encode(approvalUrl, "UTF-8") + 
                  "&fail_url=" + URLEncoder.encode(failUrl, "UTF-8") + 
                  "&cancel_url=" + URLEncoder.encode(cancelUrl, "UTF-8");

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

    

      try {
          JSONObject jsonResponse = new JSONObject(responseBody.toString());
          String redirectUrl = jsonResponse.getString("next_redirect_pc_url");
          String tid = jsonResponse.getString("tid");

          session.setAttribute("tid", tid);

          out.println("<script type='text/javascript'>window.location.href = '" + redirectUrl + "';</script>");
      } catch (JSONException e) {
          out.println("<h2>카카오페이 응답 처리 오류</h2>");
          out.println("<p>응답 데이터를 파싱하는 중 오류가 발생했습니다.</p>");
          out.println("<pre>" + e.getMessage() + "</pre>");
      }
  } else {
      BufferedReader br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
      StringBuilder errorBody = new StringBuilder();
      String line;
      while ((line = br.readLine()) != null) {
          errorBody.append(line);
      }
      br.close();
      out.println("<h2>카카오페이 응답 처리 오류</h2>");
      out.println("<p>응답 코드: " + responseCode + "</p>");
      out.println("<p>에러 메시지: " + errorBody.toString() + "</p>");
  }
%>
              
</body>
</html>
