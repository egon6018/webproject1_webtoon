<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.Webtoon, java.sql.*"%>   
<%
   request.setCharacterEncoding("utf-8");

   Webtoon ro=new Webtoon();
   String webtitle=request.getParameter("webtitle");
   String name=request.getParameter("name");
   String genre=request.getParameter("genre");
   String plot=request.getParameter("plot");
   String words=request.getParameter("words");

   ro.setWebtitle(webtitle);
   ro.setName(name);
   ro.setGenre(genre);
   ro.setPlot(plot);
   ro.setWords(words);
   %>
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
<title>웹툰</title>
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

</head>
<body>

<table class="top">
	<tr>
		<td rowspan="6">
		<img src="./images/기본이미지.PNG" style="width:110px;height:120px">
		</td>
		<td>웹툰 타이틀: </td>
		<td>
		<input class="box" type="text" name="webtitle" size="60" readonly value="<%=ro.getWebtitle()%>">
		</td>	
		<td rowspan="6" id="navigation"><a href="home.jsp" id="navigation">Home버튼</a></td>		
	</tr>
	<tr>
		<td>작가명: </td>
		<td><input class="box" type="text" name="name" size="60" readonly value="<%=ro.getName()%>"></td>
	</tr>
	<tr>
		<td>장르: </td>
		<td><input class="box" type="text" name="genre" size="60" readonly value="<%=ro.getGenre()%>">
		</td>
	</tr>
	<tr>
		<td>줄거리: </td>
		<td><input class="box" type="text" name="plot" size="60" readonly value="<%=ro.getPlot()%>"></td>
	</tr>
	<tr>
		<td>작가의 말: </td>
		<td><input class="box" type="text" name="words" size="60" readonly value="<%=ro.getWords()%>">
		</td>
	</tr>	
</table><br>


<table class="bottom" border="1">
<%
while(rs.next()) {
%>
	<tr>
		<td><img src="./upload/<%=rs.getString("savedFileName")%>" style="width:80%"></td>
		<td style="width:70%"><a href="file.jsp" style="text-decoration:none"><%=rs.getString("title")%></a></td>
		<td><%=rs.getString("date")%></td>	
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