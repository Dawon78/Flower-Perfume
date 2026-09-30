<%@ page contentType="text/html;charset=UTF-8" %>
<%
    session.removeAttribute("tid");
    session.removeAttribute("item_description");
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>결제 실패</title></head>
<body>
<script>
    alert("결제에 실패했습니다. 다시 시도해 주세요.");
    if (window.opener) {
        window.close();
    } else {
        location.href = "cart.jsp";
    }
</script>
</body>
</html>