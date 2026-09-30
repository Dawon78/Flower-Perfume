<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="euc-kr">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 등록</title>
</head>
<body>
<%
    // 로그인 확인
    String id = (String) session.getAttribute("sid");
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 폼에서 넘어온 데이터 받기
    request.setCharacterEncoding("EUC-KR"); // 한글 깨짐 방지
    String prdNo = request.getParameter("prdNo");  // 상품 번호
    String rating = request.getParameter("rating"); // 별점
    String longevity = request.getParameter("longevity"); // 지속력
    String scent = request.getParameter("scent"); // 향의 강도
    String content = request.getParameter("review"); // 리뷰 내용

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // MySQL 연결
        Class.forName("org.gjt.mm.mysql.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/flower", "multi", "abcd");

        // SQL 삽입 쿼리 (review 테이블 구조에 맞게 수정)
        String sql = "INSERT INTO review (star, memId, prdNo, longevity, scent, content) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, Integer.parseInt(rating)); // 별점
        pstmt.setString(2, id); // 회원 ID
        pstmt.setInt(3, Integer.parseInt(prdNo)); // 상품 번호
        pstmt.setString(4, longevity); // 지속력
        pstmt.setString(5, scent); // 향의 강도
        pstmt.setString(6, content); // 리뷰 내용

        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
            <script>
                if (window.opener) {
                    window.opener.location.reload();  // 부모창 새로고침
                }
                window.close();  // 팝업 닫기
            </script>
<%
        } else {
%>
            <script>
                alert('리뷰 등록에 실패했습니다. 다시 시도해주세요.');
                history.back();  // 이전 페이지로 돌아가기
            </script>
<%
        }

    } catch (Exception e) {
        e.printStackTrace();
%>
        <script>
            alert('오류가 발생했습니다: <%= e.getMessage().replace("'", "\\'") %>');
            history.back();  // 오류 발생 시 이전 페이지로 돌아가기
        </script>
<%
    } finally {
        // 자원 해제
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException ignored) {}
        }
        if (conn != null) {
            try { conn.close(); } catch (SQLException ignored) {}
        }
    }
%>
</body>
</html>
