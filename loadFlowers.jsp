<%@ page contentType="application/json; charset=euc-kr" %>
<%@ page import="java.sql.*, org.json.JSONArray, org.json.JSONObject" %>

<%
    request.setCharacterEncoding("euc-kr");
    response.setContentType("application/json; charset=euc-kr");
    response.setCharacterEncoding("euc-kr");

    String season = request.getParameter("season");
    if (season == null) season = "spring";

    int start = 1, end = 10;
    switch (season) {
        case "summer": start = 11; end = 20; break;
        case "autumn": start = 21; end = 30; break;
        case "winter": start = 31; end = 40; break;
    }

    JSONArray flowerArray = new JSONArray();

    try {
        Class.forName("org.gjt.mm.mysql.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/flower?useUnicode=true&characterEncoding=euckr",
            "multi",
            "abcd"
        );
        String sql = "SELECT * FROM flowerbook WHERE prdNo BETWEEN ? AND ? ORDER BY prdNo ASC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, start);
        pstmt.setInt(2, end);
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            JSONObject obj = new JSONObject();
            obj.put("prdNo", rs.getInt("prdNo"));
            obj.put("flowerName", rs.getString("flowerName"));
            obj.put("flowerSub", rs.getString("flowerSub"));
            obj.put("flowerMeaning", rs.getString("flowerMeaning"));
            obj.put("flowerSubMeaning", rs.getString("flowerSubMeaning"));
            obj.put("flowerMeaningMore", rs.getString("flowerMeaningmore"));
            obj.put("flowerDescription", rs.getString("flowerDescription"));
            obj.put("flowerImage1", rs.getString("flowerImage1"));
            obj.put("flowerImage2", rs.getString("flowerImage2"));
            obj.put("flowerImage3", rs.getString("flowerImage3"));
            flowerArray.put(obj);
        }

        rs.close();
        pstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }

    out.print(flowerArray.toString());
%>
