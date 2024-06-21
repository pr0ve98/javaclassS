<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%-- <%@ include file = "/include/certification.jsp" %> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>memberMain.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
		
		function memberPhotoChange() {
			let fName = document.getElementById("file").value;
			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
			let maxSize = 1024 * 1024 * 10 // 기본단위는 Byte, 1024 * 1024 * 10 = 10MB 허용
			
			if(fName.trim() == ""){
				alert("업로드할 파일을 선택하세요");
				return false;
			}
			
			let fileSize = document.getElementById("file").files[0].size;
			if(fileSize > maxSize){
				alert("업로드할 파일의 최대크기는 10MB입니다");
			}
			else if(ext != 'jpg' && ext != 'png' &&ext != 'gif' &&ext != 'jpeg'){
				alert("이미지 파일만 업로드해주세요");
			}
			else {
				let formData = new FormData();
				formData.append("fName", document.getElementById("file").files[0]);
				formData.append("mid", '${sMid}');
				
				$.ajax({
					url : "MemberPhotoChange.mem",
					type : "post",
					data : formData,
					processData: false,
					contentType: false,
					success : function(res) {
						if(res != "0"){
							alert("변경 완료!");
							location.reload();
						}
						else alert("변경 실패...");
					},
					error : function() {
						alert("오류!!");
					}
				});
			}
		}
		
		function chatInput() {
			let chat = $("#chat").val();
			if(chat.trim() != ""){
				$.ajax({
					url : "MemberChatInput.mem",
					type : "post",
					data : {chat : chat},
					error : function() {
						alert("전송오류!");
					}
				});
			}
		}
		
		// 채팅 대화 입력후 엔터키를 누르면 자동으로 메세지 DB에 저장시키기 - chatInput() 호출
		$(function() {
			$("#chat").on("keydown", function(e) {
				if(e.keyCode == 13) chatInput();
			});
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원 전용방</h2>
	<hr/>
	<!-- 실시간 채팅방(DB) -->
	<div class="row">
    <div class="col" style="width:420px">
	<div style="width:460px">
		<form name="chatForm">
			<label for="chat"><b>실시간 대화방</b></label>
			<iframe src="${ctp}/include/memberMessage.jsp" width="100%" height="200px" class="border"></iframe>
			<div class="input-group">
				<input type="text" name="chat" id="chat" class="form-control" placeholder="채팅을 입력하세요" autofocus/>
				<div class="input-group-append">
					<input type="button" value="전송" onclick="chatInput()" class="btn btn-success"/>
				</div>
			</div>
		</form>
		</div>
	</div>
	<div class="col text-center">
	    <b>신규 메세지(<font color='red'><b>${wmCnt}</b></font>건)</b>
	    <span style="font-size:11px">...<a href="WebMessage.wm">more</a></span>
      <c:if test="${wmCnt != 0}">
		    <table class="table table-bordered table-hover text-center">
		      <tr class="table-dark text-dark">
		        <th>번호</th>
		        <th>아이디</th>
		        <th>보낸날짜</th>
		      </tr>
			    <c:forEach var="vo" items="${wmVos}" varStatus="st">
			      <c:if test="${st.count <= 3}">
				      <tr>
				        <td>${st.count}</td>
				        <td>${vo.sendId}</td>
				        <td>${fn:substring(vo.sendDate,0,16)}</td>
				      </tr>
			      </c:if>
			    </c:forEach>
			    <tr><td colspan="3" class="m-0 p-0"></td></tr>
		    </table>
      </c:if>
      <hr/>
	      <div>
	        오늘의 일정이 <font color='blue'><b><a href="ScheduleMenu.sc?ymd=${ymd}">${scheduleCnt}</a></b></font>건 있습니다.
	      </div>
	  </div>
	  </div>
	<hr/>
	<img src="${ctp}/images/member/${mVo.photo}" width="200px"/>
	<hr/>
	<form name="myform" method="post" enctype="multipart/form-data">
		<label for="file">회원이미지 변경</label>
		<div class="form-group mt-2">
			<input type="file" name="fName" id="file">
			<input type="button" value="변경" onclick="memberPhotoChange()" class="btn btn-sm btn-warning"/>
		</div>
	</form>
	<hr/>
	<div>
		<p>현재 <font color="blue"><b>${sNickName}</b></font>(<font color="red">${sStrLevel}</font>)님이 로그인 중입니다.</p>
		<p>총 방문횟수 <b>${mVo.visitCnt}</b>회 / 오늘 방문횟수 <b>${mVo.todayCnt}</b>회</p>
		<p>총 보유 포인트 <b>${mVo.point}</b>점<c:if test="${mVo.todayCnt > 5}"> / (방문포인트 일일 최대한도 초과)</c:if></p>
	</div>
	<hr/>
	<div>
		<h5>활동 내역</h5>
		<p>방명록에 올린 글 수: <b>${guestCnt}</b>건</p>
		<p>게시판에 올린 글 수: _건</p>
		<p>자료실에 올린 글 수: _건</p>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>