<%@ page contentType="text/html; charset=euc-kr" pageEncoding="euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>상품 수정</title>
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
        }

        .container {
            width: 100%;
            max-width: 900px;
            margin: 40px auto;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
        }

        h1 {
            text-align: center;
            font-size: 28px;
            color: black;
            margin-bottom: 30px;
        }

        form table {
            width: 100%;
            border-collapse: collapse;
        }

        form td {
            padding: 16px 10px;
            vertical-align: top;
            font-size: 15px;
            color: #333;
            border-bottom: 1px solid #eee;
        }

        form td:first-child {
            width: 25%;
            font-weight: bold;
            text-align: right;
            padding-right: 20px;
        }

        input[type="text"],
        input[type="number"],
        input[type="date"],
        select,
        textarea {
            width: 100%;
            padding: 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 6px;
            background-color: #fafafa;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            min-height: 120px;
        }

        .form-btn-container {
            text-align: center;
            margin-top: 30px;
        }

        input[type="submit"],
        input[type="reset"],
        .go-to-manager-btn {
            padding: 12px 30px;
            font-size: 16px;
            margin: 8px;
            border: none;
            border-radius: 6px;
            background-color: #333;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover,
        .go-to-manager-btn:hover {
            background-color: #555;
        }

        .go-to-manager-btn {
            text-decoration: none;
        }
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("euc-kr");
    String prdNo = request.getParameter("prdNo");
    String prdType = "", prdCategory = "", prdName = "", prdImg = "", prdDate = "", prdDescription = "";
    int prdPrice = 0, prdStock = 0;

    if (prdNo != null && !prdNo.trim().isEmpty()) {
        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/flower", "multi", "abcd");
            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM product WHERE prdNo = ?");
            pstmt.setString(1, prdNo);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                prdType = rs.getString("prdType");
                prdCategory = rs.getString("prdCategory");
                prdName = rs.getString("prdName");
                prdImg = rs.getString("prdImg");
                prdPrice = rs.getInt("prdPrice");
                prdStock = rs.getInt("prdStock");
                prdDate = rs.getString("prdDate");
                prdDescription = rs.getString("prdDescription");
            }
            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            out.println("DB 오류: " + e);
        }
    }
%>

<div class="container">
    <h1>상품 수정</h1>
    <form method="post" action="updateGoodsResult.jsp">
        <table>
            <tr>
                <td>상품번호</td>
                <td><input type="text" name="prdNo" value="<%= prdNo != null ? prdNo : "" %>" readonly required></td>
            </tr>
            <tr>
                <td>계절</td>
                <td>
                    <select name="prdType">
                        <option value="봄" <%= "봄".equals(prdType) ? "selected" : "" %>>봄</option>
                        <option value="여름" <%= "여름".equals(prdType) ? "selected" : "" %>>여름</option>
                        <option value="가을" <%= "가을".equals(prdType) ? "selected" : "" %>>가을</option>
                        <option value="겨울" <%= "겨울".equals(prdType) ? "selected" : "" %>>겨울</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>카테고리</td>
                <td>
                    <select name="prdCategory">
                        <option value="Perfume" <%= "Perfume".equals(prdCategory) ? "selected" : "" %>>향수</option>
                        <option value="Diffuser" <%= "Diffuser".equals(prdCategory) ? "selected" : "" %>>디퓨저</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>상품명</td>
                <td><input type="text" name="prdName" value="<%= prdName %>" required></td>
            </tr>
            <tr>
                <td>이미지 경로</td>
                <td><input type="text" name="prdImg" value="<%= prdImg %>"></td>
            </tr>
            <tr>
                <td>상품가격</td>
                <td><input type="number" name="prdPrice" value="<%= prdPrice %>" required></td>
            </tr>
            <tr>
                <td>재고수량</td>
                <td><input type="number" name="prdStock" value="<%= prdStock %>" required></td>
            </tr>
            <tr>
                <td>상품 출시일</td>
                <td><input type="date" name="prdDate" value="<%= prdDate %>" required></td>
            </tr>
            <tr>
                <td>상품설명</td>
                <td><textarea name="prdDescription"><%= prdDescription %></textarea></td>
            </tr>
        </table>

        <div class="form-btn-container">
            <input type="submit" value="상품수정">
            <a href="manager_index.jsp" class="go-to-manager-btn">관리자 메인 페이지</a>
        </div>
    </form>
</div>
</body>
</html>
