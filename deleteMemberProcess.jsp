<%@ page contentType="text/html; charset=euc-kr" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("memId");

    if (id == null || id.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        // 회원 삭제 SQL 쿼리
        String sql = "DELETE FROM member WHERE memId = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);

        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // 삭제가 성공하면 로그아웃 후 팝업을 띄우고 login.jsp로 리다이렉트
            session.invalidate(); // 세션 종료
%>
            <script type="text/javascript">
                alert("회원 탈퇴가 완료되었습니다.");
                location.href = "login.jsp"; // 로그인 페이지로 이동
            </script>
<%
        } else {
            // 삭제가 실패하면 에러 메시지 출력
            out.println("<script>alert('회원 탈퇴에 실패했습니다.');</script>");
            out.println("<script>window.history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류가 발생했습니다.');</script>");
        out.println("<script>window.history.back();</script>");
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
