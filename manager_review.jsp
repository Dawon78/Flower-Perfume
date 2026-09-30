<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>리뷰 관리</title>
    <style>
    @font-face {
        font-family: 'BookkMyungjo-Bd';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }
    body {
        font-family: 'BookkMyungjo-Bd', serif;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        color: black;
        font-size: 28px;
        margin-top: 30px;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        border-radius: 8px;
        font-size: 14px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }

    th, td {
        padding: 12px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
    }

    td {
        background-color: #fafafa;
    }

    .btn-container {
        text-align: center;
        margin-top: 40px;
        margin-bottom: 40px;
    }

    .btn-container a {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        text-align: center;
        font-size: 16px;
        cursor: pointer;
        text-decoration: none;
    }

    .btn-container a:hover {
        background-color: #45a049;
    }

    /* 기존 스타일을 유지하면서 버튼 스타일 수정 */
.delete-btn {
    background-color: transparent;  /* 배경을 투명하게 */
    color: black;  /* 글씨 색상 */
    border: none;  /* 테두리 없애기 */
    padding: 6px 12px;
    border-radius: 4px;
    cursor: pointer;
    font-family: 'BookkMyungjo-Bd', serif;
    font-size: 14px;
}

.delete-btn:hover {
    text-decoration: underline;  /* 호버 시 밑줄 추가 */
}


    </style>
</head>
<body>

    <h1>리뷰 관리</h1>

    <table>
        <tr>
            <th>리뷰 ID</th>
            <th>회원 ID</th>
            <th>상품 번호</th>
            <th>별점</th>
            <th>리뷰 날짜</th>
            <th>향수 지속력</th>
            <th>향기</th>
            <th>리뷰 내용</th>
            <th>삭제</th>
        </tr>

        <%
            String url = "jdbc:mysql://localhost:3306/flower";
            String user = "multi";
            String password = "abcd";

            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("org.gjt.mm.mysql.Driver");

                conn = DriverManager.getConnection(url, user, password);
                stmt = conn.createStatement();

                String sql = "SELECT * FROM review ORDER BY reviewDate DESC";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("reviewId") %></td>
            <td><%= rs.getString("memId") %></td>
            <td><%= rs.getInt("prdNo") %></td>
            <td><%= rs.getInt("star") %></td>
            <%
    java.sql.Timestamp reviewDate = rs.getTimestamp("reviewDate");
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
    String formattedReviewDate = sdf.format(reviewDate);
%>
<td><%= formattedReviewDate %></td>

            <td><%= rs.getString("longevity") %></td>
            <td><%= rs.getString("scent") %></td>
            <td><%= rs.getString("content") != null ? rs.getString("content") : "없음" %></td>
            <td>
                <form method="post" action="deleteReview.jsp" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                    <input type="hidden" name="reviewId" value="<%= rs.getInt("reviewId") %>">
                    <button type="submit" class="delete-btn">삭제</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (Exception e) {}
                if (stmt != null) try { stmt.close(); } catch (Exception e) {}
                if (conn != null) try { conn.close(); } catch (Exception e) {}
            }
        %>
    </table>

</body>
</html>
