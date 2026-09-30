<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=euc-kr">
    <title>로그인 처리</title>

    <script type="text/javascript">
        function showLoginError(message) {
            alert(message);
            window.location.href = "login.jsp";  
        }
    </script>
</head>

<body>
<%
    request.setCharacterEncoding("euc-kr");

    String DB_URL = "jdbc:mysql://localhost:3306/flower"; 
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    String memId = request.getParameter("memId");
    String memPasswd = request.getParameter("memPasswd");

    if (memId == null || memPasswd == null || memId.trim().isEmpty() || memPasswd.trim().isEmpty()) {
%>
        <script type="text/javascript">
            showLoginError("아이디와 비밀번호를 입력해 주세요.");
        </script>
<%
    } else {
        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            String sql = "SELECT memPasswd FROM member WHERE memId = ?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, memId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                if (memPasswd.equals(rs.getString("memPasswd"))) {  
                    session.setAttribute("sid", memId);  
                    response.sendRedirect("index.jsp"); 
                } else { 
%>
                    <script type="text/javascript">
                        showLoginError("비밀번호가 잘못되었습니다. 다시 확인해 주세요!");
                    </script>
<%
                }
            } else { 
%>
                <script type="text/javascript">
                    showLoginError("아이디가 존재하지 않습니다. 다시 확인해 주세요!");
                </script>
<%
            }

            rs.close();
            pstmt.close();
            con.close();
        } catch (SQLException e) {
%>
            <script type="text/javascript">
                showLoginError("데이터베이스 오류가 발생했습니다.");
            </script>
<%
        }
    }
%>
</body>
</html>
