<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>상품 삭제 결과</title>
    <style>
        body {
            font-family: '맑은 고딕', sans-serif;
            margin: 30px;
        }
        h1 {
            text-align: center;
            color: blue;
        }
        .message {
            text-align: center;
            font-size: 20px;
            margin-top: 20px;
        }
        input[type="button"] {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="button"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<%
    request.setCharacterEncoding("euc-kr");

    String prdNo = request.getParameter("prdNo");
    if (prdNo == null || prdNo.trim().isEmpty()) {
        out.println("<h3>상품 번호가 잘못되었습니다.</h3>");
        return;
    }

    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";
    Connection con = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String jsql = "DELETE FROM product WHERE prdNo = ?";
        pstmt = con.prepareStatement(jsql);
        pstmt.setString(1, prdNo);

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
            <div class="message">
                <h3>상품이 성공적으로 삭제되었습니다.</h3>
                <input type="button" value="전체 상품 조회" onclick="location.href='selectAllGoods.jsp'">
            </div>
<%
        } else {
%>
            <div class="message">
                <h3>상품 삭제에 실패했습니다. 해당 상품을 찾을 수 없습니다.</h3>
                <input type="button" value="상품 목록으로 돌아가기" onclick="location.href='selectAllGoods.jsp'">
            </div>
<%
        }
    } catch (Exception e) {
        out.println("<h3>에러: " + e.getMessage() + "</h3>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            out.println("<h3>DB 연결 종료 에러: " + e.getMessage() + "</h3>");
        }
    }
%>

</body>
</html>
