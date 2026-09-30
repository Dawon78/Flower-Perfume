<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>

<%
boolean isExist = false;

try {
    	String DB_URL="jdbc:mysql://localhost:3306/flower";   // 접속 DB는 project
        String DB_ID="multi"; 
        String DB_PASSWORD="abcd"; 
 	 
	    Class.forName("org.gjt.mm.mysql.Driver");  
 	    Connection con = DriverManager.getConnection(DB_URL, DB_ID, DB_PASSWORD); 
        
	    String id = request.getParameter("id");
	    
		String jsql = "select * from member where memId = ?";   
        PreparedStatement  pstmt  = con.prepareStatement(jsql);
	    pstmt.setString(1, id);

	    ResultSet rs = pstmt.executeQuery();  	
        
        if(rs.next())              //   레코드(동일한 ID)가 존재하면
              isExist = true;
        else                          //   레코드(동일한 ID)가 존재하지 않으면  
             isExist = false;

    } catch (Exception e) {
        	out.println(e);
}
%>

<html>
<head>
<title>사용자 ID 중복 검사</title>
</head>

<body bgcolor="#ffffff">
<br>
<table width="228" border="0" cellspacing="1" cellpadding="3" height="50" style="font-size:10pt;font-family:맑은 고딕">
    <tr>
        <td height="25" align=center >
          ID:  <%=request.getParameter("id")%>
        </td>
    </tr>
    
    <tr>
        <td height="25" align=center>
  <%  
		   if(isExist)  
                 out.println("이미 존재하는 ID입니다.");
	       else 
                 out.println("사용 가능한 ID입니다. ");
  %>
        </td>
    </tr>

    <tr>
        <td align=center>
            <a href="javascript:window.close()"><img src=".\images\confirm.gif" border=0></a>
        </td>
    </tr>
</table>
</body>
</html>