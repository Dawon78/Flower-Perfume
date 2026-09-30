<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("euc-kr");

    String memName = request.getParameter("memName");
    String memNick = request.getParameter("memNick");
    String memPhone = request.getParameter("memPhone");
    String memEmail = request.getParameter("memEmail");
    String prdCategory = request.getParameter("prdCategory");
    String prdName = request.getParameter("prdName");
    String questionText = request.getParameter("questionText");

    if (memName == null || memNick == null || memPhone == null || memEmail == null ||
        prdCategory == null || prdName == null || questionText == null ||
        memName.trim().isEmpty() || memNick.trim().isEmpty() || 
        memPhone.trim().isEmpty() || memEmail.trim().isEmpty() || 
        prdCategory.trim().isEmpty() || prdName.trim().isEmpty() || questionText.trim().isEmpty()) {
%>
    <script>
        alert("모든 필수 항목을 입력해주세요.");
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

        String sql = "INSERT INTO question (memName, memNick, memPhone, memEmail, prdCategory, prdName, questionText) VALUES (?, ?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, memName);
        pstmt.setString(2, memNick);
        pstmt.setString(3, memPhone);
        pstmt.setString(4, memEmail);
        pstmt.setString(5, prdCategory);
        pstmt.setString(6, prdName);
        pstmt.setString(7, questionText);

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
    <script>
        alert("문의가 정상적으로 접수되었습니다.");
        location.href = "mypage_Question.jsp";
    </script>
<%
        } else {
%>
    <script>
        alert("문의 등록에 실패했습니다. 다시 시도해주세요.");
        history.back();
    </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script>
        alert("오류가 발생했습니다: <%= e.getMessage() %>");
        history.back();
    </script>
<%
    } finally {

        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
