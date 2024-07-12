<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>webSocket.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  <style>
		#list {
			height: 390px;
			padding: 15px;
			overflow: auto;
		}
  </style>
  <script>
	  $(document).ready(function(){
		  
			//채팅 서버 주소
		  let url = "ws://192.168.50.66:9090/javaclassS/chatserver";
		  //let url = "ws://localhost:9090/${ctp}/chatserver";
		     		
		  // 웹 소켓
		  let ws;
		
		  
		  $('#btnConnect').click(function() {
		  	
	     	if ($('#user').val().trim() != '') {
	  	   	ws = new WebSocket(url);
	  	   			
	  	   	
	  	   	ws.onopen = function (evt) {
	  	   		console.log($('#user').val(), '서버 연결 성공');
	  	   		print($('#user').val(), '입장했습니다.');
	  	   				
	  	   		
		  			ws.send('1#' + $('#user').val() + '#');
		  			
		  			$('#chatStatus').html('${sNickName}님 접속중');
	  	   		
		  			$('#user').attr('readonly', true);					
		  			$('#btnConnect').attr('disabled', true);		
		  			$('#btnDisconnect').attr('disabled', false);
		  			$('#msg').attr('disabled', false);	
		  			$('#msg').focus();
		  		};
	        
		  		
	  			ws.onmessage = function (evt) {		
		  			let index = evt.data.indexOf("#", 2);	
		  			let no = evt.data.substring(0, 1);		
		  			let user = evt.data.substring(2, index);  
		  			
		  			
		  			if(index == -1) user = evt.data.substring(evt.data.indexOf("#")+1, evt.data.indexOf(":"));	
		  			let txt = evt.data.substring(evt.data.indexOf(":")+1);			  			
		  	   				
		  			if (no == '1') {	
		  				print2(user);
		  			} else if (no == '2') {	
		  				if (txt != '') print(user, txt);
		  			} else if (no == '3') {	
		  				print3(user);
		  			}
		  			$('#list').scrollTop($('#list').prop('scrollHeight'));	
		  		};
	  	   	
		  		
		  		ws.onclose = function (evt) {
		  			console.log('소켓이 닫힙니다.');
		  		};
	
		  		
		  		ws.onerror = function (evt) {
		  			console.log(evt.data);
		  		};
		  	} else {
		  		alert('유저명을 입력하세요.');
		  		$('#user').focus();
		  	}
		  });
		
		  
		  function print(user, txt) {
		  	let temp = '';
		  	
		  	if('${sNickName}'!=user) {	
		  		temp += '<div style="margin-top:15px;margin-bottom:3px;margin-right:100px">';
			  	temp += '<font size="2em" style="margin-top:5px;margin-bottom:5px;padding:5px;">' + user + '</font> ';
		  	}
		  	else {	
		  		temp += '<div style="margin-bottom:3px;margin-left:100px" class="text-right">';
			  	temp += '<font size="1em">' + user + '</font> ';
		  	}
		  	temp += '<span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span><br/>';
		  	if('${sNickName}'!=user) {
		  		temp += '<div style="background-color:#CEF6EC;border:1px solid #fff; border-radius:4px; padding:5px; text-align:left;width:auto;">'+txt+'</div>';
		  	}
		  	else {
		  		if(txt.indexOf("입장했습니다.") != -1) {
		  		  temp += '<div style="background-color:#ff0;border:1px solid #ccc;border-radius:4px;padding:5px;text-align:left;width:auto;">'+user+"님이 " + txt+'</div>';
		  		}
		  		else {
		  		  temp += '<div style="background-color:#ff0;border:1px solid #ccc;border-radius:4px;padding:5px;text-align:left;width:auto;">'+txt+'</div>';		  			
		  		}
		  	}
		  	temp += '</div>';
			  temp = temp.replace(/\n/gi,"<br/>");	
		  			
		  	$('#list').append(temp);	
		  }
		  		
		  		
		  function print2(user) {
		  	let temp = '';
		  	temp += '<div style="margin-bottom:3px;">';
		  	temp += "<font color='red'>'" + user + "'</font> 이(가) <font color='blue'>접속</font>했습니다." ;
		  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		  	temp += '</div>';
		  			
		  	$('#list').append(temp);
		  }
		
		  
		  function print3(user) {
		  	let temp = '';
		  	temp += '<div style="margin-bottom:3px;">';
		  	temp += "<font color='red'>'" + user + "'</font> 이(가) <font color='red'>종료</font>했습니다." ;
		  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		  	temp += '</div>';
		  			
		  	$('#list').append(temp);
		  }
	
		  
		  $('#user').keydown(function() {
		  	if (event.keyCode == 13) {
		  		$('#btnConnect').click();
		  	}
		  });
		  
		  
		  $('#msg').keydown(function() {
		  	if (event.keyCode == 13) {
		  		if(!event.shiftKey) {
			  		if($('#msg').val().trim() == '') return false;
			  		let chatColor = $("#chatColor").val();
			  		
			  		ws.send('2#' + $('#user').val() + '#' + $(this).val() + '@' + chatColor);
			  		print($('#user').val(), '<font color="'+chatColor+'">'+$(this).val()+'</font>');
			  		
			  		event.preventDefault();	
			      $('#msg').val('');  		
			  		$('#msg').focus();
			  		$('#list').scrollTop($('#list').prop('scrollHeight'));	
		  		}
		  	}
		  });
		  		
		  
		  $('#btnDisconnect').click(function() {
		  	ws.send('3#' + $('#user').val() + '#');
		  	ws.close();
		  			
		  	$('#user').attr('readonly', false);
		  	
		    $('#user').val('${sNickName}');
		  	$('#user').attr('disabled', true);
		  	$('#chatStatus').html('${sNickName}님 <font color="red">접속대기</font>상태');
		  	$('#list').append('<font color="red">${sNickName}</font>님 접속종료');
		  			
		  	$('#btnConnect').attr('disabled', false);
		  	$('#btnDisconnect').attr('disabled', true);
		  			
		  	$('#msg').val('');
		  	$('#msg').attr('disabled', true);
		  });
		  
	  });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<br/>
<div class="container">
	<h2 class="page-header">대화방<font size="3" color="blue">(<span id="chatStatus">${sNickName}님 <font color="red">접속대기</font>상태</span>)</font></h2>		
	
	<div class="row">
		<div class="col-7">
		  <input type="text" name="user" value="${sNickName}" id="user" class="form-control m-0" readonly />
		</div>
		<div class="col-5">
		  <input type="button" value="연결" id="btnConnect" class="btn btn-success btn-sm m-0"/>
		  <input type="button" value="종료" id="btnDisconnect" class="btn btn-warning btn-sm m-0" disabled />
		  <input type="color" name="chatColor" id="chatColor" title="글자색 변경" style="width:40px;" class="p-0"/>
		</div>
	</div>
	<div style="height:400px;border:1px solid #fff;border-radius:4px;margin:2px 0;background-color:#F5ECCE">
		<div id="list"></div>
	</div>
	<div>
		<div>
		  <textarea name="msg" id="msg" rows="3" placeholder="대화 내용을 입력하세요." class="form-control mb-2" disabled></textarea>
		</div>
	</div>
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>