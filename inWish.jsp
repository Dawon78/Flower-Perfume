<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <script type="text/javascript">
        function showLoginAlert() {
            alert("찜목록에 담기 위해서는 로그인이 필요합니다!");
            window.location.href = "login.jsp"; 
        }

        function goBackWithoutAlert() {
            window.history.back();  // 이전 페이지로 돌아가기
        }
    </script>
</head>
<body>

<%
    String id = (String) session.getAttribute("sid");
    if (id == null) {
    
%>
    <script>
        showLoginAlert();
    </script>
<%
    } else {
        String DB_URL = "jdbc:mysql://localhost:3306/flower";
        String DB_ID = "multi";
        String DB_PASSWORD = "abcd";

        String prdNo = request.getParameter("prdNo");
        String action = request.getParameter("action");  // 'add' 또는 'remove' 확인

        String memId = id; 

        if (prdNo == null || memId == null || action == null) {
%>
    <script>
        goBackWithoutAlert(); 
    </script>
<%
        } else {
            try (Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD);
                 PreparedStatement checkStmt = con.prepareStatement("SELECT * FROM wish WHERE memId=? AND prdNo=?");
                 PreparedStatement insertStmt = con.prepareStatement("INSERT INTO wish (prdNo, memId) VALUES (?, ?)");
                 PreparedStatement deleteStmt = con.prepareStatement("DELETE FROM wish WHERE memId=? AND prdNo=?")) {

                Class.forName("org.gjt.mm.mysql.Driver");

                checkStmt.setString(1, memId);
                checkStmt.setString(2, prdNo);

                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (action.equals("remove") && rs.next()) {
                        // 삭제
                        deleteStmt.setString(1, memId);
                        deleteStmt.setString(2, prdNo);
                        deleteStmt.executeUpdate();
                    } else if (action.equals("add") && !rs.next()) {
                        // 추가
                        insertStmt.setString(1, prdNo);
                        insertStmt.setString(2, memId);
                        insertStmt.executeUpdate();
                    }
                }

                // 세션에 위시리스트 상태 저장
                if (action.equals("add")) {
                    session.setAttribute("wish_" + prdNo, true);  // 추가된 상품은 true
                } else if (action.equals("remove")) {
                    session.removeAttribute("wish_" + prdNo);  // 삭제된 상품은 세션에서 제거
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<script>goBackWithoutAlert();</script>"); 
            }
        }
    }
%>

    <script>
        // 위시리스트 처리 후 이전 페이지로 이동
        goBackWithoutAlert();  // 이전 페이지로 돌아가기
    </script>

</body>
</html>
