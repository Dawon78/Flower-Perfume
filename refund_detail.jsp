<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLDecoder" %>

<%
    request.setCharacterEncoding("UTF-8");
    int refundId = Integer.parseInt(request.getParameter("refund_id"));
    int ordNo = Integer.parseInt(request.getParameter("ordNo"));

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String DB_URL = "jdbc:mysql://localhost:3306/flower";
    String DB_ID = "multi";
    String DB_PASSWORD = "abcd";

    class NormalItem {
        String prdName, prdImg, color, size;
        int quantity, prdNo;
        NormalItem(int prdNo, String prdName, String prdImg, String color, String size, int quantity) {
            this.prdNo = prdNo; this.prdName = prdName; this.prdImg = prdImg; this.color = color; this.size = size; this.quantity = quantity;
        }
    }
    List<NormalItem> normalItems = new ArrayList<>();

    class CustomItem {
        int cusNo, quantity;
        String cusName, cusimg, top_note, middle_note, base_note, volume, box_color;
        CustomItem(int cusNo, String cusName, String cusimg, String top_note, String middle_note, String base_note,
                   String volume, String box_color, int quantity) {
            this.cusNo = cusNo; this.cusName = cusName; this.cusimg = cusimg; this.top_note = top_note; this.middle_note = middle_note;
            this.base_note = base_note; this.volume = volume; this.box_color = box_color; this.quantity = quantity;
        }
    }
    List<CustomItem> customItems = new ArrayList<>();

    String ordRcvAddress1 = null;
    String ordRcvAddress2 = null;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="euc-kr">
    <title>환불 상세 정보</title>
    <style>
        @font-face {
            font-family: 'BookkMyungjo-Bd';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.0/BookkMyungjo-Bd.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }
        body {
            font-family: 'BookkMyungjo-Bd', serif;
            padding: 20px auto	;
            background: #f7f7f7;
        }

        h3 {
            margin-bottom: 10px;
            color: #444;
       
        }
        .box {
            width: 94%;
            margin: 20px auto;
            background: #fff;
            padding: 15px;
            border-radius: 8px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
            border-radius: 4px;
            overflow: hidden;
        }
        th, td {
            padding: 12px;
            text-align: center;
            border: 1px solid #e0e0e0;
            color: #333;
        }
        th {
            background-color: #f4f4f4;
            font-weight: bold;
        }
        td {
           
        }
      
        img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 6px;
        }
    </style>
</head>
<body>

<%
try {
    Class.forName("org.gjt.mm.mysql.Driver");
    conn = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);

    // 환불 기본 정보 조회
    pstmt = conn.prepareStatement("SELECT * FROM refund_request WHERE refund_id = ?");
    pstmt.setInt(1, refundId);
    rs = pstmt.executeQuery();

    if (rs.next()) {
%>
<div class="box">
    <h4>| 환불 계좌 정보</h4>
    <table>
        <tr><th>은행명</th><td><%= rs.getString("bank") != null ? rs.getString("bank") : "-" %></td></tr>
        <tr><th>예금주</th><td><%= rs.getString("account_holder") != null ? rs.getString("account_holder") : "-" %></td></tr>
        <tr><th>계좌번호</th><td><%= rs.getString("account_number") != null ? rs.getString("account_number") : "-" %></td></tr>
        <tr><th>환불금액</th><td><%= rs.getInt("refund_amount") %>원</td></tr>
        <tr><th>환불 사유</th><td><%= rs.getString("refund_reason") != null ? rs.getString("refund_reason") : "-" %></td></tr>
    </table>
</div>
<%
    }
    rs.close();
    pstmt.close();

    // 일반 상품 조회 (prdNo 추가)
    pstmt = conn.prepareStatement(
        "SELECT ri.quantity, p.prdNo, p.prdName, p.prdImg, m.color, m.size " +
        "FROM refund_item ri " +
        "JOIN product p ON ri.prdNo = p.prdNo " +
        "LEFT JOIN orderproduct op ON op.prdNo = ri.prdNo AND op.ordNo = ? " +
        "LEFT JOIN mapping_id m ON CAST(op.mapping_id AS UNSIGNED) = m.mappingId " +
        "WHERE ri.refund_id = ? AND ri.prdNo IS NOT NULL"
    );
    pstmt.setInt(1, ordNo);
    pstmt.setInt(2, refundId);
    rs = pstmt.executeQuery();

    while (rs.next()) {
        normalItems.add(new NormalItem(
            rs.getInt("prdNo"),
            rs.getString("prdName"),
            rs.getString("prdImg"),
            rs.getString("color"),
            rs.getString("size"),
            rs.getInt("quantity")
        ));
    }
    rs.close();
    pstmt.close();

    // 커스텀 상품 조회 (cusNo 추가)
    pstmt = conn.prepareStatement(
        "SELECT ri.quantity, c.cusNo, c.cusName, c.cusimg, c.top_note, c.middle_note, c.base_note, c.volume, c.box_color " +
        "FROM refund_item ri JOIN custom c ON ri.custom_prdNo = c.cusNo " +
        "WHERE ri.refund_id = ? AND ri.custom_prdNo IS NOT NULL"
    );
    pstmt.setInt(1, refundId);
    rs = pstmt.executeQuery();

    while (rs.next()) {
        customItems.add(new CustomItem(
            rs.getInt("cusNo"),
            rs.getString("cusName"),
            rs.getString("cusimg"),
            rs.getString("top_note"),
            rs.getString("middle_note"),
            rs.getString("base_note"),
            rs.getString("volume"),
            rs.getString("box_color"),
            rs.getInt("quantity")
        ));
    }
    rs.close();
    pstmt.close();

    // 배송 주소 조회
    pstmt = conn.prepareStatement("SELECT ordRcvAddress1, ordRcvAddress2 FROM orderinfo WHERE ordNo = ?");
    pstmt.setInt(1, ordNo);
    rs = pstmt.executeQuery();
    if (rs.next()) {
        ordRcvAddress1 = rs.getString("ordRcvAddress1");
        ordRcvAddress2 = rs.getString("ordRcvAddress2");
    }
    rs.close();
    pstmt.close();

