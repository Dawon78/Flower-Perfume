<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>

<%@ page import="java.sql.*" %>

<html>
<head>
    <title>문의 관리</title>
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
            background-color: white;
            border-radius: 8px;
            font-size: 14px;
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

    a {
        color: black;
        text-decoration: none;  /* 밑줄 없애기 */
    }

	    a:hover {
        text-decoration: underline;
    }



    </style>
</head>
<body>

    <h1>문의 관리</h1>

    <table>
        <tr>
            <th>번호</th>
			<th>문의 시간</th>  <!-- 추가 -->

            <th>이름</th>
            <th>닉네임</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>제품 카테고리</th>
            <th>제품명</th>
            <th>문의 내용</th>
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

                String sql = "SELECT * FROM question ORDER BY questionNo DESC";
                rs = stmt.executeQuery(sql);

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("questionNo") %></td>
			<%
    java.sql.Timestamp questionDate = rs.getTimestamp("questionDate");
    String formattedDate = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm").format(questionDate);
%>
<td><%= formattedDate %></td>

            <td><%= rs.getString("memName") %></td>
            <td><%= rs.getString("memNick") %></td>
            <td><%= rs.getString("memPhone") %></td>
            <td><%= rs.getString("memEmail") %></td>
            <td><%= rs.getString("prdCategory") %></td>
            <td><%= rs.getString("prdName") %></td>
            <td><%= rs.getString("questionText") %></td>
            <td>
                <a href="deleteQuestion.jsp?questionNo=<%= rs.getInt("questionNo") %>" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
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
