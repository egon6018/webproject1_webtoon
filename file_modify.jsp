<%@ page contentType="text/html;charset=utf-8"
		import="java.sql.*" errorPage="error.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int idx = Integer.parseInt(request.getParameter("idx"));

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";

Connection con = DriverManager.getConnection(url, "admin", "1234");

//file테이블에서 idx에 해당하는 레코드 검색하기 위한 SQL문 구성 
String sql = "SELECT title, date, originalFileName, savedFileName, originalPictureName, savedPictureName "
				+"FROM file WHERE idx=?";
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
<title>파일 수정</title>
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

<script>
function showTitle(){
	var obj=document.getElementById("title");
	var str="";
	str+="제목: "+obj.value+"\n";
	
	alert(str);
	return false;
}
function showDate(){
	var obj=document.getElementById("date");
	var str="";
	str+="날짜: "+obj.value+"\n";
	
	alert(str);
	return false;
}
</script>
</head>
<body>
<form action="file_modify_do.jsp" method="post" enctype="multipart/form-data">
<table border="1">
	<tr>
		<td colspan="5"><input type="submit" value=" 수 정 " onclick="showTitle()"></td>
	</tr>
	<tr>		
		<td><input type="hidden" name="idx" value="<%=idx%>"></td>
		<td>원본 썸네일<br><img src="./upload/<%=rs.getString("savedFileName")%>" style="width:80%"></td>
		<td>썸네일 변경<br><input type="file" name="fileName"></td>
		<td>제목 수정<br><input type="text" name="title" value="<%=rs.getString("title")%>"></td>
		<td>등록일 수정<br><input type="date" name="date" value="<%=rs.getString("date")%>"></td>
	</tr>
</table><br>
<table>
	<tr>
		<td id="picture">
			원본 그림 파일<br><img src="./upload/<%=rs.getString("savedPictureName")%>"><br>
			변경된 그림 파일<br><input type="file" name="pictureName">
		</td>
	</tr>
</table>
</form>
</body>
</html>
<%
rs.close();
pstmt.close();
con.close();
%>