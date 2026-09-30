	deleteWish.jsp
<%@ page contentType="text/html;charset=euc-kr" %>
	<%@ page import="java.sql.*" %>
	<html>
	<head>
		<title>위시리스트 비우기</title>
		<script type="text/javascript">
			function showAlertAndRedirect(message, url) {
				alert(message);
				window.location.href = url;
			}
		</script>
	</head>
	<body>
	<%
	try { 
		String DB_URL = "jdbc:mysql://localhost:3306/flower";
		String DB_ID = "multi"; 
		String DB_PASSWORD = "abcd";

		Class.forName("org.gjt.mm.mysql.Driver");  
		Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 

		String memId = (String) session.getAttribute("sid");

		if (memId == null) {
	%>
			<script>
				showAlertAndRedirect('로그인이 필요합니다. 로그인 페이지로 이동합니다.', 'login.jsp');
			</script>
	<%
			return;
		}

		String prdNo = request.getParameter("prdNo");
		if (prdNo == null) {
	%>
			<script>
				showAlertAndRedirect('상품 번호가 제공되지 않았습니다. 다시 시도해주세요.', 'showWish.jsp');
			</script>
	<%
			return;
		}

		String jsql = "DELETE FROM wish WHERE memId = ? AND prdNo = ?";   
		PreparedStatement pstmt = con.prepareStatement(jsql);
		pstmt.setString(1, memId);
		pstmt.setString(2, prdNo);
		
		int rowsAffected = pstmt.executeUpdate();
		
		if (rowsAffected > 0) {
	%>
			<script>
				showAlertAndRedirect('찜목록에서 삭제되었습니다.', 'mypage_wish.jsp');
			</script>
	<%
		} else {
	%>
			<script>
				showAlertAndRedirect('해당 상품이 존재하지 않습니다.', 'showWish.jsp');
			</script>
	<%
		}
	} catch (Exception e) {
	%>
		<script>
			showAlertAndRedirect('오류가 발생했습니다: <%= e.getMessage() %>', 'showWish.jsp');
		</script>
	<%
	}
	%>
	</body>
	</html>
