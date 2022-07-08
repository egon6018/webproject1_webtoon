<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>웹툰 등록 화면</title>
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
<form action="home_add_do.jsp" method="post" enctype="multipart/form-data">
<table border="1">
	<tr>
		<td>썸네일 등록<br><input type="file" name="fileName"></td>	
	</tr>
	<tr>
		<td>웹툰 제목 등록: <input type="text" name="webtitle"></td>		
	</tr>
	<tr>
		<td>작가명 등록: <input type="text" name="name"></td>		
	</tr>	
</table>
<input type="submit" value=" 등 록 ">
</form>
</body>
</html>