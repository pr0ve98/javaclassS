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
  <style>
  	.error {color:red; font-size:12px;}
  </style>
  <script>
    'use strict';
    
    let idCheckSw = 0;
    let nickCheckSw = 0;
    
    function fCheck() {
    	// 유효성 검사.....
    	// 아이디,닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
    	
    	// 검사를 끝내고 필요한 내역들을 변수에 담아 회원가입처리한다.
     	let fName = document.getElementById("file").value;
    	let ext;
    	let fileSize;
		let maxSize = 1024 * 1024 * 20;
		if(fName != "") {
			ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
			fileSize = document.getElementById("file").files[0].size;
		}
    	
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
    	let pwd = myform.pwd.value.trim();
    	let pwdReg = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&^])[A-Za-z\d@$!%*#?&^]{8,16}$/;
    	
    	let name = myform.name.value.trim();
    	let nameReg = /^[가-힣]{2,4}$/;
		
    	let emailReg = /^[a-zA-Z0-9-_]{4,12}$/;
    	let telReg2 = /^(?:\d{0}|(?:\d{3}|\d{4}))$/;
    	let telReg3 = /^(?:\d{0}|(?:\d{4}))$/;
    	
    	let homePage = myform.homePage.value.trim();
    	let homePageReg = /^https?:\/\/(?:([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(?:\/[\w-]+)*(?:[\?#].*)?)?$/;
    	
    	if(!pwdReg.test(pwd)){
    		document.getElementById("hidden-pwd-msg").style.display = "block";
    		myform.pwd.value = "";
			myform.pwd.focus();
    	}
    	else if(!nameReg.test(name)){
    		document.getElementById("hidden-pwd-msg").style.display = "none";
    		document.getElementById("hidden-name-msg").style.display = "block";
    		myform.name.value = "";
			myform.name.focus();
    	}
    	else if(!emailReg.test(email1)){
    		document.getElementById("hidden-pwd-msg").style.display = "none";
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "block";
    		myform.email1.value = "";
			myform.email1.focus();
    	}
    	else if(!telReg2.test(tel2)){
    		document.getElementById("hidden-pwd-msg").style.display = "none";
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "none";
    		document.getElementById("hidden-tel-msg").style.display = "block";
    		myform.tel2.value = "";
			myform.tel2.focus();
    	}
    	else if(!telReg3.test(tel3)){
    		document.getElementById("hidden-pwd-msg").style.display = "none";
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "none";
    		document.getElementById("hidden-tel-msg").style.display = "block";
    		myform.tel3.value = "";
			myform.tel3.focus();
    	}
    	else if(!homePageReg.test(homePage)){
    		document.getElementById("hidden-pwd-msg").style.display = "none";
    		document.getElementById("hidden-name-msg").style.display = "none";
    		document.getElementById("hidden-email-msg").style.display = "none";
    		document.getElementById("hidden-tel-msg").style.display = "none";
    		document.getElementById("hidden-homePage-msg").style.display = "block";
    		myform.homePage.value = "";
			myform.homePage.focus();
    	}
     	// 전송 전 파일관련사항 체크
    	else if(ext != 'jpg' && ext != 'jpeg' && ext != 'png' && ext != 'gif' && ext != null){
    		alert("이미지 파일만 업로드 가능합니다!");
    	}
    	else if(fileSize > maxSize){
    		alert("업로드할 파일의 최대용량은 20MB입니다!");
    	}
    	else if(idCheckSw == 0){
    		alert("아이디 중복체크를 해주세요!");
    		document.getElementById("midBtn").focus();
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
        	
    		document.getElementById("hidden-pwd-msg").style.display = "none";
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
    
    // 아이디 중복체크
    function idCheck() {
		let mid = myform.mid.value;
    	let midReg = /^[a-zA-Z0-9-_]{4,12}$/;
    	
		if(mid.trim() == ""){
			alert("아이디를 입력하세요!");
			myform.mid.focus();
		}
		else if(!midReg.test(mid)){
    		document.getElementById("hidden-mid-msg").style.display = "block";
    		myform.mid.value = "";
			myform.mid.focus();
    	}
		else {
    		document.getElementById("hidden-mid-msg").style.display = "none";
			$.ajax({
				url : "${ctp}/member/memberIdCheck",
				type : "get",
				data : {mid : mid},
				success : function(res) {
					if(res != 0){
						alert("이미 사용중인 아이디입니다.");
						myform.mid.focus();
					}
					else {
						let ans = confirm("사용 가능한 아이디입니다.\n사용하시겠습니까?");
						if(ans) {
							idCheckSw = 1;
							$("#mid").attr("disabled", true);
							$("#midBtn").attr("disabled", true);
						}
					}
				},
				error : function() {
					alert("전송 오류");
				}
			});
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
		else if(!nickNameReg.test(nickName)){
    		document.getElementById("hidden-nickName-msg").style.display = "block";
    		myform.nickName.value = "";
			myform.nickName.focus();
    	}
		else {
    		document.getElementById("hidden-nickName-msg").style.display = "none";
			$.ajax({
				url : "${ctp}/member/memberNickCheck",
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
    	document.getElementById("hidden-mid-msg").style.display = "none";
    	document.getElementById("hidden-nickName-msg").style.display = "none";
		document.getElementById("hidden-pwd-msg").style.display = "none";
		document.getElementById("hidden-name-msg").style.display = "none";
		document.getElementById("hidden-email-msg").style.display = "none";
		document.getElementById("hidden-tel-msg").style.display = "none";
		document.getElementById("hidden-homePage-msg").style.display = "none";
		
		$("#nickName").removeAttr("disabled");
		$("#nickNameBtn").removeAttr("disabled");
		$("#mid").removeAttr("disabled");
		$("#midBtn").removeAttr("disabled");
		myform.reset();
		$("#mid").focus();
	}
    
    // 회원사진 미리보기
    function imgCheck(e) {
		if(e.files && e.files[0]) {
			let reader = new FileReader();
			reader.onload = function(e) {
				document.getElementById("photoDemo").src = e.target.result;
			}
			reader.readAsDataURL(e.files[0]);
		}
	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
  <!-- <form name="myform" method="post" class="was-validated"> -->
    <h2>회 원 가 입</h2>
    <br/>
    <div class="form-group">
      <label for="mid">아이디 : &nbsp; &nbsp;<input type="button" value="아이디 중복체크" id="midBtn" class="btn btn-secondary btn-sm" onclick="idCheck()"/></label>
      <input type="text" class="form-control" name="mid" id="mid" placeholder="아이디를 입력하세요." minlength="4" maxlength="12" required autofocus/>
      <div id="hidden-mid-msg" class="error" style="display:none;">※아이디는 4~12자로 영문 대/소문자와 숫자, '-', '_'만 사용 가능합니다!</div>
    </div>
    <div class="form-group">
      <label for="pwd">비밀번호 :</label>
      <input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력하세요." name="pwd" minlength="8" maxlength="16" required />
      <div id="hidden-pwd-msg" class="error" style="display:none;">※비밀번호는 8~16자로 영문 대/소문자와 숫자, 특수문자를 하나씩은 가져야 합니다!</div>
    </div>
    <div class="form-group">
      <label for="nickName">닉네임 : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" class="form-control" id="nickName" placeholder="별명을 입력하세요." minlength="2" maxlength="8" name="nickName" required />
      <div id="hidden-nickName-msg" class="error" style="display:none;">※닉네임은 1~8자로 영문 대/소문자와 숫자, 한글만 가능합니다!</div>
    </div>
    <div class="form-group">
      <label for="name">성명 :</label>
      <input type="text" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
      <div id="hidden-name-msg" class="error" style="display:none;">※성명은 2~4자 한글로만 입력하세요!</div>
    </div>
    <div class="form-group">
      <label for="email1">이메일:</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
          <div class="input-group-append">
            <select name="email2" class="custom-select">
              <option value="naver.com" selected>naver.com</option>
              <option value="hanmail.net">hanmail.net</option>
              <option value="hotmail.com">hotmail.com</option>
              <option value="gmail.com">gmail.com</option>
              <option value="nate.com">nate.com</option>
              <option value="yahoo.com">yahoo.com</option>
            </select>
          </div>
        </div>
      	<div id="hidden-email-msg" class="error" style="display:none;">※이메일 형식에 적합하지 않습니다!</div>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별 :</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" value="여자">여자
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <input type="date" name="birthday" value="<%=java.time.LocalDate.now() %>" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
        <div class="input-group-prepend">
          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
            <select name="tel1" class="custom-select">
              <option value="010" selected>010</option>
              <option value="02">02</option>
              <option value="031">031</option>
              <option value="032">032</option>
              <option value="041">041</option>
              <option value="042">042</option>
              <option value="043">043</option>
              <option value="051">051</option>
              <option value="052">052</option>
              <option value="061">061</option>
              <option value="062">062</option>
            </select> - 
        </div>
        <input type="text" name="tel2" size=4 maxlength=4 class="form-control"/> - 
        <input type="text" name="tel3" size=4 maxlength=4 class="form-control"/>
      </div>
      <div id="hidden-tel-msg" class="error" style="display:none;">※전화번호 형식에 적합하지 않습니다!</div>
    </div>
    <div class="form-group">
      <label for="address">주소</label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
    <div class="form-group">
      <label for="homepage">홈페이지 주소:</label>
      <input type="text" class="form-control" name="homePage" value="http://" placeholder="홈페이지를 입력하세요." id="homePage"/>
      <div id="hidden-homePage-msg" class="error" style="display:none;">※홈페이지 형식에 적합하지 않습니다!</div>
    </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <!-- <option value="">직업선택</option> -->
        <option>학생</option>
        <option>회사원</option>
        <option>공무원</option>
        <option>군인</option>
        <option>의사</option>
        <option>법조인</option>
        <option>세무인</option>
        <option>자영업</option>
        <option selected>기타</option>
      </select>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
        </label>
      </div>
      <div class="form-check-inline">
        <label class="form-check-label">
          <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
        </label>
      </div>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요."></textarea>
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
      회원 사진(파일용량:2MByte이내) :
      <input type="file" name="fName" id="file" onchange="imgCheck(this)" class="form-control-file border"/>
      <div><img id="photoDemo" width="100px"/></div>
    </div>
    <button type="button" class="btn btn-secondary" onclick="fCheck()">회원가입</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="resetForm()">다시작성</button> &nbsp;
    <button type="button" class="btn btn-secondary" onclick="location.href='${ctp}/member/memberLogin';">돌아가기</button>
    
    <input type="hidden" name="email" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="address" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>