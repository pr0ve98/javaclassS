<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>restapiTest4.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
	
	const API_KEY = 'LKhDcIdwTxqcW5ByMDKjY0%2Fq4hNXcr%2Bv6FkQnMozjfz1%2Fhz5G8N6aXh%2ByDx3w%2BMOu7AOegGbZz%2F%2BDLGacSbRCg%3D%3D';
	
	async function getCrimeDate() {
		let year = $("#year").val();
		let apiYear = '';
		
		if(year == '') {
			alert("년도를 선택해주세요");
			return false;
		}
		
		if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
		else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
		else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
		else if(year == 2018) apiYear = "/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7";
		else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
		else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
		else if(year == 2021) apiYear = "/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2";
		else if(year == 2022) apiYear = "/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c";
		

		let url = "https://api.odcloud.kr/api";
		url += apiYear;
		url += "?serviceKey="+API_KEY;
		url += "&page=1&perPage=200";
		
		let response = await fetch(url);
		//console.log(response);
		
		let res = await response.json();
		console.log(res);
		
		let str0 = "<table class='table table-bordered table-hover text-center'>"
			+ "<tr class='table-info'><th colspan='5' style='font-size:24pt'>"+year+"년도 강력범죄 자료</th></tr>"
			+ "<tr class='table-secondary'><th>경찰서</th><th>살인</th><th>강도</th><th>절도</th><th>폭력</th></tr>";
			
		let str1 = res.data.map((item, i) => [
			"<tr><td>" + item.경찰서 + "</td>"
			+ "<td>" + item.살인 + "건</td>"
			+ "<td>" + item.강도 + "건</td>"
			+ "<td>" + item.절도 + "건</td>"
			+ "<td>" + item.폭력 + "건</td></tr>"
		]).join('');
		
		str1 += "</table>";
		
		let str = str0 + str1;
		
		$("#demo").html(str);
	}
	
	// 검색한 자료를 db에 저장하기
	async function saveCrimeDate() {
		let year = $("#year").val();
		let apiYear = '';
		
		if(year == '') {
			alert("년도를 선택해주세요");
			return false;
		}
		
		if(year == 2015) apiYear = "/15084592/v1/uddi:fbbfd36d-d528-4c8e-aa9b-d5cdbdeec669";
		else if(year == 2016) apiYear = "/15084592/v1/uddi:21ec6fa1-a033-413b-b049-8433f5b446ff";
		else if(year == 2017) apiYear = "/15084592/v1/uddi:67117bd9-5ee1-4e07-ae4a-bfe0861ee116";
		else if(year == 2018) apiYear = "/15084592/v1/uddi:2d687e27-b5c3-4bdb-9b77-c644dcafcbc7";
		else if(year == 2019) apiYear = "/15084592/v1/uddi:b6cc7731-181b-48e1-9a6c-ae81388e46b0";
		else if(year == 2020) apiYear = "/15084592/v1/uddi:fdde1218-987c-49ba-9326-8e3ba276141e";
		else if(year == 2021) apiYear = "/15084592/v1/uddi:943e757d-462b-4b3a-ab9f-9a8553637ca2";
		else if(year == 2022) apiYear = "/15084592/v1/uddi:5e08264d-acb3-4842-b494-b08f318aa14c";
		
		let url = "https://api.odcloud.kr/api";
		url += apiYear;
		url += "?serviceKey="+API_KEY;
		url += "&page=1&perPage=200";
		
		let response = await fetch(url);
		//console.log(response);
		
		let res = await response.json();
		//console.log(res);
		
		// 화면에 출력된 자료들을 모두 db에 저장시켜준다
		//alert(res.data[0].강도);
		let query = "";
		for(let i=0; i<res.data.length; i++){
			if(res.data[i].경찰서 != null){
				query = {
					year : year,
					police : res.data[i].경찰서,
					murder : res.data[i].살인,
					robbery : res.data[i].강도,
					theft : res.data[i].절도,
					violence : res.data[i].폭력
				}
			}
			
			$.ajax({
				url : "${ctp}/study/restapi/saveCrimeData",
				type : "post",
				data : query,
				error : function() {
					alert("전송오류!");
				}
			});
		}
		alert(year+"년도 자료가 DB에 저장되었습니다!");
	}
	
	function deleteCrimeDate() {
		let year = $("#year").val();
		let apiYear = '';
		
		if(year == '') {
			alert("년도를 선택해주세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/restapi/deleteCrimeDate",
			type : "post",
			data : {year:year},
			success : function(res) {
				if(res != "0") alert(year+"년도 자료 삭제완료!");
				else alert(year+"년도 자료 삭제실패...");
			},
			error : function() {
				alert("전송오류!");
			}
			
		});
	}
	
	function listCrimeDate() {
		let year = $("#year").val();
		let apiYear = '';
		
		if(year == '') {
			alert("년도를 선택해주세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/restapi/listCrimeDate",
			type : "post",
			data : {year:year},
			success : function(res) {
				$("#demo").html(res);
			},
			error : function() {
				alert("전송오류!");
			}
			
		});
	}
	
	function policeCheck() {
		let year = $("#year").val();
		let police = document.getElementById("police").value;
		
		if(year == '') {
			alert("년도를 선택해주세요");
			return false;
		}
		
		if(police == ''){
			alert("지역을 선택해주세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/restapi/policeCrimeDate",
			type : "post",
			data : {police : police, year : year},
			success : function(res) {
				$("#demo").html(res);
			},
			error : function() {
				alert("전송오류!");
			}
		});
	}
	
	function yearPoliceCheck() {
		let year = $("#year").val();
		let police = document.getElementById("police").value;
		let sort = $('input[name="yearOrder"]:checked').val();
		
		if(year == '') {
			alert("년도를 선택해주세요");
			return false;
		}
		
		if(police == ''){
			alert("지역을 선택해주세요");
			return false;
		}
		
		$.ajax({
			url : "${ctp}/study/restapi/yearPoliceCheck",
			type : "post",
			data : {police : police, year : year, sort : sort},
			success : function(res) {
				$("#demo").html(res);
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
<div class="container">
	<h2>경찰청 강력범죄 발생현황 자료리스트</h2>
	<hr/>
	<form name="myform" method="post">
		<div>
			<select name="year" id="year">
				<option value="">년도선택</option>
				<c:forEach var="i" begin="2015" end="2022">
					<option value="${i}" ${year == i ? 'selected' : ''}>${i}년도</option>
				</c:forEach>
			</select>
			<input type="button" value="강력범죄현황조회" onclick="getCrimeDate()" class="btn btn-success" />
			<input type="button" value="강력범죄DB저장" onclick="saveCrimeDate()" class="btn btn-primary" />
			<input type="button" value="강력범죄DB삭제" onclick="deleteCrimeDate()" class="btn btn-info" />
			<input type="button" value="강력범죄DB출력" onclick="listCrimeDate()" class="btn btn-warning" />
		</div>
		<div class="mt-4">
			 경찰서 지역명: 
			 <select name="police" id="police" onchange="policeCheck()">
			 	<option value="">지역선택</option>
			 	<option>서울</option>
			 	<option>부산</option>
			 	<option>대구</option>
			 	<option>인천</option>
			 	<option>광주</option>
			 	<option>대전</option>
			 	<option>울산</option>
			 	<option>세종</option>
			 	<option>경기</option>
			 	<option>강원</option>
			 	<option>충북</option>
			 	<option>충남</option>
			 	<option>전북</option>
			 	<option>전남</option>
			 </select> &nbsp;&nbsp;
			 : 정렬순서 :
			 <input type="radio" name="yearOrder" value="a" checked />오름차순
			 <input type="radio" name="yearOrder" value="d" />내림차순
			 <input type="button" value="년도/경찰서별출력" onclick="yearPoliceCheck()" class="btn btn-secondary" />
		</div>
	</form>
	<hr/>
	<div id="demo"></div>
	<hr/>
	<h3>범죄 분석 통계</h3>
	<!-- 1. 년도/강도/살인/절도/폭력 -->
	<div>${allCntStr}</div>
	<!-- 2. 경찰서별 통계: 년도/강도/살인/절도/폭력 -->
	<!-- 3. 범죄발생건수가 가장 작은 지역? -->
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>