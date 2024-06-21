<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberJoin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/MemberJoinOk.mem" class="was-validated">
    <h2>개별 회원 정보</h2>
    <br/>
    <img src="${ctp}/images/member/${vo.photo}" width="300px"/>
    <hr/>
    <div>아이디: ${vo.mid}</div>
    <div>닉네임: ${vo.nickName}</div>
    <div>성명: ${vo.name}</div>
    <div>이메일: ${vo.email}</div>
    <div>성별: ${vo.gender}</div>
    <div>생일: ${vo.birthday}</div>
    <div>전화번호: ${vo.tel}</div>
    <div>주소: ${vo.address}</div>
    <div>홈페이지: ${vo.homePage}</div>
    <div>직업: ${vo.job}</div>
    <div>취미: ${vo.hobby}</div>
    <div>자기소개: ${vo.content}</div>
    <div>정보공개: ${vo.userInfor}</div>
    <hr/>
    <div>
    	<a href="javascript:history.back();" class="btn btn-success">돌아가기</a>
    </div>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>