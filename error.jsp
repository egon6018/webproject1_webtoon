<%@ page contentType="text/html; charset=UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오류 출력 페이지</title>

</head>
<body>
<h1>오류 메시지</h1>
<%=exception.toString() %>
</body>
</html>