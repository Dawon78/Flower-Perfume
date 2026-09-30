<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 처리</title>
    <script>
        function showAlertAndRedirect() {
            alert("주문이 성공적으로 처리되었습니다!");
            window.location.href = "mypage_order_history.jsp";
        }
    </script>
	<style>
.bank-info-wrapper {
    max-width: 600px;
    margin: 80px auto;
    padding: 60px 50px;
    border: 1px solid #ddd;
    background-color: #f9f9f9;
    text-align: center;
    font-family: 'Malgun Gothic', sans-serif;
    font-size: 20px;
}

.bank-info-wrapper h2 {
    font-size: 32px;
    margin-bottom: 20px;
}

.bank-info-wrapper .subtitle {
    color: #555;
    font-size: 18px;
    margin-bottom: 40px;
    line-height: 1.8;
}

.bank-details-box {
    background: white;
    padding: 40px;
    text-align: left;
    border: 1px solid #ccc;
    font-size: 18px;
    line-height: 1.6;
}

.bank-details-box h3 {
    font-size: 24px;
    margin-bottom: 20px;
}

.bank-details-box p {
    margin: 12px 0;
}

.bank-details-box p strong {
    font-weight: bold;
}

.bank-buttons {
    margin-top: 50px;
    text-align: center;
}

.bank-buttons button {
    padding: 16px 40px;
    border: none;
    margin: 0 10px;
    cursor: pointer;
    font-size: 18px;
    border-radius: 5px;
    transition: all 0.3s ease;
}

.bank-buttons .btn-dark {
    background: #333;
    color: white;
}

.bank-buttons .btn-dark:hover {
    background: #000;
}

.bank-buttons .btn-white {
    background: white;
    border: 1px solid #ccc;
    color: #333;
}

.bank-buttons .btn-white:hover {
    background: #f0f0f0;
}
</style>

</head>
<body>

<%
    request.setCharacterEncoding("euc-kr");
 
    String id = (String) session.getAttribute("sid");
    if (id == null || id.trim().isEmpty()) {
        out.println("<script>alert('로그인이 필요합니다.'); history.back();</script>");
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmt = null;
    ResultSet cartRs = null;
    ResultSet customCartRs = null;
    ResultSet generatedKeys = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        con.setAutoCommit(false);

        // ?? 수량 업데이트 처리 시작
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();

            if (paramName.startsWith("ctQty_")) {
                int ctNo = Integer.parseInt(paramName.substring(6));
                int newQty = Integer.parseInt(request.getParameter(paramName));
                pstmt = con.prepareStatement("UPDATE cart SET ctQty = ? WHERE ctNo = ?");
                pstmt.setInt(1, newQty);
                pstmt.setInt(2, ctNo);
                pstmt.executeUpdate();
            }

            if (paramName.startsWith("cusQty_")) {
                int ccNo = Integer.parseInt(paramName.substring(7));
                int newQty = Integer.parseInt(request.getParameter(paramName));
                pstmt = con.prepareStatement("UPDATE custom_cart SET cusQty = ? WHERE ccNo = ?");
                pstmt.setInt(1, newQty);
                pstmt.setInt(2, ccNo);
                pstmt.executeUpdate();
            }
        }
        // ?? 수량 업데이트 처리 끝

        // 주문 정보 파라미터 받기
        String ordSender = request.getParameter("ordSender");
        String orderReceiver = request.getParameter("orderReceiver");
        String ordRcvAddress1 = request.getParameter("ordRcvAddress1");
        String ordRcvAddress2 = request.getParameter("ordRcvAddress2");
        String orderTel = request.getParameter("orderTel");
        String orderEmail = request.getParameter("orderEmail");
        String orderSendask = request.getParameter("orderSendask");
        String orderCompanyask = request.getParameter("orderCompanyask");
        String orderAsk = request.getParameter("orderAsk");
        String ordPay = request.getParameter("ordPay");
        String ordBank = request.getParameter("ordBank");
        String ordBankName = request.getParameter("ordBankName");
        String ordCardNo = request.getParameter("ordCardNo");
        String ordCardPass = request.getParameter("ordCardPass");
        String totalStr = request.getParameter("total");
		String ordCardExpiry = request.getParameter("ordCardExpiry");     
		String ordBankNo = request.getParameter("ordBankNo");             
		String ordBankPay = request.getParameter("ordBankPay");           
		String ordBankHolder = request.getParameter("ordBankHolder");
		String ordCardName = request.getParameter("ordCardName");   

        double total = 0;
        if (totalStr != null && !totalStr.trim().isEmpty()) {
            try {
                total = Double.parseDouble(totalStr);
            } catch (NumberFormatException e) {
                total = 0;
            }
        }

		 if (total <= 0) {
            out.println("<script>alert('장바구니에 상품이 없습니다.'); history.back();</script>");
            return;
        }

        // 주문 정보 저장
       String insertOrderSql = "INSERT INTO orderinfo (" +
    "memId, ordSender, orderReceiver, ordRcvAddress1, ordRcvAddress2, " +
    "orderTel, orderEmail, orderSendask, orderCompanyask, orderAsk, " +
    "ordPay, ordBank, ordBankName, ordCardNo, ordCardPass, " +
    "ordCardExpiry, ordBankNo, ordBankPay, ordBankHolder, ordCardName, " +
    "total, ordDate" +
    ") VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

