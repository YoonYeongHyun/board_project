<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String writer = (String)session.getAttribute("memberId");
	%>
	<jsp:useBean id="board" class="board.BoardDTO"/>
	<jsp:setProperty property="*" name="board"/>

	<%
	BoardDAO boardDAO = BoardDAO.getInstance();
	boardDAO.insertBoard(board);
	if(num==0){ //원글일 경우
		response.sendRedirect("boardList.jsp");
	}else { //댓글일 경우
	%>
	<script>
		location="boardContent.jsp?num=<%=num %>&pageNum=<%=pageNum%>";
	</script>
	<%}
	%>
	
	
</body>
</html>