<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%
Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

Connection con=null;
PreparedStatement pstmt = null;
ResultSet rs=null;
try {
	//DB 연결자 정보를 획득한다.
	con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	//file 테이블에서 모든 필드의 레코드를 가져오는 퀴리 문자열을 구성한다. 
	String sql = "SELECT*FROM home";	
			
	//sql문을 실행하기 위한 PreparedStatement 객체를 생성한다.
	pstmt = con.prepareStatement(sql);

	//쿼리 실행
	rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home 수정화면</title>
<style>
body{
	background-color:#e6e6e6;
}
table{
	width:300px; height:200px; 
	text-align:center; 
	margin:auto;	
	border-collapse:collapse;
	border-style:solid;
	border-width:5px;
}
</style>

</head>
<body>
<form action="home.jsp" method="post" enctype="multipart/form-data">
<input type="button" value=" 웹툰 등록 " onclick="location.href='home_input.jsp'">
<table border="1">
<%
while(rs.next()) {
%>
	<tr>
		<td>	
			<input type="button" value=" 웹툰 수정 " 
					onclick="location.href='home_modify.jsp?idx=<%=rs.getInt("idx")%>'">		
			<input type="button" value=" 웹툰 삭제 " 
					onclick="location.href='home_delete_do.jsp?idx=<%=rs.getInt("idx")%>'">
		</td>		
	</tr>
	<tr>
		<td>		
		<img src="./upload/<%=rs.getString("savedFileName")%>" style="width:80%">
		</td>		
	</tr>
	<tr>
		<td><%=rs.getString("webtitle")%></td>		
	</tr>
	<tr>
		<td><%=rs.getString("name")%></td>		
	</tr>
<%
	}
	
	rs.close();
	pstmt.close();
	con.close();
}catch(SQLException e) {
	out.println(e);
}
%>
</table>
<input type="submit" value=" 저 장 ">
</form>
</body>
</html>