%>

<% if (!normalItems.isEmpty()) { %>
<div class="box">
    <h4>| 환불 요청한 일반 상품</h4>
    <table>
        <thead>
            <tr>
                <th>상품 번호</th>
                <th>상품 이미지</th>
                <th>상품명</th>
                <th>수량</th>
                <th>색상</th>
                <th>사이즈</th>
            </tr>
        </thead>
        <tbody>
         <% for (NormalItem item : normalItems) {
            // 컬러 값을 URL 디코딩하여 색상명 변환
            String decodedColor = "";
            try {
                decodedColor = URLDecoder.decode(item.color, "UTF-8");
            } catch(Exception e) {
                decodedColor = item.color != null ? item.color : "";
            }
            String colorName = "";
            switch (decodedColor) {
                case "#F3F3F3":
                    colorName = "WHITE";
                    break;
                case "#F6F5EC":
                    colorName = "WHITE BEIGE";
                    break;
                case "#f3ECE3":
                    colorName = "BEIGE";
                    break;
                case "#C8A19C":
                    colorName = "ROSY";
                    break;
                case "#91766E":
                    colorName = "BROWN";
                    break;
                default:
                    colorName = "UNKNOWN";
                    break;
            }
        %>
            <tr>
                <td><%= item.prdNo %></td>
				
                <td><img src="<%= item.prdImg %>" alt="상품 이미지"></td>
                <td><%= item.prdName %></td>
                <td><%= item.quantity %></td>
                <td><%= colorName %></td>
                <td><%= item.size %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
<% } %>

<% if (!customItems.isEmpty()) { %>
<div class="box">
    <h4>| 환불 요청한 커스텀 상품</h4>
    <table>
        <thead>
            <tr>
                <th>커스텀 번호</th>
                <th>상품 이미지</th>
                <th>상품명</th>
                <th>수량</th>
                <th>Top Note</th>
				 <th>Middle Note</th>
				  <th>Base Note</th>
                <th>용량</th>
                <th>박스 색상</th>
            </tr>
        </thead>
        <tbody>
        <% for (CustomItem item : customItems) { %>
            <tr>
                <td><%= item.cusNo %></td>
                <td><img src="<%= item.cusimg %>" alt="커스텀 상품 이미지"></td>
                <td><%= item.cusName %></td>
                <td><%= item.quantity %></td>
				 <td><%= item.top_note %></td>
				  <td><%= item.middle_note %></td>
                <td> <%= item.base_note %></td>
                <td><%= item.volume %></td>
               <td><%= item.box_color.replace("%20", " ") %></td>

            </tr>
        <% } %>
        </tbody>
    </table>
</div>
<% } %>

<% if (ordRcvAddress1 != null && !ordRcvAddress1.isEmpty()) { %>
<div class="box">
    <h3>배송 주소</h3>
    <table>
        <tr><th>주소</th><td><%= ordRcvAddress1 %></td></tr>
        <tr><th>상세 주소</th><td><%= ordRcvAddress2 != null ? ordRcvAddress2 : "-" %></td></tr>
    </table>
</div>
<% } %>

<%
} catch (Exception e) {
    out.println("<div style='color:red; text-align:center;'>오류 발생: " + e.getMessage() + "</div>");
} finally {
    try { if (rs != null) rs.close(); } catch (SQLException e) {}
    try { if (pstmt != null) pstmt.close(); } catch (SQLException e) {}
    try { if (conn != null) conn.close(); } catch (SQLException e) {}
}
%>
</body>
</html>
