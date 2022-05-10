<%@page import="board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) pageNum = "1";
	
	int num = Integer.parseInt(request.getParameter("num"));
	BoardDAO boardDAO = BoardDAO.getInstance();
	boardDAO.deleteBoard(num);
%>
<script>
	alert("해당 글이 삭제되었습니다.");
	location="boardList.jsp?pageNum=" + <%=pageNum%>;
</script>
</body>
</html>