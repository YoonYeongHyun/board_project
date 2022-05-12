<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
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
	String memberId = (String) session.getAttribute("memberId");
	String pageNum = request.getParameter("pageNum");
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	String comment_content = request.getParameter("comment_content");
	
	BoardDAO boardDAO = BoardDAO.getInstance();
	BoardDTO board = boardDAO.getBoard(comment_num);
	board.setWriter(memberId);
	board.setContent(comment_content);
	boardDAO.insertReBoard(board);
	
	%>
	<script>
		location="boardContent.jsp?num=<%=num %>&pageNum=<%=pageNum%>";
	</script>
</body>
</html>