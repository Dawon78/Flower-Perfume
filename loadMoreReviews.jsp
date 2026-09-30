<%@ page import="java.sql.*, java.text.*" %>
<%
    int prdNoInt = Integer.parseInt(request.getParameter("prdNo"));
    int offset = Integer.parseInt(request.getParameter("offset"));

    // 데이터베이스 연결
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/flower", "multi", "abcd");

        // 리뷰를 offset부터 가져옴
        pstmt = conn.prepareStatement(
            "SELECT r.memId, r.reviewDate, r.scent, r.longevity, r.content " +
            "FROM review r " +
            "WHERE r.prdNo = ? " +
            "ORDER BY r.reviewDate DESC LIMIT ?, 4" // 추가로 4개 리뷰를 가져옴
        );
        pstmt.setInt(1, prdNoInt); // 상품 번호
        pstmt.setInt(2, offset); // 오프셋 값 (현재까지 로드된 리뷰 이후부터)
        rs = pstmt.executeQuery();

        while (rs.next()) {
            String memId = rs.getString("memId");
            String reviewDate = rs.getString("reviewDate");
            String scent = rs.getString("scent");
            String longevity = rs.getString("longevity");
            String content = rs.getString("content");
            
            // 날짜 포맷 변환 (yyyy-MM-dd -> Mar 12 2025 형태로 변환)
            String[] dateParts = reviewDate.split(" ")[0].split("-");
            String formattedDate = dateParts[1] + " " + dateParts[2] + " " + dateParts[0];
%>
            <div class="review-item">
                <div class="profile-img"></div>
                <div class="review-content">
                    <p class="review-name"><%= memId %></p>
                    <p class="review-date"><%= formattedDate %></p>
                    <p class="review-scent"><strong>Scent:</strong> <%= scent != null ? scent : "Not provided" %></p>
                    <p class="review-longevity"><strong>Longevity:</strong> <%= longevity != null ? longevity : "Not provided" %></p>
                    <p class="review-text">"<%= content %>"</p>
                </div>
            </div>
<%
        }
        rs.close();
        pstmt.close();
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
