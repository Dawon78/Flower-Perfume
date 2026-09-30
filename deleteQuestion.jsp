<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    String questionNo = request.getParameter("questionNo");

    if (questionNo == null || questionNo.trim().isEmpty()) {
%>
    <script>
        alert("잘못된 접근입니다.");
        history.back();
    </script>
<%
        return;
    }

    String url = "jdbc:mysql://localhost:3306/flower";
    String user = "multi";
    String password = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(url, user, password);

        String sql = "DELETE FROM question WHERE questionNo = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(questionNo));

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
    <script>
        alert("문의가 삭제되었습니다.");
        location.href = "manager_index.jsp";
    </script>
<%
        } else {
%>
    <script>
        alert("삭제에 실패했습니다.");
        history.back();
    </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("오류 발생: <%= e.getMessage() %>");
        history.back();
    </script>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
