<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
  	.error {color:red; font-size:12px;}
  </style>
  <script>
    'use strict';
    
    let nickCheckSw = 0;
    
    function fCheck() {
    	// 유효성 검사.....
    	// 아이디,닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
    	
    	// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
    	
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + '@' + email2;
    	
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + '-' + tel2 + '-' + tel3;
    	
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
    	let address = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
    	
    	// 정규식을 이용한 유효성 검사처리    	
    	let name = myform.name.value.trim();
    	let nameReg = /^[가-힣]{2,4}$/;
		
    	let emailReg = /^[a-zA-Z0-9-_]{4,12}$/;
    	let telReg2 = /^(?:\d{0}|(?:\d{3}|\d{4}))$/;
    	let telReg3 = /^(?:\d{0}|(?:\d{4}))$/;
    	
    	let homePage = myform.homePage.value.trim();
    	let homePageReg = /^https?:\/\/(?:([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(?:\/[\w-]+)*(?:[\?#].*)?)?$/;
    	
    	if(!nameReg.test(name)){
    		document.getElementById("hidden-name-msg").style.display = "block";
    		myform.name.value = "";
			myform.name.focus();
    	}
    	else if(!emailReg.test(email1)){
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "block";
    		myform.email1.value = "";
			myform.email1.focus();
    	}
    	else if(!telReg2.test(tel2)){
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "none";
    		document.getElementById("hidden-tel-msg").style.display = "block";
    		myform.tel2.value = "";
			myform.tel2.focus();
    	}
    	else if(!telReg3.test(tel3)){
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "none";
    		document.getElementById("hidden-tel-msg").style.display = "block";
    		myform.tel3.value = "";
			myform.tel3.focus();
    	}
    	else if(!homePageReg.test(homePage)){
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "none";
    		document.getElementById("hidden-tel-msg").style.display = "none";
    		document.getElementById("hidden-homePage-msg").style.display = "block";
    		myform.homePage.value = "";
			myform.homePage.focus();
    	}
    	else if(nickCheckSw == 0) {
    		alert("닉네임 중복체크를 해주세요!");
    		document.getElementById("nickNameBtn").focus();
    	}
    	else {
        	if(tel2 == "" && tel3 == ""){
        		tel2 = " ";
        		tel3 = " ";
        		tel = tel1 + '-' + tel2 + '-' + tel3;
        	}
        	else if(tel2 == ""){
        		tel2 = " ";
        		tel = tel1 + '-' + tel2 + '-' + tel3;
        	}
        	else if(tel3 == ""){
        		tel3 = " ";
        		tel = tel1 + '-' + tel2 + '-' + tel3;
        	}
        	
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "none";
    		document.getElementById("hidden-tel-msg").style.display = "none";
    		document.getElementById("hidden-homePage-msg").style.display = "none";
    		myform.email.value = email;
    		myform.tel.value = tel;
    		myform.address.value = address;
    		$("#mid").removeAttr("disabled");
    		$("#nickName").removeAttr("disabled");
    		
    		myform.submit();
    	}
    }
    
    // 닉네임 중복체크
        function nickCheck() {
		let nickName = myform.nickName.value;
    	let nickNameReg = /^[a-zA-Z가-힣0-9]{1,8}$/;
    	
		if(nickName.trim() == ""){
			alert("닉네임을 입력하세요!");
			myform.nickName.focus();
		}
		else if(nickName == ('${sNickName}')) {
			nickCheckSw = 1;
			alert("현재 닉네임을 사용합니다.");
			return false;
		}
		else if(!nickNameReg.test(nickName)){
    		document.getElementById("hidden-nickName-msg").style.display = "block";
    		myform.nickName.value = "";
			myform.nickName.focus();
    	}
		else {
    		document.getElementById("hidden-nickName-msg").style.display = "none";
			$.ajax({
				url : "${ctp}/MemberNickCheck.mem",
				type : "get",
				data : {nickName : nickName},
				success : function(res) {
					if(res != 0){
						alert("이미 사용중인 닉네임입니다.");
						myform.nickName.focus();
					}
					else {
						let ans = confirm("사용 가능한 닉네임입니다.\n사용하시겠습니까?");
						if(ans) {
							nickCheckSw = 1;
							$("#nickName").attr("disabled", true);
							$("#nickNameBtn").attr("disabled", true);
						}
					}
				},
				error : function() {
					alert("전송 오류");
				}
			});
		}
	}
    
    // 다시작성 눌렀을 때 버튼 활성화
    function resetForm() {
		$("#nickName").removeAttr("disabled");
		$("#nickNameBtn").removeAttr("disabled");
		myform.reset();
		$("#nickName").focus();
	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${ctp}/MemberUpdateOk.mem" class="was-validated">
    <h2>회 원 정 보 수 정</h2>
    <br/>
    <div class="form-group">
      아이디: ${vo.mid}
    </div>
    <div class="form-group">
      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" value="${vo.nickName}" minlength="2" maxlength="8" name="nickName" required />
      <div id="hidden-nickName-msg" class="error" style="display:none;">※닉네임은 1~8자로 영문 대/소문자와 숫자, 한글만 가능합니다!</div>
    </div>
    <div class="form-group">
      <label for="name">성명:</label>
      <input type="text" class="form-control" id="name" name="name" value="${vo.name}" required />
      <div id="hidden-name-msg" class="error" style="display:none;">※성명은 2~4자 한글로만 입력하세요!</div>
    </div>
    <div class="form-group">
      <label for="email1">Email address:</label>
        <div class="input-group mb-3">
        <c:set var="email" value="${fn:split(vo.email, '@')}"/>
          <input type="text" class="form-control" value="${email[0]}" id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com" ${email[1] == 'naver.com' ? 'selected' : ''}>naver.com</option>
              <option value="hanmail.net" ${email[1] == 'hanmail.net' ? 'selected' : ''}>hanmail.net</option>
              <option value="hotmail.com" ${email[1] == 'hotmail.com' ? 'selected' : ''}>hotmail.com</option>
              <option value="gmail.com" ${email[1] == 'gmail.com' ? 'selected' : ''}>gmail.com</option>
              <option value="nate.com" ${email[1] == 'nate.com' ? 'selected' : ''}>nate.com</option>
              <option value="yahoo.com" ${email[1] == 'yahoo.com' ? 'selected' : ''}>yahoo.com</option>
            </select>
          </div>
        </div>
      	<div id="hidden-email-msg" class="error" style="display:none;">※이메일 형식에 적합하지 않습니다!</div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" ${vo.gender == '남자' ? 'checked' : ''}>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자" ${vo.gender == '여자' ? 'checked' : ''}>여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생년월일</label>
      <input type="date" name="birthday" value="${fn:substring(vo.birthday, 0, 10)}" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" ${tel1 == '010' ? 'selected' : ''}>010</option>
              <option value="02" ${tel1 == '02' ? 'selected' : ''}>02</option>
              <option value="031" ${tel1 == '031' ? 'selected' : ''}>031</option>
              <option value="032" ${tel1 == '032' ? 'selected' : ''}>032</option>
              <option value="041" ${tel1 == '041' ? 'selected' : ''}>041</option>
              <option value="042" ${tel1 == '042' ? 'selected' : ''}>042</option>
              <option value="043" ${tel1 == '043' ? 'selected' : ''}>043</option>
              <option value="051" ${tel1 == '051' ? 'selected' : ''}>051</option>
              <option value="052" ${tel1 == '052' ? 'selected' : ''}>052</option>
              <option value="061" ${tel1 == '061' ? 'selected' : ''}>061</option>
              <option value="062" ${tel1 == '062' ? 'selected' : ''}>062</option>
            </select> - 
        </div>
        <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/> - 
        <input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
      </div>
      <div id="hidden-tel-msg" class="error" style="display:none;">※전화번호 형식에 적합하지 않습니다!</div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-1">
      <c:set var="address" value="${fn:split(vo.address, '/')}"/>
        <input type="text" name="postcode" id="sample6_postcode" value="${postcode}" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" value="${roadAddress}" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" class="form-control">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="homepage">Homepage address:</label>
      <input type="text" class="form-control" name="homePage" value="${vo.homePage}" id="homePage"/>
      <div id="hidden-homePage-msg" class="error" style="display:none;">※홈페이지 형식에 적합하지 않습니다!</div>
    </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <!-- <option value="">직업선택</option> -->
        <option ${vo.job == '학생' ? 'selected' : ''}>학생</option>
        <option ${vo.job == '회사원' ? 'selected' : ''}>회사원</option>
        <option ${vo.job == '공무원' ? 'selected' : ''}>공무원</option>
        <option ${vo.job == '군인' ? 'selected' : ''}>군인</option>
        <option ${vo.job == '의사' ? 'selected' : ''}>의사</option>
        <option ${vo.job == '법조인' ? 'selected' : ''}>법조인</option>
        <option ${vo.job == '세무인' ? 'selected' : ''}>세무인</option>
        <option ${vo.job == '자영업' ? 'selected' : ''}>자영업</option>
        <option ${vo.job == '기타' ? 'selected' : ''}>기타</option>
      </select>
    </div>
    <div class="form-group">
		취미: &nbsp;
		<c:set var="varHobbys" value="${fn:split('등산/낚시/수영/독서/영화감상/바둑/축구/기타', '/')}"/>
		<c:forEach var="tempHobby" items="${varHobbys}" varStatus="st">
			<input type="checkbox" name="hobby" value="${tempHobby}" <c:if test="${fn:contains(hobby, tempHobby)}">checked</c:if> /> ${tempHobby}&nbsp;
		</c:forEach>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content">${vo.content}</textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfor" value="공개" checked/>공개
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="userInfor" value="비공개"/>비공개
        </label>
      </div>
    </div>
    <div  class="form-group">
      회원 사진(파일용량:2MByte이내) : <img src="${ctp}/images/member/${vo.photo}" width="100px" />
      <input type="file" name="fName" id="file" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원정보수정</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="resetForm()">다시작성</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='MemberMain.mem';">돌아가기</button>
    
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
    <input type="hidden" name="mid" value="${sMid}" />
    <input type="hidden" name="photo" value="${vo.photo}" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>