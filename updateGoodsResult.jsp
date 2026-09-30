<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>상품 수정 결과</title>

</head>
<body>
<center>
<h1>상품 정보 수정 결과</h1>

<%
    request.setCharacterEncoding("euc-kr");

    String prdNo = request.getParameter("prdNo");
    String prdType = request.getParameter("prdType");
    String prdCategory = request.getParameter("prdCategory");
    String prdName = request.getParameter("prdName");
    String prdImg = request.getParameter("prdImg");
    String prdPriceStr = request.getParameter("prdPrice");
    String prdStockStr = request.getParameter("prdStock");
    String prdDate = request.getParameter("prdDate");
    String prdDescription = request.getParameter("prdDescription");

    int prdPrice = (prdPriceStr != null && !prdPriceStr.isEmpty()) ? Integer.parseInt(prdPriceStr) : 0;
    int prdStock = (prdStockStr != null && !prdStockStr.isEmpty()) ? Integer.parseInt(prdStockStr) : 0;

    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";
    Connection con = null;
    PreparedStatement pstmt = null;

    boolean success = false;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String jsql = "UPDATE product SET prdType=?, prdCategory=?, prdName=?, prdImg=?, prdPrice=?, prdStock=?, prdDate=?, prdDescription=? WHERE prdNo=?";
        pstmt = con.prepareStatement(jsql);

        pstmt.setString(1, prdType);
        pstmt.setString(2, prdCategory);
        pstmt.setString(3, prdName);
        pstmt.setString(4, prdImg);
        pstmt.setInt(5, prdPrice);
        pstmt.setInt(6, prdStock);
        pstmt.setString(7, prdDate);
        pstmt.setString(8, prdDescription);
        pstmt.setString(9, prdNo);

        int result = pstmt.executeUpdate();
        if (result > 0) {
            success = true;
        }
    } catch (Exception e) {
        out.println("<p>에러: " + e.getMessage() + "</p>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<p>DB 연결 종료 에러: " + e.getMessage() + "</p>");
        }
    }
%>

<% if (success) { %>
<script>
    alert("상품 정보가 성공적으로 수정되었습니다.");
    location.href = "manager_index.jsp";
</script>
<% } else { %>
<h3>상품 수정에 실패했습니다. 다시 시도해 주세요.</h3>
<a href="selectAllGoods.jsp?prdNo=<%= prdNo %>">수정 페이지로 돌아가기</a>
<% } %>

</center>
</body>
</html>
