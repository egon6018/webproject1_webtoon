<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.Webtoon, java.sql.*"%>   
<%
request.setCharacterEncoding("utf-8");

String search = request.getParameter("search");

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
<title>메인 홈</title>
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

#image{width:110px; height:120px;}
</style>

<script>
function search(){
	var search_arr =[];
	search_arr[0] = document.getElementById("search_type").value;
	search_arr[1] = document.getElementById("search_value").value;
	if(search_arr[1] == null){
		alert("검색어를 입력하세요!!");
		return;
	}
	location.href="home.jsp?search=" + search_arr;
}
</script>
</head>
<body>
<form action="" method="post">
<input type="text" id="search_value" value="#작가명 또는 #타이틀로 웹툰 검색" size="40">
<button type="button" onClick="search()">검색</button>
<input type="button" value="게시판 관리" onclick="location.href='home_fix_list.jsp'">

<table border="1">
<%
while(rs.next()) {
%>
	<tr>
		<td>
		<a href="webtoon_list.jsp" style="text-decoration:none">
		<img src="./upload/<%=rs.getString("savedFileName")%>" style="width:80%" name="image">
		</a>
		</td>		
	</tr>
	<tr>
		<td id="search_type" name="search"><%=rs.getString("webtitle")%></td>	
	</tr>
	<tr>
		<td id="search_type" name="search"><%=rs.getString("name")%></td>		
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
</form>
</body>
</html>