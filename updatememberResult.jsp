<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("euc-kr");

    String id = (String) session.getAttribute("sid");

    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String memNick = request.getParameter("memNick");
    String memAddress1 = request.getParameter("memAddress1");
    String memAddress2 = request.getParameter("memAddress2");
    String memPasswd = request.getParameter("memPasswd");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql;
        if (memPasswd == null || memPasswd.trim().isEmpty()) {
            sql = "UPDATE member SET memNick = ?, memAddress1 = ?, memAddress2 = ? WHERE memId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memNick);
            pstmt.setString(2, memAddress1);
            pstmt.setString(3, memAddress2);
            pstmt.setString(4, id);
        } else {
            sql = "UPDATE member SET memNick = ?, memAddress1 = ?, memAddress2 = ?, memPasswd = ? WHERE memId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memNick);
            pstmt.setString(2, memAddress1);
            pstmt.setString(3, memAddress2);
            pstmt.setString(4, memPasswd);
            pstmt.setString(5, id);
        }

        int result = pstmt.executeUpdate();
        if (result > 0) {
%>
            <script>
                alert("프로필 정보가 성공적으로 수정되었습니다.");
                window.location.href = "mypage_updatemember.jsp";
            </script>
<%
        } else {
%>
            <script>
                alert("회원 정보 수정 실패. 다시 시도해주세요.");
                window.history.back();
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert("회원 정보 수정 중 오류가 발생했습니다.");
            window.history.back();
        </script>
<%
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignored) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignored) {}
    }
%>
