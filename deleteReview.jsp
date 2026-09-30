<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("euc-kr");
    String reviewId = request.getParameter("reviewId");

    if (reviewId != null && !reviewId.trim().isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            String url = "jdbc:mysql://localhost:3306/flower";
            String user = "multi";
            String password = "abcd";

            conn = DriverManager.getConnection(url, user, password);
            String sql = "DELETE FROM review WHERE reviewId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(reviewId));

            int result = pstmt.executeUpdate();

            if (result > 0) {
                response.sendRedirect("manager_index.jsp"); // 파일명에 맞게 수정
            } else {
                out.println("<script>alert('삭제 실패'); history.back();</script>");
            }
        } catch (Exception e) {
            out.println("<script>alert('에러 발생'); history.back();</script>");
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    } else {
        out.println("<script>alert('유효하지 않은 요청'); history.back();</script>");
    }
%>
