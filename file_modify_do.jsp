<%@ page contentType="text/html; charset=UTF-8" 
		import="java.util.*,myBean.multipart.*"
		import="java.sql.*, java.io.*"
		errorPage="error.jsp"
%>
<%
request.setCharacterEncoding("utf-8");

int idx = Integer.parseInt(request.getParameter("idx"));
String title = request.getParameter("title");
String date = request.getParameter("date");

ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");

//Part API를 사용하여 클라이언트로부터 multipart/form-data 유형의 전송 받은 파일 저장
Collection<Part> parts = request.getParts();
MyMultiPart multiPart = new MyMultiPart(parts,realFolder);

Class.forName("org.mariadb.jdbc.Driver");
String url = "jdbc:mariadb://localhost:3306/webtoon?useSSL=false";
Connection con = DriverManager.getConnection(url, "admin", "1234");
PreparedStatement pstmt = null;
ResultSet rs = null;
String sql = null;

if(multiPart.getMyPart("fileName") != null || multiPart.getMyPart("pictureName") != null) { //사용자가 새로운 파일을 지정한 경우
	//file 테이블에 저장된 idx 레코드의 파일명을 알아내어, 물리적 파일을 삭제함.
	sql = "SELECT savedFileName, savedPictureName FROM file WHERE idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1,idx);
	rs=pstmt.executeQuery();	
	rs.next();
	String oldFileName = rs.getString("savedFileName");	
	String oldPictureName = rs.getString("savedPictureName"); 
	File oldFile=new File(realFolder+File.separator+oldFileName);
	File oldPicture = new File(realFolder+File.separator+oldPictureName);
	oldFile.delete();	
	oldPicture.delete();
	//새로운 파일명(original file name, UUID 적용 file name)과 데이터로 file 테이블 수정
	sql = "UPDATE file SET title=?, date=?, originalFileName=?, savedFileName=?, originalPictureName=?, savedPictureName=? "
			+"WHERE idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, date);	
	pstmt.setString(3, multiPart.getOriginalFileName("fileName"));
	pstmt.setString(4, multiPart.getSavedFileName("fileName"));	
	pstmt.setString(5, multiPart.getOriginalFileName("pictureName"));
	pstmt.setString(6, multiPart.getSavedFileName("pictureName"));	
	pstmt.setInt(7, idx);
	
} else { //fileName에 해당되는 Part 객체가 null이라면, 새로운 파일을 선택하지 않을 경우임
	//파일명을 제외한 title, date 정보 수정
	sql = "UPDATE file SET title=?, date=? WHERE idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, date);	
	pstmt.setInt(3, idx);			
}

pstmt.executeUpdate(); // 쿼리 실행

if(pstmt != null) pstmt.close();
if(rs != null) rs.close();
if(con != null) con.close();

response.sendRedirect("webtoon_list.jsp");
%>