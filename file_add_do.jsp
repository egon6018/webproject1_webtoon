<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="myBean.File, java.sql.*, java.util.*, myBean.multipart.*"%>
<jsp:useBean id="f" class="myBean.File" scope="session"/>
<jsp:setProperty name="f" property="*"/>
<%
request.setCharacterEncoding("utf-8");

//File f=new File();
//f.setTitle(title);
//f.setDate(date);

Class.forName("org.mariadb.jdbc.Driver");
String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
String DB_USER = "admin";
String DB_PASSWORD= "1234";

//사용자가 title, date 파라미터에 전송한 값 알아내기
String title=request.getParameter("title");
String date=request.getParameter("date");

//upload 이름을 가지는 실제 서버의 경로명 알아내기 
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");	

//multipart/form-data 유형의 클라이언트 요청에 대한 모든 Part 구성요소를 가져옴.
Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts,realFolder);

String originalFileName="";
String originalPictureName="";
String savedFileName="";
String savedPictureName="";

if(multiPart.getMyPart("fileName") != null && multiPart.getMyPart("pictureName") != null) {  //클라이언트에서 업로드한 파일이 없으면 null 임
	//클라이언트가 전송한 원래 파일명 알아내기
	originalFileName = multiPart.getOriginalFileName("fileName");
	originalPictureName = multiPart.getOriginalFileName("pictureName");
	
	//서버에 저장된 파일 이름 알아내기(UUID적용된 파일명)
	savedFileName =  multiPart.getSavedFileName("fileName");
	savedPictureName =  multiPart.getSavedFileName("pictureName");
}

//DB 연결자 생성(이곳에 빈즈나 Connection Pool로 대체 가능)
Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
//title, date, originalFileName, savedFileName을 저장하기 위한 insert 문자열 구성
String sql = "INSERT INTO file(title, date, originalFileName, savedFileName, originalPictureName, savedPictureName)"
				+"VALUES(?, ?, ?, ?, ? ,?)";
	
PreparedStatement pstmt = con.prepareStatement(sql);

//pstmt의 SQL 쿼리 구성
pstmt.setString(1, title);
pstmt.setString(2, date);
pstmt.setString(3, originalFileName);
pstmt.setString(4, savedFileName);
pstmt.setString(5, originalPictureName);
pstmt.setString(6, savedPictureName);

//쿼리 실행
pstmt.executeUpdate();

pstmt.close();
con.close();

response.sendRedirect("webtoon_list.jsp");
%>
