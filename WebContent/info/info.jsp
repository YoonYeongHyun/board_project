<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 게시판  커뮤니티 프로젝트</title>
</head>
<body>
<%
/*
< 회원가입 게시판  커뮤니티 프로젝트 설계 계획 >
- 회원가입을 하고, 로그인을하면 게시판에 글을 남기고 확인할 수 있는 프로젝트.
- BoradWebProject


1. DB 테이블 설계 - member, board
2. JavaBean을 통해 클래스로 데이터의 이동을 담당
3. JSP를 통해 화면에 보여줌

---------
1. member 테이블 설계
2. Member 클래스와, useBean을 사용하여 데이터의 이동을 담당 
3. JSP는 화면구현(...form.jsp)과, DB처리(...pro.jsp)를 담당
- 되도록이면 최대한 JSP는 html만 있도록 하고, JAVA 코드를 외부로 분리

---------

< JAVA의 클래스를 최대한 활용 >
DTO - Data Fransfer object, jsp 페이지에서 데이터의 이동을 담당하는 클래스
-- VO(Value Object), DataBean 이라고도 불려짐

DAO - Data Access object, jsp 페이지에서 데이터베이스의 연결과 질의를 담당하는 클래스
-- DBBean 이라고도 불려짐


*/
%>
</body>
</html>