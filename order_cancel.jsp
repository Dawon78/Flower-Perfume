<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("euc-kr");

String memId = (String) session.getAttribute("sid");
String ordNoParam = request.getParameter("ordNo");

if (memId == null) {
    out.println("<script>alert('로그인이 필요합니다.'); location.href='login.jsp';</script>");
    return;
}

if (ordNoParam == null || ordNoParam.trim().isEmpty()) {
    out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    return;
}

int ordNo = Integer.parseInt(ordNoParam);

String DB_URL = "jdbc:mysql://localhost:3306/flower";
String DB_ID = "multi";
String DB_PASSWORD = "abcd";

Connection con = null;
PreparedStatement pstmt = null;
ResultSet rs = null;

try {
    Class.forName("org.gjt.mm.mysql.Driver");
    con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // 1. 본인 주문인지 확인
    String checkSql = "SELECT COUNT(*) FROM orderinfo WHERE ordNo = ? AND memId = ?";
    pstmt = con.prepareStatement(checkSql);
    pstmt.setInt(1, ordNo);
    pstmt.setString(2, memId);
    rs = pstmt.executeQuery();

    boolean isValid = false;
    if (rs.next() && rs.getInt(1) > 0) {
        isValid = true;
    }

    rs.close();
    pstmt.close();

    if (!isValid) {
        out.println("<script>alert('해당 주문을 취소할 수 없습니다.'); history.back();</script>");
        return;
    }

    // 2. 이미 취소된 주문인지 확인
    String cancelCheckSql = "SELECT isCanceled FROM orderinfo WHERE ordNo = ?";
    pstmt = con.prepareStatement(cancelCheckSql);
    pstmt.setInt(1, ordNo);
    rs = pstmt.executeQuery();

    if (rs.next()) {
        String isCanceled = rs.getString("isCanceled");
        if ("Y".equalsIgnoreCase(isCanceled)) {
            out.println("<script>alert('이미 취소된 주문입니다.'); history.back();</script>");
            return;
        }
    }

    rs.close();
    pstmt.close();

    // 3. 주문 취소 처리
    String updateSql = "UPDATE orderinfo SET isCanceled = 'Y' WHERE ordNo = ?";
    pstmt = con.prepareStatement(updateSql);
    pstmt.setInt(1, ordNo);

    int result = pstmt.executeUpdate();

    if (result > 0) {
        out.println("<script>alert('주문이 취소되었습니다.'); location.href='mypage_order_h_list.jsp';</script>");
    } else {
        out.println("<script>alert('주문 취소에 실패했습니다.'); history.back();</script>");
    }

} catch (Exception e) {
    e.printStackTrace();
    out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
} finally {
    try { if (rs != null) rs.close(); } catch (Exception ignored) {}
    try { if (pstmt != null) pstmt.close(); } catch (Exception ignored) {}
    try { if (con != null) con.close(); } catch (Exception ignored) {}
}
%>
