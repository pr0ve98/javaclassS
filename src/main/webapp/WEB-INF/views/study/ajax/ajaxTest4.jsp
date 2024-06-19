<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajaxTest4.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function fCheck() {
		let name = document.getElementById("name").value;
		if(name.trim() == ""){
			alert("이름을 선택하세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/ajax/ajaxTest4",
			type : "post",
			data : {name:name},
			success : function(res) {
				//console.log(res);
				$("#demo").html(res);
			},
			error : function() {
				alert("전송 오류");
			}
		});
	}
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2>ajaxTest4.jsp</h2>
	<hr/>
	<form>
		<h3>이름을 선택하세요</h3>
		<select name="name" id="name">
			<option value="">이름선택</option>	
			<c:forEach var="name" items="${names}">
				<c:if test="${name != null}">
					<option>${name}</option>
				</c:if>
			</c:forEach>
		</select>
		<input type="button" value="선택" onclick="fCheck()" class="btn btn-info mr-3 mb-3" />
		<input type="button" value="돌아가기" onclick="location.href='ajaxForm';" class="btn btn-warning mr-3 mb-3" />
	</form>
	<div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>