pstmt = con.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
pstmt.setString(1, id);
pstmt.setString(2, ordSender);
pstmt.setString(3, orderReceiver);
pstmt.setString(4, ordRcvAddress1);
pstmt.setString(5, ordRcvAddress2);
pstmt.setString(6, orderTel);
pstmt.setString(7, orderEmail);
pstmt.setString(8, orderSendask);
pstmt.setString(9, orderCompanyask);
pstmt.setString(10, orderAsk);
pstmt.setString(11, ordPay);
pstmt.setString(12, ordBank);
pstmt.setString(13, ordBankName);
pstmt.setString(14, ordCardNo);
pstmt.setString(15, ordCardPass);
pstmt.setString(16, ordCardExpiry);     
pstmt.setString(17, ordBankNo);         
pstmt.setString(18, ordBankPay);
pstmt.setString(19, ordBankHolder);
pstmt.setString(20, ordCardName);
pstmt.setDouble(21, total);


        int orderResult = pstmt.executeUpdate();

        if (orderResult > 0) {
            generatedKeys = pstmt.getGeneratedKeys();
            if (generatedKeys.next()) {
                int ordNo = generatedKeys.getInt(1);

                // 장바구니 상품 정보 저장
                String cartSql = "SELECT c.ctNo, c.prdNo, c.ctQty, p.prdImg, c.mapping_id FROM cart c JOIN product p ON c.prdNo = p.prdNo WHERE c.memId = ?";
                pstmt = con.prepareStatement(cartSql);
                pstmt.setString(1, id);
                cartRs = pstmt.executeQuery();

                while (cartRs.next()) {
                    int ctNo = cartRs.getInt("ctNo");
                    int prdNo = cartRs.getInt("prdNo");
                    int ctQty = cartRs.getInt("ctQty");
                    String prdImg = cartRs.getString("prdImg");
                    String mappingId = cartRs.getString("mapping_id");

                    String insertOrderProductSql = "INSERT INTO orderproduct (ordNo, memId, ctNo, prdNo, ctQty, prdImg, mapping_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
                    pstmt = con.prepareStatement(insertOrderProductSql);
                    pstmt.setInt(1, ordNo);
                    pstmt.setString(2, id);
                    pstmt.setInt(3, ctNo);
                    pstmt.setInt(4, prdNo);
                    pstmt.setInt(5, ctQty);
                    pstmt.setString(6, prdImg);
                    pstmt.setString(7, mappingId);
                    pstmt.executeUpdate();
                }

                // 커스텀 상품 정보 저장
                String customCartSql = "SELECT ccNo, cusNo, cusQty FROM custom_cart";
                pstmt = con.prepareStatement(customCartSql);
                customCartRs = pstmt.executeQuery();

                while (customCartRs.next()) {
                    int cusNo = customCartRs.getInt("cusNo");
                    int cusQty = customCartRs.getInt("cusQty");

                    String insertCustomProductSql = "INSERT INTO custom_product (ordNo, memId, cusNo, cusQty) VALUES (?, ?, ?, ?)";
                    pstmt = con.prepareStatement(insertCustomProductSql);
                    pstmt.setInt(1, ordNo);
                    pstmt.setString(2, id);
                    pstmt.setInt(3, cusNo);
                    pstmt.setInt(4, cusQty);
                    pstmt.executeUpdate();
                }

                // 장바구니 비우기
                pstmt = con.prepareStatement("DELETE FROM cart WHERE memId = ?");
                pstmt.setString(1, id);
                pstmt.executeUpdate();

                pstmt = con.prepareStatement("DELETE FROM custom_cart WHERE memId = ?");
                pstmt.setString(1, id);
                pstmt.executeUpdate();

                con.commit();


				java.text.DecimalFormat df = new java.text.DecimalFormat("#,###");
    String formattedTotal = df.format(total);

if ("bank".equals(ordPay)) {
	String bankName = "국민은행";
    String bankNo = "60519014678208";
    String bankHolder = "김화자";
%>
   <div class="bank-info-wrapper">
    <h2>구매완료</h2>
    <p class="subtitle">
        아래 가상계좌로 입금해 주시면 정상적으로<br>
        결제 완료처리가 됩니다
    </p>

    <div class="bank-details-box">
        <h3>가상계좌 정보</h3>
        <p> <%= bankName %> <%= bankNo %></p>
        <p> 예금주: <%= bankHolder %></p>
        <p>입금 금액: <%= formattedTotal %>원</p>
        <p>입금 기한: <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date(System.currentTimeMillis() + 1000 * 60 * 60 )) %> 24시 까지</p>
    </div>

    <div class="bank-buttons">
        <button class="btn-dark" onclick="location.href='mypage_order_history.jsp'">구매내역</button>
     
    </div>
</div>

<%
} else {
    out.println("<script>showAlertAndRedirect();</script>");
}

            }
        } else {
            con.rollback();
            out.println("<p style='color: red;'>주문 실패, 롤백됨</p>");
        }

    } catch (SQLException e) {
        out.println("<p style='color: red;'>SQLException 발생: " + e.getMessage() + "</p>");
        try { if (con != null) con.rollback(); } catch (SQLException ignored) {}
    } finally {
        try {
            if (generatedKeys != null) generatedKeys.close();
            if (cartRs != null) cartRs.close();
            if (customCartRs != null) customCartRs.close();
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException ignored) {}
    }
%>



</body>
</html>
