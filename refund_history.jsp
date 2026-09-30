<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="euc-kr">
    <title>주문 목록</title>
    <style>
        @font-face {
            font-family: 'BookkMyungjo-Bd';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        body {
            font-family: 'BookkMyungjo-Bd', serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #222;
            font-size: 28px;
            margin-top: 30px;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            border-radius: 8px;
            font-size: 14px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
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
        }

        .detail-box {
            display: none;
            text-align: left;
            padding: 10px;
            background: #f9f9f9;
            border-top: 1px solid #ccc;
        }

        .toggle-button {
            padding: 6px 12px;
            font-size: 13px;
            cursor: pointer;
            border-radius: 4px;
            background-color: #4CAF50;
            color: white;
            border: none;
        }

        .toggle-button:hover {
            background-color: #45a049;
        }

        .product-box {
            border:1px solid #ccc;
            padding:5px;
            margin-bottom:3px;
            max-width:300px;
        }

        .product-box img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            vertical-align: middle;
        }
		a {
  text-decoration: none;
  color: #333; /* 원하는 색으로 바꾸세요 */
}

    </style>

    <script>
        function toggleDetails(id) {
            const detail = document.getElementById('detail-' + id);
            if (detail.style.display === 'none') {
                detail.style.display = 'block';
            } else {
                detail.style.display = 'none';
            }
        }
    </script>
</head>
<body>
<h2>환불 요청 목록</h2>
<%
    request.setCharacterEncoding("UTF-8");
    String id = (String) session.getAttribute("sid");
    if (id == null || !id.equals("manager")) {
        out.println("<script>alert('관리자만 접근할 수 있습니다.'); history.back();</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        String sql = "SELECT * FROM refund_request ORDER BY request_date DESC";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

%>
<table>
    <tr>
        <th>요청 ID</th>
        <th>주문번호</th>
        <th>회원ID</th>
        <th>금액</th>
        <th>상태</th>
        <th>요청일</th>
        <th>상세 보기</th>
        <th>상태 변경</th>
    </tr>
<%
    while (rs.next()) {
        int refundId = rs.getInt("refund_id");
        int ordNo = rs.getInt("ordNo");
%>
    <tr>
        <td><%= refundId %></td>
        <td><%= ordNo %></td>
        <td><%= rs.getString("memId") %></td>
        <td><%= rs.getInt("refund_amount") %>원</td>
        <td><%= rs.getString("refund_status") %></td>
      <%
    Timestamp ts = rs.getTimestamp("request_date");
    String formattedDate = (ts != null) ? sdf.format(ts) : "날짜 없음";
%>
<td><%= formattedDate %></td>

     <td>
  <a href="javascript:void(0);" class="toggle-link"
   onclick="window.open('refund_detail.jsp?refund_id=<%= refundId %>&ordNo=<%= ordNo %>', 
                       'refundDetail', 
                       'width=950,height=800,scrollbars=yes');">
    상세보기
</a>

</td>

        <td>
            <form action="refund_admin.jsp" method="post"  accept-charset="UTF-8">
                <input type="hidden" name="refund_id" value="<%= refundId %>">
                <input type="hidden" name="action" value="change_status">
                <select name="refund_status" required>
                    <option value="환불 요청">환불 요청</option>
                    <option value="환불 중">환불 중</option>
                    <option value="환불 완료">환불 완료</option>
                </select>
                <button type="submit">변경</button>
            </form>
        </td>
    </tr>
    <tr id="detail-<%= refundId %>" class="detail-box">
        <td colspan="8">
<%
        // 상품 조회
        PreparedStatement pstmtItem = conn.prepareStatement(
            "SELECT ri.quantity, p.prdName, p.prdImg, m.color, m.size " +
            "FROM refund_item ri " +
            "JOIN product p ON ri.prdNo = p.prdNo " +
            "LEFT JOIN orderproduct op ON op.prdNo = ri.prdNo AND op.ordNo = ? " +
            "LEFT JOIN mapping_id m ON CAST(op.mapping_id AS UNSIGNED) = m.mappingId " +
            "WHERE ri.refund_id = ? AND ri.prdNo IS NOT NULL"
        );
        pstmtItem.setInt(1, ordNo);
        pstmtItem.setInt(2, refundId);
        ResultSet rsItem = pstmtItem.executeQuery();

        while (rsItem.next()) {
%>
        <div class="product-box">
            <img src="<%= rsItem.getString("prdImg") %>">
            <strong><%= rsItem.getString("prdName") %></strong>
            <span> / 수량: <%= rsItem.getInt("quantity") %>개</span><br/>
            <small>색상: <%= rsItem.getString("color") %>, 사이즈: <%= rsItem.getString("size") %></small>
        </div>
<%
        }
        rsItem.close(); pstmtItem.close();

        // 커스텀 상품
        PreparedStatement pstmtCus = conn.prepareStatement(
            "SELECT ri.quantity, c.cusName, c.cusimg, c.top_note, c.middle_note, c.base_note, c.volume, c.box_color " +
            "FROM refund_item ri JOIN custom c ON ri.custom_prdNo = c.cusNo " +
            "WHERE ri.refund_id = ? AND ri.custom_prdNo IS NOT NULL"
        );
        pstmtCus.setInt(1, refundId);
        ResultSet rsCus = pstmtCus.executeQuery();

        while (rsCus.next()) {
%>
        <div class="product-box">
            <img src="<%= rsCus.getString("cusimg") %>">
            <strong><%= rsCus.getString("cusName") %> (커스텀)</strong>
            <span> / 수량: <%= rsCus.getInt("quantity") %>개</span><br/>
            <small>노트: <%= rsCus.getString("top_note") %> / <%= rsCus.getString("middle_note") %> / <%= rsCus.getString("base_note") %></small><br/>
            <small>용량: <%= rsCus.getString("volume") %>, 박스 색상: <%= rsCus.getString("box_color") %></small>
        </div>
<%
        }
        rsCus.close(); pstmtCus.close();

        // 주소 조회
        PreparedStatement pstmtAddr = conn.prepareStatement("SELECT ordRcvAddress1, ordRcvAddress2 FROM orderinfo WHERE ordNo = ?");
        pstmtAddr.setInt(1, ordNo);
        ResultSet rsAddr = pstmtAddr.executeQuery();
        if (rsAddr.next()) {
%>
        <div style="margin-top:10px;">
            <strong>배송지 주소:</strong> <%= rsAddr.getString("ordRcvAddress1") %><br/>
            <strong>상세 주소:</strong> <%= rsAddr.getString("ordRcvAddress2") %>
        </div>
<%
        }
        rsAddr.close(); pstmtAddr.close();
%>
        </td>
    </tr>
<%
    } // end while
%>
</table>
<%
    } catch(Exception e) {
        out.println("오류 발생: " + e.getMessage());
    } finally {
        try { if (rs != null) rs.close(); } catch(SQLException e) {}
        try { if (pstmt != null) pstmt.close(); } catch(SQLException e) {}
        try { if (conn != null) conn.close(); } catch(SQLException e) {}
    }
%>
</body>
</html>
