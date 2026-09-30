<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
request.setCharacterEncoding("euc-kr");
String id = (String) session.getAttribute("sid");
if (id == null || !id.equals("manager")) {
    out.println("<script>alert('관리자만 접근할 수 있습니다.'); history.back();</script>");
    return;
}
%>
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
        h3 {
            margin-left: 175px;
        }
        table {
            width: 80%;
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
            font-weight: bold;
        }
        td {
            background-color: #fafafa;
        }
        tr:hover td {
            background-color: #f0f0f0;
        }
        img {
            width: 80px;
            height: 80px;
            object-fit: cover;
        }
        a {
            text-decoration: none;
            color: #333;
            transition: color 0.2s;
        }
        a:hover {
            color: #000;
        }
        form {
            display: inline;
        }
        select, button {
            padding: 6px 12px;
            font-size: 14px;
            margin-top: 5px;
            cursor: pointer;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
        }
        button:hover {
            background-color: #45a049;
        }
        .no-data {
            text-align: center;
            color: #f44336;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <h2>주문 목록</h2>

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

    String sql = "SELECT ordNo, memId, total, status, ordDate " +
                 "FROM orderinfo " +
                 "WHERE (isCanceled IS NULL OR isCanceled != 'Y') " +
                 "ORDER BY ordNo DESC";

    pstmt = con.prepareStatement(sql);
    rs = pstmt.executeQuery();

    boolean hasData = false;
%>
<table>
    <tr>
        <th>주문번호</th>
        <th>회원 ID</th>
        <th>상품 요약</th>
        <th>총 결제 금액</th>
        <th>배송 상태</th>
        <th>주문일자</th>
        <th>상세보기</th>
    </tr>

<%
    while (rs.next()) {
        hasData = true;
        int ordNo = rs.getInt("ordNo");
        String memId = rs.getString("memId");
        double total = rs.getDouble("total");
        String status = rs.getString("status") != null ? rs.getString("status") : "배송 준비 중";

        Timestamp ordDate = rs.getTimestamp("ordDate");
        String formattedOrdDate = "";
        if (ordDate != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            formattedOrdDate = sdf.format(ordDate);
        }

        // 상품 정보 요약
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
    <tr>
        <td><%= ordNo %></td>
        <td><%= memId %></td>
        <td><%= mainProduct %></td>
        <td><%= String.format("%,.0f", total) %> 원</td>
        <td><%= status %></td>
        <td><%= formattedOrdDate %></td>
        <td>
            <a href="#" onclick="window.open('order_detail.jsp?ordNo=<%= ordNo %>', 'popup', 'width=950,height=650,scrollbars=yes'); return false;">상세보기</a>
        </td>
    </tr>
<%
    }
%>
</table>
<%
    if (!hasData) {
%>
    <p class="no-data">주문이 없습니다.</p>
<%
    }
} catch (Exception e) {
    out.println("<p class='no-data'>오류 발생: " + e.getMessage() + "</p>");
    e.printStackTrace();
} finally {
    try {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (con != null) con.close();
    } catch (SQLException ignored) {}
}
%>
</body>
</html>
