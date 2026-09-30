<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>전체 상품 조회</title>
<style>
    @font-face {
        font-family: 'BookkMyungjo-Bd';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
        font-weight: 700;
        font-style: normal;
    }

    body {
        font-family: 'BookkMyungjo-Bd', serif;
        margin: 0;
        padding: 0;
        background-color: #fff;
        color: #000;
    }

    h1 {
        text-align: center;
        color: black;
        font-size: 28px;
        margin-top: 30px;
        margin-bottom: 20px;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: white;
        border-radius: 8px;
        font-size: 14px;
    }

    th, td {
        padding: 20px;  /* 칸을 넓혀서 글자가 세로로 되지 않게 수정 */
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
        color: #333;
    }

    td {
        background-color: #fafafa;
    }

    /* 상품명 칸 간격 늘리기 */
    td:nth-child(4), th:nth-child(4) {
        padding-left: 20px;
        padding-right: 20px;
    }

    /* 수정 버튼 크기 키우기 */
    td:nth-child(10), th:nth-child(10) {
        padding: 15px 25px;  /* 수정 버튼 칸 패딩 증가 */
        font-size: 14px;
    }

    /* 상품설명 칸 크기 줄이기 */
    td:nth-child(9), th:nth-child(9) {
        padding: 10px 15px;  /* 설명 칸 패딩 줄이기 */
        font-size: 14px;  /* 설명 텍스트 크기 줄이기 */
        max-width: 300px; /* 설명 칸 최대 너비 제한 */
        overflow: hidden; /* 텍스트 넘침 방지 */
        text-overflow: ellipsis; /* 텍스트가 넘칠 때 '...'로 표시 */
    }

    tr:nth-child(even) td {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    img {
        max-width: 50px;
        max-height: 50px;
        object-fit: cover;
    }

    .btn-container {
        text-align: center;
        margin-top: 40px;
        margin-bottom: 40px;
    }

    .btn-container a {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border-radius: 5px;
        font-size: 16px;
        cursor: pointer;
        text-decoration: none;
    }

    .btn-container a:hover {
        background-color: #45a049;
    }

    .btn-container a:nth-child(2) {
        background-color: #f44336;
    }

    .btn-container a:nth-child(2):hover {
        background-color: #e53935;
    }

    a {
        color: black;
        text-decoration: none;  /* 밑줄 없애기 */
    }

    a:hover {
        text-decoration: underline;
    }
</style>


</head>
<body>

<%
    request.setCharacterEncoding("euc-kr"); 

    try {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";  
        String DB_ID = "multi";  
        String DB_PASSWORD = "abcd"; 
        
        Class.forName("org.gjt.mm.mysql.Driver"); 
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

        // product 테이블에서 데이터 가져오기
        String jsql = "SELECT * FROM product";   
        PreparedStatement pstmt = con.prepareStatement(jsql);
        ResultSet rs = pstmt.executeQuery();
%>

<h1>상품 전체 조회</h1>

<table>
    <thead>
        <tr>
            <th>상품번호</th>
            <th>계절</th>
            <th>카테고리</th>
            <th>상품명</th>
            <th>이미지</th>
            <th>상품가격</th>
            <th>재고수량</th>
            <th>출시일</th>
            <th>상품설명</th>
            <th>수정</th>
        </tr>
    </thead>
    <tbody>
<%
        while(rs.next()) {
            int prdNo = rs.getInt("prdNo"); // 자동 증가 상품번호
            String prdType = rs.getString("prdType"); // 계절
            String prdCategory = rs.getString("prdCategory"); // 카테고리
            String prdName = rs.getString("prdName"); // 상품명
            String prdImg = rs.getString("prdImg"); // 이미지 경로
            int prdPrice = rs.getInt("prdPrice"); // 가격
            int prdStock = rs.getInt("prdStock"); // 재고
            String prdDate = rs.getString("prdDate"); // 출시일
            String prdDescription = rs.getString("prdDescription"); // 설명
%>
        <tr>
            <td><%= prdNo %></td>
            <td><%= prdType %></td>
            <td><%= prdCategory %></td>
            <td><%= prdName %></td>
            <td><img src="<%= prdImg %>" alt="이미지 없음"></td>
            <td><%= String.format("%,d", prdPrice) %> 원</td>

            <td><%= prdStock %> 개</td>
            <td><%= prdDate %></td>
            <td><%= prdDescription != null ? prdDescription : "없음" %></td>
            <td><a href="updateGoods.jsp?prdNo=<%= prdNo %>">수정</a></td>
        </tr>
<%
        } 
%>
    </tbody>
</table>

<%
    rs.close();
    pstmt.close();
    con.close();
    } catch (Exception e) {
        out.println(e);
    }
%>

</body>
</html>
