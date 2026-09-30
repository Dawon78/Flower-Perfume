<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %> 
<html>
<head>
    <title>상품 등록 처리</title>
    <script type="text/javascript">
        // 상품 등록 완료 후 팝업 메시지를 띄우고 관리자 페이지로 리디렉션
        function showPopupAndRedirect() {
            alert("상품 정보가 등록되었습니다.");
            window.location.href = "manager_index.jsp"; // manager_index.jsp로 리디렉션
        }
    </script>
</head>
<body>

<% 
    request.setCharacterEncoding("euc-kr");  

    // 입력된 상품 정보
    int prdNo = Integer.parseInt(request.getParameter("prdNo")); // 상품번호
    String prdType = request.getParameter("prdType");
    String name = request.getParameter("prdName");
    String img = request.getParameter("prdImg");
    int price = Integer.parseInt(request.getParameter("prdPrice")); 
    int stock = Integer.parseInt(request.getParameter("prdStock")); 
    String description = request.getParameter("prdDescription");
    String date = request.getParameter("prdDate");
    String category = request.getParameter("prdCategory");

    // 상품 설명이 null일 경우 null 처리
    if (description == null || description.trim().isEmpty()) {
        description = null; 
    }

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/flower"; 
        String DB_ID = "multi"; 
        String DB_PASSWORD = "abcd"; 
        
        // MySQL 드라이버 로드
        Class.forName("org.gjt.mm.mysql.Driver");  
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
        
        // 상품 등록 SQL 쿼리
        String jsql = "INSERT INTO product (prdNo, prdType, prdName, prdImg, prdPrice, prdStock, prdDescription, prdDate, prdCategory) ";
        jsql += "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"; 
        
        PreparedStatement pstmt = con.prepareStatement(jsql); 
        pstmt.setInt(1, prdNo); // 상품번호
        pstmt.setString(2, prdType); 
        pstmt.setString(3, name);
        pstmt.setString(4, img);
        pstmt.setInt(5, price); 
        pstmt.setInt(6, stock);
        pstmt.setString(7, description);
        pstmt.setString(8, date);
        pstmt.setString(9, category);

        // 실행
        pstmt.executeUpdate(); 
%>

<!-- 자바스크립트로 팝업 메시지를 띄우고 관리자 페이지로 리디렉션 -->
<script type="text/javascript">
    showPopupAndRedirect();
</script>

<% 
    } catch(SQLException e) { 
        out.println("<p style='color: red;'>DB 오류 발생: " + e.getMessage() + "</p>");
    } catch(Exception e) { 
        out.println("<p style='color: red;'>알 수 없는 오류 발생: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>
