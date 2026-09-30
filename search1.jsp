<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, javax.sql.*, javax.naming.*, java.io.*, java.net.*" %>

<%
    // 사용자가 입력한 검색어 받기
    String prdName = request.getParameter("query");

    // 검색어가 없으면 경고 메시지 출력 후 돌아가도록 처리
    if (prdName == null || prdName.trim().isEmpty()) {
        out.println("<script>alert('검색어를 입력해주세요.'); history.back();</script>");
        return;
    }

    // 검색어를 URL 디코딩
    prdName = java.net.URLDecoder.decode(prdName, "EUC-KR"); 
    System.out.println("디코딩된 검색어: " + prdName);

    // 검색어를 세션에 저장
    session.setAttribute("searchQuery", prdName); // 세션에 검색어 저장

    final String DB_URL = "jdbc:mysql://localhost:3306/flower";
    final String DB_ID = "multi";
    final String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // SQL 쿼리 설정
    String sql = "SELECT prdNo, prdName, prdImg, prdPrice FROM product WHERE prdName LIKE ?";

    try {
        // DB 연결
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        System.out.println("SQL 쿼리: " + sql + " | 검색어: " + "%" + prdName + "%");

        // PreparedStatement 사용하여 쿼리 실행
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + prdName + "%");
        rs = pstmt.executeQuery();

        // 결과가 있으면 검색 결과 페이지로 리디렉션
        if (rs.next()) {
            int foundPrdNo = rs.getInt("prdNo");
            response.sendRedirect("search_Product1.jsp?query=" + URLEncoder.encode(prdName, "EUC-KR"));
        } else {
            out.println("<script>alert('검색 결과가 없습니다.'); history.back();</script>");
        }
    } catch (SQLException e) {
        out.println("<script>alert('SQL 오류: " + e.getMessage() + "'); history.back();</script>");
    } catch (ClassNotFoundException e) {
        out.println("<script>alert('드라이버 클래스 오류: " + e.getMessage() + "'); history.back();</script>");
    } catch (Exception e) {
        out.println("<script>alert('오류: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        // 자원 정리
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
