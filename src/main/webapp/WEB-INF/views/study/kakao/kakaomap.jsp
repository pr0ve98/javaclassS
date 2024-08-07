<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>kakaomap.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<div id="map" style="width:100%;height:500px;"></div>
	
	<!-- 카카오맵 Javascript API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8feb139a33abe9bdb09b890a08740296"></script>
	<script>
		// 1. 지도를 띄워주는 기본 코드(지도 생성)
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(36.63513327240579, 127.45953253595172),
			level: 3 // 지도의 확대/축소 레벨
		};

		var map = new kakao.maps.Map(container, options);
	</script>
	<hr/>
	<jsp:include page="kakaoMenu.jsp"></jsp:include>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>