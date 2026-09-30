<%@ page contentType="text/html;charset=EUC-KR" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <meta charset="EUC-KR">
    <title>회원가입 결과</title>
    <script>
        function showAlertAndRedirect() {
            alert("회원가입이 완료되었습니다.");
            window.location.href = "login.jsp";
        }
    </script>
</head>
<body onload="showAlertAndRedirect()">
<%
    request.setCharacterEncoding("EUC-KR");

    String memId = request.getParameter("memId");
    String memPasswd = request.getParameter("memPasswd");
    String memNick = request.getParameter("memNick");
    String memName = request.getParameter("memName");
    String memPhone = request.getParameter("phone-prefix") + "-" + request.getParameter("phone1") + "-" + request.getParameter("phone2");
    String memEmail = request.getParameter("memEmail");
    String memSex = request.getParameter("memSex");
    int membirthYear = Integer.parseInt(request.getParameter("membirthYear"));
    int membirthMonth = Integer.parseInt(request.getParameter("membirthMonth"));
    int membirthDay = Integer.parseInt(request.getParameter("membirthDay"));
    
    String memAddress1 = request.getParameter("memAddress1");
    String memAddress2 = request.getParameter("memAddress2");
    
    if (memAddress1 == null || memAddress1.trim().isEmpty()) {
        memAddress1 = null;
    }
    if (memAddress2 == null || memAddress2.trim().isEmpty()) {
        memAddress2 = null;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        String sql = "INSERT INTO member (memId, memPasswd, memNick, memName, memPhone, memEmail, memSex, membirthYear, membirthMonth, membirthDay, memAddress1, memAddress2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        pstmt = con.prepareStatement(sql);
        pstmt.setString(1, memId);
        pstmt.setString(2, memPasswd);
        pstmt.setString(3, memNick);
        pstmt.setString(4, memName);
        pstmt.setString(5, memPhone);
        pstmt.setString(6, memEmail);
        pstmt.setString(7, memSex);
        pstmt.setInt(8, membirthYear);
        pstmt.setInt(9, membirthMonth);
        pstmt.setInt(10, membirthDay);
        pstmt.setString(11, memAddress1);
        pstmt.setString(12, memAddress2);
        
        pstmt.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>
