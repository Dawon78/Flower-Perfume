<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*, java.util.*" %>
<%@ page import="java.util.List, java.util.ArrayList" %>
<%
    String id = (String) session.getAttribute("sid");  // 로그인한 사용자 ID 가져오기
    List<Integer> wishlist = new ArrayList<>();

    if (id != null) {  // 로그인한 경우에만 실행
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        try (Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
             PreparedStatement stmt = con.prepareStatement("SELECT prdNo FROM wish WHERE memId = ?")) {
            stmt.setString(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    wishlist.add(rs.getInt("prdNo"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    request.setAttribute("wishlist", wishlist);  // 찜 목록을 request에 저장
%>

