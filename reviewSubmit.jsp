<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review</title>
    <link rel="stylesheet" href="./css/header_footer.css">
    <link rel="stylesheet" href="./css/reviewSubmit.css">
    <script src="./js/reviewSubmit.js" defer></script>
    <script src="https://kit.fontawesome.com/b470949ecb.js" crossorigin="anonymous"></script>
</head>
<body>
<%
    String id = (String) session.getAttribute("sid");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String prdNo = request.getParameter("prdNo");

    // DB 연결 정보
    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String prdImg = "", prdName = "", prdType = "";
    double prdPrice = 0;
    String color = "", size = "";

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        String sql = "SELECT p.prdName, p.prdType, p.prdPrice, op.prdImg, m.color, m.size " +
                     "FROM product p " +
                     "JOIN orderproduct op ON p.prdNo = op.prdNo " +
                     "LEFT JOIN mapping_id m ON op.mapping_id = m.mappingId " +
                     "WHERE p.prdNo = ? AND op.memId = ? " +
                     "ORDER BY op.ordNo DESC LIMIT 1";

        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(prdNo));
        pstmt.setString(2, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            prdName = rs.getString("prdName");
            prdType = rs.getString("prdType");
            prdPrice = rs.getDouble("prdPrice");
            prdImg = rs.getString("prdImg");
            color = rs.getString("color");
            size = rs.getString("size");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
    }

    // 용량(size)에 따른 가격 조정
    int adjustedPrice = (int) prdPrice;
    if ("125ML".equals(size)) {
        adjustedPrice += 10000;
    } else if ("150ML".equals(size)) {
        adjustedPrice += 20000;
    } else if ("175ML".equals(size)) {
        adjustedPrice += 30000;
    } else if ("200ML".equals(size)) {
        adjustedPrice += 40000;
    }
%>

<form action="reviewSubmitAction.jsp" method="post">
    <input type="hidden" name="prdNo" value="<%= prdNo %>">
    <input type="hidden" name="size" value="<%= size %>">

    <div class="product-container">
        <img src="<%= prdImg %>" alt="상품 이미지" class="product-image">
        <div class="product-info">
            <div class="product-name"><%= prdName %></div>
            <div class="product-desc"><%= prdType %></div>
            <div>
                <span class="original-price"><%= String.format("%,d", adjustedPrice) %>원</span>
            </div>
            <div>
                <span>옵션: <%= color %> / <%= size %></span>
            </div>
        </div>
    </div>


        <h4 class="h4">구매하신 상품은 만족하시나요?</h4>
        <div class="review-stars">
            <div class="stars">
                <% for (int i = 1; i <= 5; i++) { %>
                    <span data-value="<%= i %>"><i class="fas fa-star star"></i></span>
                <% } %>
            </div>
            <div class="star-count">
                <p id="rating-value">0 / 5.0</p>
                <input type="hidden" name="rating" id="rating-input">
            </div>
        </div>

        <h4 class="h4">이 향수의 지속력은 어땠나요?</h4>
        <div class="options" id="longevity-options">
            <button type="button" data-value="지속력이 짧아요">지속력이 짧아요</button>
            <button type="button" data-value="적당해요">적당해요</button>
            <button type="button" data-value="오래 지속돼요">오래 지속돼요</button>
        </div>
        <input type="hidden" name="longevity" id="longevity-input">

        <h4 class="h4">향수의 향은 어떤 느낌이었나요?</h4>
        <div class="options" id="scent-options">
            <button type="button" data-value="가볍고 은은했어요">가볍고 은은했어요</button>
            <button type="button" data-value="적당했어요">적당했어요</button>
            <button type="button" data-value="강하고 뚜렷했어요">강하고 뚜렷했어요</button>
        </div>
        <input type="hidden" name="scent" id="scent-input">

        <h4 class="h4">자세한 리뷰를 작성해주세요</h4>
        <div class="textarea-container">
            <textarea id="review" name="review" maxlength="1000" placeholder="품질/디자인/배송 등에 대한 경험을 작성해주세요."></textarea>
            <div id="char-counter">(0/1000)</div>
        </div>

        <div class="bottom-row">
            <button type="submit" class="submit-btn">등록하기</button>
            <button type="reset" class="submit-btn" onclick="location.reload();">취소하기 </button>
        </div>
    </form>
</body>

</html>