<%@page import="java.text.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 전체 보기 </title>
<style>
	@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Nanum+Gothic:wght@700&display=swap');
	#container {width:1000px; margin:0 auto;}
 	a {text-decoration : none; color:black}
 	#cnt{float:left; font-weight: bold}
	.m_title {font-family: 'Bebas Neue', cursive; text-align: center; font-size: 5em;}
	.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:1.5em; text-align: center;}
	.top_info {clear: both; text-align: right;}
	.s_id{font-weight: bold}
	
	/* 게시글 목록*/
	
	table{width:100%; border-bottom: 2px solid black;border-top: 2px solid black; border-collapse: collapse;}
	tr{height:40px;}
	td{border-bottom:1px solid #edd;}
	th{background: #eee;}
	#paging{text-align: center; margin-top: 20px}
	#p_box{display: inline-block; width:25px; height:25px; border-radius: 10px; padding:5px; margin:5px }
	#p_box:hover{background: black; color:white;}
	.p_box_c{background: black; color:white; }
	.p_box_b{font-weight: bold}
</style>
</head>
<script>
	
</script>
<body>
	<%
	String memberId = (String) session.getAttribute("memberId");
	if (memberId == null) { //세션이 null인 경우
		out.print("<script>alert('로그인 하세요');location='../logon/memberLoginForm.jsp'</script>");
	}
	//날짜형식 클래스
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	SimpleDateFormat sdf_today = new SimpleDateFormat("hh:mm");

	//페이징(paging) 처리
	int pageSize = 10;
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) pageNum = "1";

	int currentPage = Integer.parseInt(pageNum);    //현재페이지
 	int startRow = (currentPage -1) * pageSize + 1; //현재페이지의 첫행
	int endRow = currentPage * pageSize;            //현재페이지의 마지막행
	
	
	BoardDAO boardDAO = BoardDAO.getInstance();
	
	//전체 글수
	int cnt = boardDAO.getBoardCount();
	
	
	// 게시판 전체 정보를 currentPage의  pageSize만큼 획득 
	List<BoardDTO> boardList = boardDAO.getBoardList(startRow, pageSize);
	int number = cnt - (currentPage-1) * pageSize;
	
	
	%>
	<div class="m_title">
		<a href="#">coder</a>
	</div>
	<div class="s_title">전체 게시판</div>
	<br>

	<div id="container">
		<div class="top_info">
			<span id="cnt">게시판 글수: <%=cnt%></span> <span class="s_id"><a
				href="../member/memberInfoForm.jsp?pageNum=<%=pageNum%>"><%=memberId%></a></span>&emsp; <a
				href="../logon/memberLogout.jsp">로그아웃</a>&emsp; <a
				href="boardWriteForm.jsp?pageNum=<%=pageNum%>">글등록</a>
		</div>
		<br>
		<table>
			<tr>
				<th width="10%">번호</th>
				<th width="50%">제목</th>
				<th width="10%">작성자</th>
				<th width="15%">작성일</th>
				<th width="10%">조회수</th>
			</tr>
			<%
			if (boardList.size() == 0) {
			%>
			<tr>
				<td colspan="5">등록된 글이 없습니다.</td>
			</tr>
			<%
			} else {
				for (BoardDTO board : boardList) {
					int num = board.getNum();
					int ref = board.getRef();
					int num2 = boardDAO.getBoardReCount(ref);
					String re_num;
					if(num2 != 0){
						re_num = "(" + num2 + ")";
					}else re_num = "";
			%>
			<tr>
				<td style="text-align: right; margin-right: 20px"><%=number--%>&ensp;&ensp;</td>
				<td>
					<a href="boardContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>"> <%=board.getSubject()%> <%=re_num%></a>
					<%
					if (board.getReadCount() > 20) {
					out.print("<img src='../images/hot.png' width='16' heigth='16'>");
					}
					%>
				</td>
				<td style="text-align: center"><%=board.getWriter()%></td>
				<td style="text-align: center"><%=sdf.format(board.getRegDate())%></td>
				<td style="text-align: center"><%=board.getReadCount()%></td>
			</tr>
				<%}%>
			<%}%>

		</table>
		<div id="paging">
		<%
		if(cnt > 0){
			int pageCount =(cnt/pageSize) + (cnt%pageSize==0 ? 0 : 1);	
			int pageBlock = 10;
			
			//시작페이지 설정
			int startPage = 1;
			if(currentPage % 10 != 0) startPage = (currentPage/10) * 10 +1;
			else startPage = (currentPage/10 -1) * 10 +1;
			
			//끝페이지 설정
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount) endPage = pageCount;
			
			//이전&첫 페이지
			if(startPage > 10){%>
				<a href='boardList.jsp?pageNum=<%=1 %>'><div id='p_box' class='p_box_b' title='첫 페이지'>≪</div></a>
				<a href='boardList.jsp?pageNum=<%=startPage-10 %>'><div id='p_box' class='p_box_b'title='이전 페이지'>＜</div></a>
			<%}
			//페이징블럭처리
			for (int i=startPage; i<=endPage; i++){
				if(currentPage == i){
					%><div id='p_box' class='p_box_c'><%=i %></div><%
				} else{
					%><a href='boardList.jsp?pageNum=<%=i %>'><div id='p_box'> <%=i %> </div></a><% 
				}
			}

			//다음&마지막 페이지
			if(endPage <= pageCount - (pageCount % pageSize)){%>
				<a href='boardList.jsp?pageNum=<%=startPage+10%>'><div id='p_box' class='p_box_b' title='다음 페이지'>＞</div></a>
				<a href='boardList.jsp?pageNum=<%=pageCount%>'><div id='p_box' class='p_box_b' title='끝 페이지'>≫</div></a>
			<%}
			//
		}
		%>
		</div>
	</div>
</body>
</html>


