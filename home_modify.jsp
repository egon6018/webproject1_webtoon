<%@ page contentType="text/html;charset=utf-8"
		import="java.sql.*" errorPage="error.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

Connection con = DriverManager.getConnection(url, "admin", "1234");

//file테이블에서 idx에 해당하는 레코드 검색하기 위한 SQL문 구성 
String sql = "SELECT webtitle, name, originalFileName, savedFileName "
				+"FROM home WHERE idx=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,idx);

//쿼리 실행
ResultSet rs = pstmt.executeQuery();

//레코드 오프셋 커서 이동
rs.next();

%>		
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 수정 화면</title>
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
caption{
	font-weight:bold;
	font-size:20px;
}
</style>
</head>
<body>
<form action="home_modify_do.jsp" method="post" enctype="multipart/form-data">
<table border="1">
	<tr>
		<td><input type="hidden" name="idx" value="<%=idx%>"></td>
	</tr>	
	<tr>
		<td>원본 썸네일<br><img src="./upload/<%=rs.getString("savedFileName")%>" style="width:80%"></td>
		<td>썸네일 변경<br><input type="file" name="fileName"></td>			
	</tr>
	<tr>
		<td>웹툰 제목 수정: <input type="text" name="webtitle" value="<%=rs.getString("webtitle")%>"></td>		
	</tr>
	<tr>
		<td>작가명 수정: <input type="text" name="name" value="<%=rs.getString("name")%>"></td>	
	</tr>	
</table>
<input type="submit" value=" 수 정 ">
</form>
</body>
</html>
<%
rs.close();
pstmt.close();
con.close();
%>