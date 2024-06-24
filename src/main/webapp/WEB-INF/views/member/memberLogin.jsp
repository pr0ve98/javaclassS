<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<%
/*     Cookie[] cookies = request.getCookies();
    String saveMid = "";
    String check = "";
    for(int i=0; i<cookies.length; i++) {
        if(cookies[i].getName().equals("cMid")) {
        	saveMid = cookies[i].getValue();
        	check = "checked";
        }
    }
    pageContext.setAttribute("saveMid", saveMid);
    pageContext.setAttribute("check", check); */
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberLogin.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style type="text/css">
		.main{
			width:40%;
			margin: 0 auto;
		}
	</style>
	<script>
		'use strict';
		
		$(function(){
			$("#searchPassword").hide();
		});
		
		function pwdSearch() {
			$("#searchPassword").show();
		}
		
		// 임시비밀번호 등록
		function newPassword() {
			let mid = $("#midSearch").val().trim();
			let email = $("#emailSearch2").val().trim();
			if(mid == "" || email == "") {
				alert("가입시 등록한 아이디와 메일주소를 입력하세요");
				$("#midSearch").focus();
				return false;
			}
			
			$.ajax({
				url : "${ctp}/member/memberNewPassword",
				type : "post",
				data : {mid:mid, email:email},
				success : function(res) {
					if(res != "0") alert("새로운 비밀번호가 메일로 발송되었습니다\n메일함을 확인하세요");
					else alert("등록하신 정보의 회원이 없습니다.");
					location.reload();
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container text-center">
	<h2>로그인</h2>
	<div class="main">
		<form name="myform" method="post">
			<p><input type="text" name="mid" value="${saveMid}" placeholder="아이디를 입력하세요" class="form-control mt-3 mb-3" required autofocus /></p>
			<p><input type="password" name="pwd" value="qwer1234!" placeholder="비밀번호를 입력하세요" class="form-control mt-3 mb-3" required /></p>
			<p>
				<input type="submit" value="로그인" class="btn btn-primary" />
				<input type="button" value="회원가입" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-info" />
			</p>
			<table class="table table-bordered p-0">
				<tr>
					<td class="text-cetner">
						<input type="checkbox" name="idSave" value="저장" ${check} /> 아이디 저장&nbsp;&nbsp;&nbsp;
						[<a href="javascript:midSearch()">아이디 찾기</a>] /
						[<a href="javascript:pwdSearch()">비밀번호 찾기</a>]
					</td>
				</tr>
			</table>
		</form>
		<div id="searchPassword">
			<hr/>
			<table class="table table-bordered p-0 text-center">
				<tr>
					<td colspan="2" class="text-center">
						<font size="4"><b>비밀번호 찾기</b></font>
						(가입시 입력한 아이디와 메일주소를 입력하세요)
					</td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" name="midSearach" id="midSearch" placeholder="아이디를 입력하세요" class="form-control"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="emailSearch2" id="emailSearch2" placeholder="이메일을 입력하세요" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="2" class="text-center"><input type="button" value="새비밀번호발급" onclick="newPassword()" class="btn btn-success"></td>
				</tr>
			</table>
		</div>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>