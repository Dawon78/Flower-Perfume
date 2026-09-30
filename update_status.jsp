<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("euc-kr");

    String ordNo = request.getParameter("ordNo");
    String newStatus = request.getParameter("status");
    String location = request.getParameter("location");
	 String tracking_number = request.getParameter("tracking_number");

    if (ordNo == null || newStatus == null || location == null) {
        out.println("<script>alert('잘못된 접근입니다.'); history.back();</script>");
        return;
    }

    // DB 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection con = null;
    PreparedStatement pstmtUpdate = null;
    PreparedStatement pstmtLog = null;

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

     
    // 1. orderinfo 상태 업데이트
    String updateSql = "UPDATE orderinfo SET status = ?, location = ?, tracking_number = ? WHERE ordNo = ?";
    pstmtUpdate = con.prepareStatement(updateSql);
    pstmtUpdate.setString(1, newStatus);
    pstmtUpdate.setString(2, location);
    pstmtUpdate.setString(3, tracking_number);  // 송장번호 추가
    pstmtUpdate.setString(4, ordNo);

    int updateResult = pstmtUpdate.executeUpdate();

    // 2. delivery_log에 기록
    String logSql = "INSERT INTO delivery_log (ordNo, status, location, tracking_number) VALUES (?, ?, ?, ?)";
    pstmtLog = con.prepareStatement(logSql);
    pstmtLog.setString(1, ordNo);
    pstmtLog.setString(2, newStatus);
    pstmtLog.setString(3, location);
    pstmtLog.setString(4, tracking_number);  // 송장번호 추가

    int logResult = pstmtLog.executeUpdate();


if (updateResult > 0 && logResult > 0) {
    String orddNo = request.getParameter("ordNo"); 
    out.println("<script>alert('배송 상태가 변경되었습니다.'); location.href='http://localhost:8080/Flower/order_detail.jsp?ordNo=" + orddNo + "';</script>");
} else {
    out.println("<script>alert('변경 또는 로그 기록에 실패했습니다.'); history.back();</script>");
}



    } catch (SQLException e) {
        out.println("<p style='color: red;'>오류 발생: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        try {
            if (pstmtUpdate != null) pstmtUpdate.close();
            if (pstmtLog != null) pstmtLog.close();
            if (con != null) con.close();
        } catch (SQLException ignored) {}
    }
%>
