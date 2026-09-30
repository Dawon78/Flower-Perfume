<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <style>
        /* 팝업 스타일 */
        #customAlert {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            z-index: 1000;
        }
        #overlay {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        button {
            margin: 5px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-confirm {
            background-color: #fff;
            color: black;
            border: 1px solid #333;
        }
        .btn-cancel {
            background-color: #333;
            color: white;
        }
    </style>
</head>
<body>
<%
    request.setCharacterEncoding("euc-kr"); 
    String prdNo = request.getParameter("prdNo"); 
    String prdColor = request.getParameter("prdColor");
    String prdSize = request.getParameter("prdSize");
    String prdPriceStr = request.getParameter("prdPrice"); // 문자열로 받아옴

    if (prdNo == null || prdNo.trim().isEmpty() || prdPriceStr == null || prdPriceStr.trim().isEmpty()) {
%>
    <script>
        alert("상품 정보가 올바르지 않습니다.");
        history.back();
    </script>
<%
        return;
    }

    int prdPrice = Integer.parseInt(prdPriceStr); // 문자열 → 숫자형 변환
%>

<div id="overlay"></div>

<div id="customAlert">
    <p>장바구니 담기 완료!</p>
    <button class="btn-confirm" onclick="moveLink()">장바구니 확인하기</button>
    <button class="btn-cancel" onclick="closeAlert()">쇼핑 계속하기</button>
</div>

<script type="text/javascript">
    function showCustomAlert() {
        document.getElementById('overlay').style.display = 'block';
        document.getElementById('customAlert').style.display = 'block';
    }

    function closeAlert() {
        document.getElementById('overlay').style.display = 'none';
        document.getElementById('customAlert').style.display = 'none';
        window.location.href = 'Product_detail.jsp?prdNo=<%=prdNo%>';
    }

    function moveLink() {
        window.location.href = 'cart.jsp';
    }
</script>

<%
    request.setCharacterEncoding("utf-8");
    String id = (String) session.getAttribute("sid");

    if (id == null) {
%>
        <script>
        alert("로그인이 필요합니다.");
        window.location.href = 'login.jsp';
        </script>
<%
    } else {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";
        Class.forName("org.gjt.mm.mysql.Driver");
        Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

        try {
            String prdImg = ""; 
            String prdImgSql = "SELECT prdImg FROM product WHERE prdNo = ?";
            PreparedStatement pstmtImg = con.prepareStatement(prdImgSql);
            pstmtImg.setString(1, prdNo);
            ResultSet rsImg = pstmtImg.executeQuery();
            if (rsImg.next()) {
                prdImg = rsImg.getString("prdImg"); 
            }

            String jsql1 = "SELECT * FROM cart WHERE memId = ? AND prdNo = ? AND mapping_id = ?";
            PreparedStatement pstmt1 = con.prepareStatement(jsql1);
            pstmt1.setString(1, id);
            pstmt1.setString(2, prdNo); 
            pstmt1.setString(3, prdColor + prdSize); 
            ResultSet rs1 = pstmt1.executeQuery();

            if (!rs1.next()) { 
                String jsql2 = "INSERT INTO mapping_id (prdNo, color, size) VALUES (?, ?, ?)";
                PreparedStatement pstmt2 = con.prepareStatement(jsql2, Statement.RETURN_GENERATED_KEYS);
                pstmt2.setString(1, prdNo);  
                pstmt2.setString(2, prdColor);  
                pstmt2.setString(3, prdSize);  
                pstmt2.executeUpdate();

                ResultSet generatedKeys = pstmt2.getGeneratedKeys();
                int mappingId = -1;
                if (generatedKeys.next()) {
                    mappingId = generatedKeys.getInt(1);
                }

                // 가격이 업데이트된 값을 cart에 삽입
                String jsql3 = "INSERT INTO cart (memId, prdNo, ctQty, prdImg, mapping_id, prdPrice) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt3 = con.prepareStatement(jsql3);
                pstmt3.setString(1, id);
                pstmt3.setString(2, prdNo);
                pstmt3.setInt(3, 1); 
                pstmt3.setString(4, prdImg); 
                pstmt3.setInt(5, mappingId);  
                pstmt3.setInt(6, prdPrice);  // ← 숫자형으로 저장
                pstmt3.executeUpdate();
            }

        %>
            <script>
                showCustomAlert();
            </script>
        <%
        } catch (Exception e) {
            out.println("<p>데이터베이스 작업 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
