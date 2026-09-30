<%@ page contentType="text/html;charset=euc-kr" import="java.sql.*" %>

<%
    String memId = request.getParameter("memId");

    if (memId == null || memId.isEmpty()) {
        response.sendRedirect("manager_index.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/flower?useSSL=false&serverTimezone=UTC", 
            "multi", 
            "abcd"
        );

        // 회원 삭제 SQL 쿼리
        String sql = "DELETE FROM member WHERE memId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, memId);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
%>
            <script>
                alert("회원 탈퇴가 완료되었습니다.");
                window.location.href = "manager_index.jsp";  // manager_index.jsp로 리다이렉트
            </script>
<%
        } else {
%>
            <script>
                alert("회원 탈퇴에 실패했습니다.");
                window.history.back();  // 이전 페이지로 돌아가기
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("manager_index.jsp?message=오류가 발생했습니다.");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
