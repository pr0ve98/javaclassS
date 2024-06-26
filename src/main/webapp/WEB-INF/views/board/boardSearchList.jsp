<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>boardSearchList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
	
		function pageSizeCheck() {
			let pageSize = $("#pageSize").val();
			location.href = "BoardSearchList.bo?search=${search}&searchString=${searchString}&pageSize="+pageSize;
		}
		function modalCheck(hostIp, mid, nickName, idx) {
			$("#myModal #modalHostIp").text(hostIp);
			$("#myModal #modalMid").text(mid);
			$("#myModal #modalNickName").text(nickName);
			$("#myModal #modalIdx").text(idx);
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
	<table class="table table-borderless m-0 p-0">
		<tr>
			<td colspan="2">
				<h2 class="text-center">게 시 판 검 색 결 과</h2>
				<div class="text-center">(<span style="color:skyblue;"><b>${searchTitle}</b></span>로 <span style="color:skyblue;"><b>${searchString}</b></span>를 검색한 결과 <span style="color:red;"><b>${searchCount}</b></span>건의 자료가 검색되었습니다.)</div>
			</td>
		</tr>
		<tr>
			<td class="text-right">
				<select name="pageSize" id="pageSize" onchange="pageSizeCheck()">
					<option value="5" ${pageSize==5 ? "selected" : ""}>5개씩 보기</option>
					<option value="10" ${pageSize==10 ? "selected" : ""}>10개씩 보기</option>
					<option value="20" ${pageSize==20 ? "selected" : ""}>20개씩 보기</option>
					<option value="30" ${pageSize==30 ? "selected" : ""}>30개씩 보기</option>
				</select>
			</td>
		</tr>
	</table>
	<table class="table table-hover m-0 p-0 text-center">
		<tr class="table-dark text-dark">
			<th>글번호</th>
			<th>글제목</th>
			<th>글쓴이</th>
			<th>작성날짜</th>
			<th>조회수(좋아요)</th>
		</tr>
		<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<c:if test="${vo.openSw == 'OK' || sLevel == 0 || sNickName == vo.nickName}">
				<tr>
					<td>${curScrStartNo}</td>
					<td class="text-left">
						<a href="boardContent?idx=${vo.idx}&pag=${pageVo.pag}&pageSize=${pageVo.pageSize}&flag=search&search=${search}&searchString=${searchString}">${vo.title}</a> 
						<c:if test="${vo.hour_diff < 24}"><img src="${ctp}/images/new.gif" alt="새글" /></c:if>
					</td>
					<td>
						${vo.nickName}
						<c:if test="${sLevel == 0}">
							<a href="#" onclick="modalCheck('${vo.hostIp}','${vo.mid}','${vo.nickName}','${vo.idx}')" data-toggle="modal" data-target="#myModal" class="badge badge-warning">회원정보</a>
						</c:if>
					</td>
					<td>
						<!-- 1일(24시간) 이내는 올린 날짜를 시간만 표시, 이후는 날짜와 시간을 표시 : 2024-05-14 10:43:52 -->
						${vo.date_diff == 0 ? fn:substring(vo.WDate, 11, 16) : fn:substring(vo.WDate, 0, 10)}
					</td>
					<td>${vo.readNum}(${vo.good})</td>
				</tr>
			</c:if>
			<c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
		</c:forEach>
		<tr><td colspan="5" class="m-0 p-0"></td></tr>
	</table>
	<br/>
	<!-- 블록페이지 시작 -->
	<div class="text-center">
	  <ul class="pagination justify-content-center">
		  <c:if test="${pageVo.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="boardSearchList.bo?search=${pageVo.search}&searchString=${pageVo.searchString}&pag=1&pageSize=${pageVo.pageSize}">첫페이지</a></li></c:if>
		  <c:if test="${pageVo.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="boardSearchList.bo?search=${pageVo.search}&searchString=${pageVo.searchString}&pag=${(pageVo.curBlock-1)*pageVo.blockSize + 1}&pageSize=${pageVo.pageSize}">이전블록</a></li></c:if>
		  <c:forEach var="i" begin="${(pageVo.curBlock*pageVo.blockSize)+1}" end="${(pageVo.curBlock*pageVo.blockSize) + pageVo.blockSize}" varStatus="st">
		    <c:if test="${i <= pageVo.totPage && i == pageVo.pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="boardSearchList.bo?search=${pageVo.search}&searchString=${pageVo.searchString}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		    <c:if test="${i <= pageVo.totPage && i != pageVo.pag}"><li class="page-item"><a class="page-link text-secondary" href="boardSearchList.bo?search=${pageVo.search}&searchString=${pageVo.searchString}&pag=${i}&pageSize=${pageVo.pageSize}">${i}</a></li></c:if>
		  </c:forEach>
		  <c:if test="${pageVo.curBlock < pageVo.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="boardSearchList.bo?search=${pageVo.search}&searchString=${pageVo.searchString}&pag=${(pageVo.curBlock+1)*pageVo.blockSize+1}&pageSize=${pageVo.pageSize}">다음블록</a></li></c:if>
		  <c:if test="${pageVo.pag < pageVo.totPage}"><li class="page-item"><a class="page-link text-secondary" href="boardSearchList.bo?search=${pageVo.search}&searchString=${pageVo.searchString}&pag=${pageVo.totPage}&pageSize=${pageVo.pageSize}">마지막페이지</a></li></c:if>
	  </ul>
	</div>
	<!-- 블록페이지 끝 -->
	<br/>
	<!-- 검색기 시작 -->
	<div class="container text-center">
		<form name="searchForm" method="post" action="boardSearchList">
			<b>검색: </b>
			<select name="search" id="search">
				<option value="title">제목</option>
				<option value="nickName">작성자</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchString" id="searchString" placeholder="검색어를 입력하세요" required />
			<input type="submit" value="검색" class="btn btn-secondary btn-sm"/>
			<input type="button" onclick="location.href='boardList';" value="전체보기" class="btn btn-primary btn-sm"/>
		</form>
	</div>
	<!-- 검색기 끝 -->
</div>
<p><br/></p>
  <!-- 모달에 회원정보 출력하기 -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">Modal Heading</h4>
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
	      	고유번호: <span id="modalIdx"></span><br/>
	      	아이피: <span id="modalHostIp"></span><br/>
	      	아이디: <span id="modalMid"></span><br/>
	      	닉네임: <span id="modalNickName"></span><br/>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>