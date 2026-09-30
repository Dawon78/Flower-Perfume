<%@ page contentType="text/html;charset=euc-kr" import="java.sql.*" %>

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
        color: #222;
        font-size: 28px;
        margin-top: 30px;
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
        color: #111;
    }

    td {
        background-color: #fafafa;
    }

    tr:hover td {
        background-color: #f0f0f0;
    }

    .btn-container {
        text-align: center;
        margin-top: 40px;
        margin-bottom: 40px;
    }

    .btn-container a {
        padding: 10px 20px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 5px;
        text-align: center;
        font-size: 16px;
        cursor: pointer;
        text-decoration: none;
        transition: background-color 0.3s ease;
    }

    .btn-container a:hover {
        background-color: #555;
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

<div class="container">
  <h1>회원 관리</h1>

  <table>
    <thead>
      <tr>
        <th>아이디</th>
        <th>닉네임</th>
        <th>이름</th>
        <th>이메일</th>
        <th>전화번호</th>
        <th>성별</th>
        <th>생년월일</th>
        <th>주소</th>
        <th>탈퇴</th> <!-- 삭제 버튼 열 추가 -->
      </tr>
    </thead>
    <tbody>
      <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
          Class.forName("org.gjt.mm.mysql.Driver");
          conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/flower?useSSL=false&serverTimezone=UTC", 
            "multi", 
            "abcd"
          );

          String sql = "SELECT * FROM member";
          pstmt = conn.prepareStatement(sql);
          rs = pstmt.executeQuery();

          while (rs.next()) {
            String memId = rs.getString("memId");
            String memNick = rs.getString("memNick");
            String memName = rs.getString("memName");
            String memEmail = rs.getString("memEmail");
            String memPhone = rs.getString("memPhone");
            String memSex = rs.getString("memSex");
            int membirthYear = rs.getInt("membirthYear");
            int membirthMonth = rs.getInt("membirthMonth");
            int membirthDay = rs.getInt("membirthDay");
            String memAddress1 = rs.getString("memAddress1");
            String memAddress2 = rs.getString("memAddress2");

            String birth = membirthYear + "-" + String.format("%02d", membirthMonth) + "-" + String.format("%02d", membirthDay);
            String address = (memAddress1 != null ? memAddress1 : "") + " " + (memAddress2 != null ? memAddress2 : "");
      %>
          <tr>
            <td><%=memId%></td>
            <td><%=memNick%></td>
            <td><%=memName%></td>
            <td><%=memEmail%></td>
            <td><%=memPhone%></td>
            <td><%=memSex%></td>
            <td><%=birth%></td>
            <td><%=address.trim()%></td>
            <td>
              <!-- 삭제 버튼 추가 -->
              <a href="manager_deletemember.jsp?memId=<%=memId%>" class="delete-btn" onclick="return confirm('정말로 이 회원을 탈퇴시키겠습니까?');">탈퇴</a>
            </td>
          </tr>
      <%
          }
        } catch (Exception e) {
          out.println("<tr><td colspan='9'>DB 연결 오류: " + e.getMessage() + "</td></tr>");
        } finally {
          if (rs != null) rs.close();
          if (pstmt != null) pstmt.close();
          if (conn != null) conn.close();
        }
      %>
    </tbody>
  </table>
</div>
