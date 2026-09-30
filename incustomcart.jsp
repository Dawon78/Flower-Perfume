<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String cusNoStr = request.getParameter("cusNo");
    String memId = request.getParameter("memId");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        int cusNo = Integer.parseInt(cusNoStr);

        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/flower", "multi", "abcd");

        String sql = "INSERT INTO custom_cart (memId, cusNo, cusQty) VALUES (?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, memId);
        pstmt.setInt(2, cusNo);
        pstmt.setInt(3, 1); // 수량은 1개로 고정

        int result = pstmt.executeUpdate();
        if (result > 0) {
            out.println("<script>alert('장바구니에 담겼습니다!'); location.href='cart.jsp';</script>");
        } else {
            out.println("<script>alert('장바구니 추가 실패'); history.back();</script>");
        }

    } catch (Exception e) {
        out.println("<p>오류 발생: " + e.getMessage() + "</p>");
    } finally {
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>
