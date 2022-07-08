<%@ page contentType="text/html; charset=UTF-8" 
		import="java.util.*,myBean.multipart.*"
		import="java.sql.*, java.io.*"
		errorPage="error.jsp"
%>
<%
request.setCharacterEncoding("utf-8");

int idx = Integer.parseInt(request.getParameter("idx"));
String webtitle = request.getParameter("webtitle");
String name = request.getParameter("name");

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

if(multiPart.getMyPart("fileName") != null) { //사용자가 새로운 파일을 지정한 경우
	//home 테이블에 저장된 idx 레코드의 파일명을 알아내어, 물리적 파일을 삭제함.
	sql = "SELECT savedFileName FROM home WHERE idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setInt(1,idx);
	rs=pstmt.executeQuery();	
	rs.next();
	String oldFileName=rs.getString("savedFileName");	
	File oldFile=new File(realFolder+File.separator+oldFileName);	
	oldFile.delete();	
	//새로운 파일명(original file name, UUID 적용 file name)과 데이터로 home 테이블 수정
	sql = "UPDATE home SET webtitle=?, name=?, originalFileName=?, savedFileName=? "
			+"WHERE idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, webtitle);
	pstmt.setString(2, name);	
	pstmt.setString(3, multiPart.getOriginalFileName("fileName"));
	pstmt.setString(4, multiPart.getSavedFileName("fileName"));	
	pstmt.setInt(5, idx);
	
} else { //fileName에 해당되는 Part 객체가 null이라면, 새로운 파일을 선택하지 않을 경우임
	//파일명을 제외한 title, date 정보 수정
	sql = "UPDATE home SET webtitle=?, name=? WHERE idx=?";
	pstmt=con.prepareStatement(sql);
	pstmt.setString(1, webtitle);
	pstmt.setString(2, name);	
	pstmt.setInt(3, idx);			
}

pstmt.executeUpdate(); // 쿼리 실행

if(pstmt != null) pstmt.close();
if(rs != null) rs.close();
if(con != null) con.close();

response.sendRedirect("home_fix_list.jsp");
%>