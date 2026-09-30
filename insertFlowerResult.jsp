<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%
request.setCharacterEncoding("euc-kr");

// 입력값 가져오기
String prdNo = request.getParameter("prdNo");
String flowerName = request.getParameter("flowerName");
String flowerSub = request.getParameter("flowerSub");
String flowerMeaning = request.getParameter("flowerMeaning");
String flowerSubMeaning = request.getParameter("flowerSubMeaning");
String flowerMeaningmore = request.getParameter("flowerMeaningmore");
String flowerDescription = request.getParameter("flowerDescription");
String flowerImage1 = request.getParameter("flowerImage1");
String flowerImage2 = request.getParameter("flowerImage2");
String flowerImage3 = request.getParameter("flowerImage3");

Connection conn = null;
PreparedStatement pstmt = null;

try {
    // 기존 드라이버 유지
    Class.forName("org.gjt.mm.mysql.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/flower", "multi", "abcd");

    // SQL 실행문 (PreparedStatement 사용)
    String sql = "INSERT INTO flowerbook (prdNo, flowerName, flowerSub, flowerMeaning, flowerSubMeaning, flowerMeaningmore, flowerDescription, flowerImage1, flowerImage2, flowerImage3) " +
                 "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    pstmt = conn.prepareStatement(sql);
    pstmt.setInt(1, Integer.parseInt(prdNo));
    pstmt.setString(2, flowerName);
    pstmt.setString(3, flowerSub);
    pstmt.setString(4, flowerMeaning);
    pstmt.setString(5, flowerSubMeaning);
    pstmt.setString(6, flowerMeaningmore);
    pstmt.setString(7, flowerDescription);
    pstmt.setString(8, flowerImage1);
    pstmt.setString(9, flowerImage2);
    pstmt.setString(10, flowerImage3);

    int result = pstmt.executeUpdate();

    if (result > 0) {
        out.println("<script>alert('꽃 정보가 성공적으로 등록되었습니다.'); location.href='insertflower.jsp';</script>");
    } else {
        out.println("<script>alert('입력 실패: 다시 시도해주세요.'); history.back();</script>");
    }

} catch (Exception e) {
    out.println("<script>alert('오류 발생: " + e.getMessage() + "'); history.back();</script>");
} finally {
    try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
    try { if (conn != null) conn.close(); } catch (Exception e) {}
}
%>
