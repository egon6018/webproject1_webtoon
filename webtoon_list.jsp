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
	String sql = "SELECT*FROM file";		
			
	//sql문을 실행하기 위한 PreparedStatement 객체를 생성한다.
	pstmt = con.prepareStatement(sql);

	//쿼리 실행
	rs = pstmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 페이지 수정</title>
<style>
body{
	background-color:#e6e6e6;
}
table.top{	
	width:70%;
	margin:auto;
}
table.bottom{
	border-style:double;
	border-color:#f2f2f2;
	width:80%;
	margin:auto;
	font-weight:bold;
	font-size:20px;
	text-align:center;
}
.box{
	margin:auto;
	background-color:#f2f2f2;
}
#button{
	text-decoration:none;
	font-weight:bold;
	font-size:15px;
	color:black;
	border-style:outset;
	border-color:lightgray;
}
#navigation{
	text-decoration:none;
	text-align:center;
	font-size:15px;
	font-weight:bold;
	border-style:outset;
	background-color:#66ccff;
}
</style>

<script>
function show(){
	var obj=document.getElementById("webtitle");
	var str="";
	str+="웹툰 타이틀: "+obj.value+"\n";
	
	obj=document.getElementById("name");
	str+="작가명: "+obj.value+"\n";
	
	obj=document.getElementById("genre");
	str+="장르: "+obj.value+"\n";
	
	obj=document.getElementById("plot");
	str+="줄거리: "+obj.value+"\n";
	
	obj=document.getElementById("words");
	str+="작가의 말: "+obj.value+"\n";
	
	alert(str);
	return false;
}
</script>
</head>
<body>
<form action="webtoon.jsp" method="post" enctype="multipart/form-data">
<table class="top">
	<tr>
		<td rowspan="6">
		<img src="./images/기본이미지.PNG" style="width:110px;height:120px">	
		</td>
		<td>웹툰 타이틀: </td>
		<td>
		<input class="box" type="text" id="webtitle" name="webtitle" size="60">
		</td>
		<td rowspan="6"><a href="file_input.jsp" id="button" style="font-size:20px;border-style:none">등록</a></td>
		<td rowspan="6" id="navigation"><a href="home.jsp" id="navigation">Home버튼</a></td>	
	</tr>
	<tr>
		<td>작가명: </td>
		<td><input class="box" type="text" id="name" name="name" size="60"></td>
	</tr>
	<tr>
		<td>장르: </td>
		<td><input class="box" type="text" id="genre" name="genre" size="60">
		</td>
	</tr>
	<tr>
		<td>줄거리: </td>
		<td><input class="box" type="text" id="plot" name="plot" size="60"></td>
	</tr>
	<tr>
		<td>작가의 말: </td>
		<td><input class="box" type="text" id="words" name="words" size="60">
		</td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value=" 저 장 " onclick="show()"></td>
	</tr>
</table><br>
</form>

<table class="bottom" border="1">
<%
while(rs.next()) {
%>
	<tr>
		<td><img src="./upload/<%=rs.getString("savedFileName")%>" style="width:80%"></td>
		<td style="width:70%"><%=rs.getString("title")%></td>
		<td><%=rs.getString("date")%></td>
		<td><input type="button" value="수정" 
					onclick="location.href='file_modify.jsp?idx=<%=rs.getInt("idx")%>'"></td>
		<td><input type="button" value="삭제" 
					onclick="location.href='file_delete_do.jsp?idx=<%=rs.getInt("idx")%>'"></td>
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
</body>
</html>