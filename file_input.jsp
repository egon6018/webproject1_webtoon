<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<title>회차 등록</title>
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
<form action="file_add_do.jsp" method="post" enctype="multipart/form-data">
<table border="1">
	<tr>
		<td colspan="3"><input type="submit" value=" 등 록 " onclick="showTitle()"></td>
	</tr>
	<tr>		
		<td>썸네일 등록<br><input type="file" name="fileName"></td>
		<td>제목 등록<br><input type="text" name="title"></td>
		<td>등록일 기입<br><input type="date" name="date"></td>
	</tr>
</table><br>
<table>
	<tr>
		<td id="picture">
			<input type="file" name="pictureName">
		</td>
	</tr>
</table>
</form>
</body>
</html>