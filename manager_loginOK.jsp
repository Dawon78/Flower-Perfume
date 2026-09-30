<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=euc-kr">
    <title>로그인 처리 / 판별</title>
    <style type="text/css">
        a:link { text-decoration: none; color: black; }
        a:visited { text-decoration: none; color: black; }
        a:hover { text-decoration: underline; color: blue; }
    </style>
    <script type="text/javascript">
        function showLoginError(message) {
            alert(message);
            window.location.href = "manager_login.jsp";  
        }
    </script>
</head>

<body bgcolor="white" text="black" link="blue" vlink="purple" alink="red">
<%

    String DB_URL = "jdbc:mysql://localhost:3306/flower"; 
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Class.forName("org.gjt.mm.mysql.Driver");
    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    String id = request.getParameter("id");
    String pass = request.getParameter("pass");

    String jsql = "SELECT * FROM manager WHERE managerId = ?";
    PreparedStatement pstmt = con.prepareStatement(jsql);
    pstmt.setString(1, id);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) { 
        if (pass.equals(rs.getString("managerPasswd"))) {  
            session.setAttribute("sid", id);  
            response.sendRedirect("manager_index.jsp"); 
        } else { 
%>
            <script type="text/javascript">
                showLoginError("비밀번호가 잘못 되었습니다. 다시 확인해 주세요!"); 
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
%>
</body>
</html>