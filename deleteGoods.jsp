<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>상품 삭제</title>
    <style>
        body {
            font-family: '맑은 고딕', sans-serif;
            margin: 30px;
        }
        h1 {
            text-align: center;
            color: blue;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        td {
            padding: 10px;
            text-align: left;
        }
        input[type="submit"], input[type="button"] {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="submit"]:hover, input[type="button"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <center>
    <h1>상품 삭제</h1>

    <%
        request.setCharacterEncoding("euc-kr");

        String prdNo = request.getParameter("prdNo");
        if (prdNo == null || prdNo.trim().isEmpty()) {
            out.println("상품 번호가 잘못되었습니다.");
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
                out.println("<h3>상품이 성공적으로 삭제되었습니다.</h3>");
                out.println("<a href='selectAllGoods.jsp'>전체 상품 조회</a>");
            } else {
                out.println("<h3>상품 삭제에 실패했습니다. 다시 시도해 주세요.</h3>");
                out.println("<a href='selectAllGoods.jsp'>상품 목록으로 돌아가기</a>");
            }
        } catch (Exception e) {
            out.println("에러: " + e);
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                out.println("DB 연결 종료 에러: " + e);
            }
        }
    %>
    </center>
</body>
</html>
