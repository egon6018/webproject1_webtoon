<%@ page contentType="text/html;charset=utf-8"
		import="java.sql.*" errorPage="error.jsp" %>
<%
request.setCharacterEncoding("utf-8");

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
	String sql = "SELECT title, date, savedFileName, savedPictureName "
			+"FROM file";	
			
	//sql문을 실행하기 위한 PreparedStatement 객체를 생성한다.
	pstmt = con.prepareStatement(sql);		
	
	//쿼리 실행
	rs = pstmt.executeQuery();
%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 회차</title>
<style>
body{
	background-color:#e6e6e6;
}
table{
	border-width:5px;
	border-style:solid;
	border-color:black;
	width:80%;
	margin:auto;
	font-weight:bold;
	font-size:20px;
	text-align:center;
}
#picture{
	width:60%;
	height:400px;
	position:"static";
	border-radius:10px;
	border-style:double;
	border-width:5px;
	margin:auto;
	
}
</style>

</head>
<body>
<table border="1">	
<%
while(rs.next()) {
%>
	<tr>				
		<td><img src="./upload/<%=rs.getString("savedFileName")%>"></td>		
		<td>제목<br><input type="text" name="title" value="<%=rs.getString("title")%>"></td>
		<td>등록일<br><input type="date" name="date" value="<%=rs.getString("date")%>"></td>
	</tr>
</table><br>
<table>
	<tr>
		<td id="picture">
			<img src="./upload/<%=rs.getString("savedPictureName")%>">
		</td>
	</tr>
</table>
<%
	}
	
	rs.close();
	pstmt.close();
	con.close();
}catch(SQLException e) {
	out.println(e);
}
%>
</body>
</html>
