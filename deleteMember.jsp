<%@ page contentType="text/html; charset=euc-kr" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String id = request.getParameter("memId");

    if (id == null || id.isEmpty()) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<script type="text/javascript">
    // confirm 팝업을 띄워 회원탈퇴 확인
    var confirmation = confirm("정말로 회원 탈퇴를 하시겠습니까?");
    if (confirmation) {
        // 사용자가 '네'를 선택한 경우 DB에서 회원 삭제 요청
        window.location.href = "deleteMemberProcess.jsp?memId=<%= id %>";
    } else {
        // 사용자가 '아니요'를 선택한 경우 이전 페이지로 돌아감
        window.history.back();
    }
</script>
