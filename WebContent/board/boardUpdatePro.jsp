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

	
	<%request.setCharacterEncoding("UTF-8");%>
	<jsp:useBean id="board" class="board.BoardDTO"/>
	<jsp:setProperty property="*" name="board"/>
	
	<% 
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) pageNum = "1";
	BoardDAO boardDAO = BoardDAO.getInstance();
	boardDAO.updateBoard(board);
	%>
	<script>
		alert('해당 글이 수정되었습니다.');
		location = "boardList.jsp?pageNum=<%= pageNum%>";
	</script>
</body>
</html>