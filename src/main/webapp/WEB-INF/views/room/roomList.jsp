<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<link href="https://fonts.googleapis.com/css2?family=Charis+SIL:wght@700&family=Kdam+Thmor+Pro&display=swap" rel="stylesheet">
<link rel="stylesheet" href="${contextPath}/resources/css/footer.css">
<link rel="stylesheet" href="${contextPath}/resources/css/header.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../resources/js/jquery-3.6.0.js"></script>
<style>
	
	.roomNo{
	
		color: black;
	}

</style>
<script type="text/javascript">
	function goPost() {
		let f = document.createElement('form');
		const chkIn = document.getElementById('chkIn');
		const chkOut = document.getElementById('chkOut');
		const roomNo = document.getElementById('roomNo');
		const roomName = document.getElementById('roomName');
		const roomPrice = document.getElementById('roomPr');
		
		f.appendChild(chkIn);
		f.appendChild(chkOut);		
		f.appendChild(roomNo);		
		f.appendChild(roomName);		
		f.appendChild(roomPrice);		
		
		f.setAttribute('method', 'post');
		f.setAttribute('action', '${contextPath}/reservation/reservationPage');
		document.body.appendChild(f);
		f.submit();
	}
</script>
</head>
<body>
		<jsp:include page="../layout/header.jsp"></jsp:include>
	<table>
			
		<tbody>
			
			<c:forEach items="${roomList}" var="room">
					<tr>
						<td>
						   <input type="hidden" id="roomNo" name="roomNo" value="${room.roomNo}">
						   <a href="${contextPath}/room/detail?roomNo=${room.roomNo}"><img src="${contextPath}/room/view?roomNo=${room.roomNo}" width="300px"></a>
						</td>
						<td>
						   <input type="hidden" id="roomName" name="roomName" value="${room.roomName}">
						   <a href="${contextPath}/room/detail?roomNo=${room.roomNo}" class="roomNo">${room.roomName}</a>
						</td>	
						<td>
						   <input type="hidden" id="roomPr" name="roomPr" value="${room.roomPrice}">
						   <input type="hidden" id="chkIn" name="chkIn" value="${room.roomCheckIn}">
						   <input type="hidden" id="chkOut" name="chkOut" value="${room.roomCheckOut}">	
						   <input type="button" value="${room.roomPrice}KRW" onclick="goPost()">
						</td>
					</tr>
			</c:forEach>
			
		</tbody>
		
	</table>
		<jsp:include page="../layout/footer.jsp"></jsp:include>
</body>
</html>
