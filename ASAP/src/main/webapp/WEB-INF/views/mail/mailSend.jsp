<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<html>
<head>
<script>

</script>
</head>
<body>
<h1>Reservation Mail Send</h1>
<hr><br>

<div>
	<form name="mailForm" action="/mail/auctionPriceUpdate" method="post">
		<div class="input_1">
			<laber>성</laber>
			<input type="text" name="name" placeholder="Name">
		</div>	
		<div class="input_2">
			<laber>이름</laber>
			<input type="text" name="last_name" placeholder="last_Name" >
		</div>	
		<div class="input_3">
			<input type="email" name="email" placeholder="Email" >
		</div>	
		<div class="input_4">
			<textarea type="message" name="Message" placeholder="Message" ></textarea>
		</div>	
		<div>
			<div class="click">
				<input type="submit" id="btnMailSend" name="btnMailSend" value="SEND">			
			</div>
		</div>
			<div>
			<div class="click">
				<input type="submit" id="auctionPriceUpdate" name="auctionPriceUpdate" value="최종 낙찰가 update">			
			</div>
		</div>
	</form>
</div>

</body>
</html>