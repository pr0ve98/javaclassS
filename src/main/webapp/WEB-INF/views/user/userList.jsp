<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userList.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	$(document).ready(function(){
		$("#btnShow").show();
		$("#btnHide").hide();
		$("#userInput").hide();
		
		$("#btnShow").click(function() {
			$("#btnShow").hide();
			$("#btnHide").show();
			$("#userInput").show();
		});
		
		$("#btnHide").click(function() {
			$("#btnShow").show();
			$("#btnHide").hide();
			$("#userInput").hide();
		});
	});
	
	function deleteCheck(idx) {
		let ans = confirm("선택하신 회원을 삭제처리하시겠습니까?");
		if(!ans) return false;
		
		location.href = "${ctp}/user/userDelete?idx="+idx;
	}
</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원 리스트</h2>
	<input type="button" value="회원가입폼보기" id="btnShow" class="mb-3" />
	<input type="button" value="회원가입폼가리기" id="btnHide" class="mb-3" />
	<div id="userInput">
		<form name="myform" method="post" action="${ctp}/user/userInputOk">
			<table class="table table-bordered">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="mid" id="mid" value="atom1234" class="form-control"/></td>
				</tr>
				<tr>
					<th>성명</th>
					<td><input type="text" name="name" id="name" value="김아톰" class="form-control"/></td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="number" name="age" id="age" value="20" class="form-control"/></td>
				</tr>
				<tr>
					<th>주소</th>
					<td><input type="text" name="address" id="address" value="서울" class="form-control"/></td>
				</tr>
				<tr>
					<td colspan="2" class="text-center">
						<input type="submit" value="회원가입" class="btn btn-success" />
						<input type="reset" value="다시입력" class="btn btn-warning" />
					</td>
				</tr>
			</table>
		</form>
	</div>
	<table class="table table-hover">
		<tr class="table-secondary">
			<th>번호</th>
			<th>아이디</th>
			<th>성명</th>
			<th>나이</th>
			<th>주소</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.mid}</td>
				<td>${vo.name}</td>
				<td>${vo.age}</td>
				<td>${vo.address}</td>
				<td>
					<a href="javascript:deleteCheck(${vo.idx})" class="btn btn-danger btn-sm">삭제</a>
				</td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
	<br/>
	<div><a href="${ctp}/" class="btn btn-warning">돌아가기</a></div>
</div>
<p><br/></p>
</body>
</html>