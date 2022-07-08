<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*, java.io.*"%>

<%
//전체 만들어 보기
request.setCharacterEncoding("utf-8");		//URL 인코딩 : UTF-8. MariaDB 인코딩 : utf8

try {
	//사용자가 get방식으로 전달한 idx값 알아내기 
	String idx = request.getParameter("idx");
 
	//JDBC Driver 로드
	Class.forName("org.mariadb.jdbc.Driver");	
  
	String DB_URL = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
	String DB_USER = "admin";
	String DB_PASSWORD= "1234";
 
	//연결자 정보 획득
	Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
	
	//idx에 해당하는 삭제할 파일명 savedFileName을 file 테이블에서 알아내기 위한 쿼리 문자열 구성
	String sql = "SELECT savedFileName FROM file WHERE idx=?";
	
	//PerparedStatement 객체 알아내기.
	PreparedStatement pstmt = con.prepareStatement(sql);
	
	//PreparedStatement 객체의 쿼리 문자열 중 첫번째인  idx 값 설정하기
	pstmt.setInt(1,Integer.parseInt(idx));
	
	//쿼리 실행
	ResultSet rs = pstmt.executeQuery();
	
	//레코드 커서 이동시키기
	rs.next();
	
	//삭제할 savedFileName 필드의 값(UUID 적용된 파일명) 알아내기
	String filename = rs.getString("savedFileName");
	 
	//upload 이름을 가지는 실제 서버의 경로명 알아내기
	ServletContext context = getServletContext();
	String realFolder = context.getRealPath("upload");
	
	//앞에서 알아낸 서버의 경로명과 파일명으로 파일 객체 생성하기
	File file = new File(realFolder+File.separator+filename);
	
	//파일 삭제
	file.delete();
	
	//file 테이블에서 지정한 idx의 레코드를 삭제하기 위한 쿼리 문자열 구성하기
	sql = "DELETE FROM file WHERE idx=?";
	
	//PreparedStatement 객체 알아내기
	pstmt = con.prepareStatement(sql);
	
	//PreparedStatement 객체의 쿼리 문자열 중 첫번째인  idx 값 설정하기
	pstmt.setInt(1,Integer.parseInt(idx));
	
	//쿼리 실행
	pstmt.executeUpdate();
	
	rs.close();
	pstmt.close();
	con.close();
} catch (SQLException e) {
	//SQL에 대한 오류나, DB 연결 오류 등이 발생하면, 그 대처 방안을 코딩해 준다.
	out.println(e.toString());
	return;
} catch (Exception e) { 
	//SQLException 이외의 오류에 대한 대처 방안을 코딩해 준다.
	out.println(e.toString());
	return;
}

/* 오류 발생하거나 화면에 아무것도 나타나지 않으면 이곳을  주석 처리하여 오류를 확인할 것 */
response.sendRedirect("webtoon_list.jsp");   
%> 