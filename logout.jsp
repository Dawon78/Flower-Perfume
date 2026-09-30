<%@ page contentType="text/html; charset=euc-kr" %>
<%
    session.invalidate();  
    response.sendRedirect("index.html"); 
%>