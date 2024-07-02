<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	function crawling1() {
		$("#spinnerIcon").show();
		
		$.ajax({
			url : "${ctp}/study/crawling/test",
			type : "post",
			success : function(vos) {
				if(vos != "") {
					let str = '<table class="table table-bordered text-center">';
					str += '<tr class="table-secondary"><th>번호</th><th>영화제목</th><th>포스터</th><th>예매율</th></tr>';
					for(let i=0; i<vos.length; i++) {
						str += '<tr>'
						str += '<td>'+(i+1)+'</td>';
						str += '<td>'+vos[i].title+'</td>';
						str += '<td>'+vos[i].image+'</td>';
						str += '<td>'+vos[i].percent+'</td>';
						str += '</tr>';
					}
					str += '<tr><td colspan="4" class="p-0 m-0"></td></tr>';
					str += '</table>';
					$("#demo").html(str);
				}
				else $("#demo").html("검색된 자료가 없습니다");	
				$("#spinnerIcon").hide();
			},
			error : function() {
				alert("전송오류");
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
	<form name="myform">
		<div class="input-group mb-3">
			<div class="input-group-text">네이버 게임 크롤링</div>
			<div class="input-group-append"><input type="button" value="크롤링" onclick="crawling1()" class="btn btn-success"></div>
			<div class="input-group-append" id="spinnerIcon" style="display:none;"><div class="spinner-border text-muted ml-2"></div></div>
		</div>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>