<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <style>
        /* 필요 시 스타일 추가 */
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("euc-kr");
    String ctNo = request.getParameter("ctNo");
    String ccNo = request.getParameter("ccNo"); // 커스텀 향수 항목 번호

    // 디버깅 출력
    out.println("<p>디버그: ctNo = " + ctNo + ", ccNo = " + ccNo + "</p>");

    String id = (String) session.getAttribute("sid");

    if (id == null) {
%>
    <script>
        alert("로그인이 필요합니다.");
        window.location.href = 'login.jsp';
    </script>
<%
    } else {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            String DB_URL = "jdbc:mysql://localhost:3306/flower";
            String DB_ID = "multi";
            String DB_PASSWORD = "abcd";
            Class.forName("org.gjt.mm.mysql.Driver");
            con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

            boolean deleted = false;

            // 일반 상품 삭제
            if (ctNo != null && !ctNo.trim().isEmpty()) {
                String checkSql = "SELECT * FROM cart WHERE memId = ? AND ctNo = ?";
                pstmt = con.prepareStatement(checkSql);
                pstmt.setString(1, id);
                pstmt.setString(2, ctNo);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    pstmt.close();
                    String deleteSql = "DELETE FROM cart WHERE memId = ? AND ctNo = ?";
                    pstmt = con.prepareStatement(deleteSql);
                    pstmt.setString(1, id);
                    pstmt.setString(2, ctNo);
                    pstmt.executeUpdate();
                    deleted = true;
                }
                rs.close();
                pstmt.close();
            }

            // 커스텀 향수 삭제
            if (ccNo != null && !ccNo.trim().isEmpty()) {
                String checkSql = "SELECT * FROM custom_cart WHERE memId = ? AND ccNo = ?";
                pstmt = con.prepareStatement(checkSql);
                pstmt.setString(1, id);
                pstmt.setString(2, ccNo);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    pstmt.close();
                    String deleteSql = "DELETE FROM custom_cart WHERE memId = ? AND ccNo = ?";
                    pstmt = con.prepareStatement(deleteSql);
                    pstmt.setString(1, id);
                    pstmt.setString(2, ccNo);
                    pstmt.executeUpdate();
                    deleted = true;
                }
                rs.close();
                pstmt.close();
            }

            if (deleted) {
%>
    <script>
        alert("상품이 장바구니에서 삭제되었습니다.");
        window.location.href = 'cart.jsp';
    </script>
<%
            } else {
%>
    <script>
        alert("삭제할 상품이 장바구니에 없습니다.");
        window.location.href = 'cart.jsp';
    </script>
<%
            }

        } catch (Exception e) {
            out.println("<p>오류 발생: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
            if (con != null) try { con.close(); } catch (Exception e) {}
        }
    }
%>
</body>
</html>
