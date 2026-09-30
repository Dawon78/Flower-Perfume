<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session.removeAttribute("tid");
    session.removeAttribute("item_description");
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>결제 취소</title></head>
<body>
<script>
    alert("결제가 취소되었습니다. 이전 화면으로 돌아갑니다.");
    if (window.opener) {
        window.close();
    } else {
        location.href = "cart.jsp";
    }
</script>
</body>
</html>