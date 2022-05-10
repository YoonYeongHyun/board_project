<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Nanum+Gothic:wght@700&display=swap')
	;

.m_title {
	font-family: 'Bebas Neue', cursive;
	text-align: center;
	font-size: 5em;
}

a {
	text-decoration: none;
	color: black
}

.s_title {
	font-family: 'Nanum Gothic', sans-serif;
	font-size: 1.5em;
	text-align: center;
}

#container {
	width: 1000px;
	margin: 50px auto;
	padding: 30px;
	border: 1px solid gray;
	border-radius: 10px;
}

textarea:focus {
	outline: none;
}

textarea {
	padding: 5px;
	margin-top: 10px;
	width: 80%;
	box-sizing: border-box;
}

#subject {
	padding: 5px;
	margin-top: 10px;
	width: 100%;
	box-sizing: border-box;
}

#writer {
	float: right;
}

#content_box {
	height: 300px
}

.btns {
	text-align: center
}

.btns input[type="button"] {
	border: none;
	border-radius: 10px;
	width: 80px;
	height: 30px;
	background: #FFE0B2;
	font-weight: bold;
}

.re_input {
	height: 80px;
	box-sizing: border-box;
	position: relative;
}

#re_text {
	height: 80px;
	margin: 0;
	padding: 10px;
}

#re_btn {
	display: inline-block;
	height: 100%;
	box-sizing: border-box;
	position: absolute;
	top: 0px;
	right: 20px
}
</style>

	<%
		String memberId = (String) session.getAttribute("memberId");
	if (memberId == null) { //세션이 null인 경우
		out.print("<script>alert('로그인 하세요');location='../logon/memberLoginForm.jsp'</script>");
	}
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null)
		pageNum = "1";

	int num = Integer.parseInt(request.getParameter("num"));
	BoardDAO boardDAO = BoardDAO.getInstance();
	BoardDTO board = boardDAO.getBoard(num);

	// 원글의 정보
	int ref = board.getRef();
	int re_step = board.getRe_step();
	int re_level = board.getRe_level();
	String writer = board.getWriter();
	
	List<BoardDTO> boardList = boardDAO.getBoardList2(ref);
	%>
	<script>
	document.addEventListener("DOMContentLoaded", function(){
		let form = document.contentForm; 
		let num = form.num.value;
		let ref = form.ref.value;
		let re_step = form.re_step.value;
		let re_level = form.re_level.value;
		let pageNum = form.pageNum.value;
		
	    let btn_update = document.getElementById("btn_update");
	    let btn_delete = document.getElementById("btn_delete");
	    let btn_boardList = document.getElementById("btn_boardList");
	    let btn_comment = document.getElementById("btn_comment");
	    let re_btn = document.getElementById("re_btn");
	    
	    
	    btn_update.style.display = 'none';
	    btn_delete.style.display = 'none';
	    
	    if('<%=memberId%>' == '<%=writer%>') {
				btn_update.style.display = 'inline-block';
				btn_delete.style.display = 'inline-block';
			}

			btn_update.addEventListener("click", function() {
				form.action = 'boardUpdateForm.jsp';
				form.submit();
				//location = 'boardUpdateForm.jsp?num=' + num + '&pageNum=' + pageNum;
			});

			btn_delete.addEventListener("click", function() {
				if (confirm('정말로 삭제 하시겠습니까?')) {
					//location = 'boardDelete.jsp?num=' + num + '&pageNum=' + pageNum;
					form.action = 'boardDelete.jsp';
					form.submit();
				}
			});

			btn_boardList.addEventListener("click", function() {
				location = 'boardList.jsp?pageNum=' + pageNum;
			});

			btn_comment.addEventListener("click", function() {
				form.submit();
			});

			re_btn.addEventListener("click", function() {

			});

		});
	</script>
</head>
<body>
	<div class="m_title">
		<a href="#">coder</a>
	</div>
	<div class="s_title">글 상세보기</div>
	<div id="container">
		<form action="boardWriteForm.jsp" method="post" name="contentForm">
			<input type="hidden" name="num" value="<%=board.getNum()%>">
			<input type="hidden" name="ref" value="<%=ref%>"> <input
				type="hidden" name="re_step" value="<%=re_step%>"> <input
				type="hidden" name="re_level" value="<%=re_level%>"> <input
				type="hidden" name="pageNum" value="<%=pageNum%>">
			<div class="info">
				<h2 id><%=board.getSubject()%></h2>
			</div>
			<div class='info'>
				<span id="info_top"><%=board.getWriter()%></span> <br> <span
					id="info_bottom"><%=sdf.format(board.getRegDate())%> 조회 <%=board.getReadCount()%></span>
			</div>
			<hr>
			<div id="content_box">
				<%=board.getContent()%>
			</div>

			<div class="btns">
				<input type="button" value="댓글 작성" class="personal_btns"
					id="btn_comment">&emsp;&emsp; <input type="button"
					value="글 수정" class="personal_btns" id="btn_update">&emsp;&emsp;
				<input type="button" value="글 삭제" class="personal_btns"
					id="btn_delete">&emsp;&emsp; <input type="button"
					value="게시글보기" id="btn_boardList">
			</div>


			<%
				for (BoardDTO boardL : boardList) {
				if ((ref == boardL.getRef()) && (boardL.getRe_step() > 0)) {
					int num1 = boardL.getNum();
					int num2 = boardL.getRe_level();
					int width = 0;
					if (num2 > 0) {//댓글이라면
				width = num2 * 10;
				out.print("<div width='" + width + "' heigth='16'></div>");
				//out.print("<img src='../images/level.png' width='" + width + "' heigth='16'>");
				//out.print("<img src='../images/level.png' width='" + width + "' heigth='16'>");
				//out.print("<img src='../images/re.png'>");
					}
			%>
			<div class="re_box">
				<span><%=boardL.getWriter()%></span> <span><%=sdf.format(boardL.getRegDate())%></span>
				<br>
				<%=boardL.getContent()%>
			</div>
			<%
				}
			}
			%>
			<br>
			<div class="re_input">
				<textarea id="re_text" placeholder="댓글을 입력해주세요"></textarea>
				<input id="re_btn" type="button" value="댓글 작성2" id="btn_comment2">
			</div>

		</form>
	</div>

</body>
</html>