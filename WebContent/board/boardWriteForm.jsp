<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록 폼</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Do+Hyeon&family=Nanum+Gothic:wght@700&display=swap');	
.m_title {font-family: 'Bebas Neue', cursive; text-align: center; font-size: 5em;}
a {text-decoration : none; color:black}

.s_title {font-family: 'Nanum Gothic', sans-serif; font-size:1.5em; text-align: center;}
#container{width:500px; margin: 50px auto; padding:30px;background: #eee; border:1px solid gray;
          border-radius: 10px;}
input:focus, textarea:focus {outline: none;}
textarea {padding:5px;margin-top: 10px; width:100%;box-sizing: border-box;}
#subject {padding:5px;margin-top: 10px; width:100%;box-sizing: border-box;} 
#writer {float: right;}
.btns{text-align: center}
.btns input[type="button"] {border:none; border-radius:10px; width:80px; height:30px; background:#FFE0B2; font-weight: bold; }
</style>
<script>

<%
String pageNum = request.getParameter("pageNum");
if (pageNum == null) pageNum = "1";

String memberId = (String)session.getAttribute("memberId");
if(memberId == null){
	out.print("<script>location('../logon/memberLoginForm.jsp');</script>");
}
%>
document.addEventListener("DOMContentLoaded", function(){
	let form = document.writeForm;
	
	let btn_write = document.getElementById("btn_write");
	btn_write.addEventListener("click", function(){

		if(!form.subject.value){
			alert("제목을 입력하시오");
			form.subject.focus();
			return
		}
		if(!form.content.value){
			alert("내용을 입력하시오");
			form.subject.focus();
			return
		}
		form.submit();	
	});
	
	
	let btn_boardList = document.getElementById("btn_boardList");
	btn_boardList.addEventListener("click", function(){
		location = "../board/boardList.jsp?pageNum=<%=pageNum%>";
	});
});
</script>
</head>
<body>
	<div class="m_title"><a href="#">coder</a></div>
	<div class="s_title">글쓰기</div>
	<div id="container"> 
		<form action="boardWritePro.jsp" method="post" name="writeForm">
			<input type="hidden" name="num" value="0">
			<input type="hidden" name="ref" value="0">
			<input type="hidden" name="re_step" value="0">
			<input type="hidden" name="re_level" value="0">
			<input type="text" name="subject" id="subject" value="" placeholder="제목을 입력해 주세요.">
			<textarea rows="20" cols="60" name="content" id="content" placeholder="내용을 입력하세요." style="resize: none;"></textarea> <br>
			<input type="text" name="writer" id="writer" readonly value="<%=memberId%>"> <br>
				 
				<br>
			<div class="btns">
				<input type="button" value="글등록" id="btn_write">&emsp;&emsp;
				<input type="button" value="취소" id="btn_boardList">	
			</div>
		</form>
	</div>
</body>
</html>