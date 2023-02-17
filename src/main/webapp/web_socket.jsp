<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>web_socket.jsp</title>
<script src="https://code.jquery.com/jquery-3.6.3.js"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Single+Day&display=swap');

@font-face {
	font-family: "DungGeunMo";
	src: url("fonts/DungGeunMo.woff.woff2") format("woff2"),
    	 url("fonts/DungGeunMo.woff") format("woff");
	font-weight: normal;
	font-style: normal;
}

body{
	font-family: "DungGeunMo";
	font-size:25px;
	box-sizing:0;
	padding:0;
	margin:0;
/* 	background-color:#002a68;
	background-image: url(images/blue_screen.gif);
    width: 100%;
    height:300px;
    background-repeat : no-repeat;*/
}

#blue_screen{
	position:fixed;
	top:0;
	left:0;
	z-index:-10;
	width:100%;
	height:99vh;
}

#web_client{
	width:80vw;
	margin:20vh auto;
/*  background-color:#ccc; 
	border-radius:13px; */
	padding:0px;
	color:white;
}

#result{
	width:100%;
	height:45vh;
/* 	padding:20px; */
	overflow:auto;
	-ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
}

#result::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
}

#msg{
	width:90%;
	font-size:19px;
	border-radius:8px;
	background:none;
	color:white;
	border:none;
	font-family: "DungGeunMo";
	font-size:25px;
}

#msg:focus {outline: none;} /* outline 테두리 없애기 */

#msg2{
	display:inline-block;
	margin:4px 0 0 20px;
}

</style>
</head>
<body>
<img src='images/blue_screen.gif' id='blue_screen'>
<div id='web_client'>
	<!-- <span>***라이더37님이 입장하셨습니다***</span> -->
	<div id='result'>
	</div>
	<hr>
	<span>chat : </span>
	<input type='text' id='msg'/>
</div>
<script>
$(document).ready(function() {
	$('#msg').focus();
});

//var webSocket = new WebSocket('ws://172.30.74.81:8888/web-2022-08/chatting');
var webSocket = new WebSocket('ws://' + location.host + '/web-2022-08/chatting2');

 webSocket.onopen = function(){
	 /*
	 let rs = document.querySelector('#result');
	 rs.innerHTML = "연결 성공!!!";
     */
	 $('#result').html("<div id='msg2'>***인절미님이 입장하셨습니다***</div><br/><input type='hidden' id='myId'");
 }
 webSocket.onclose = function(){	
	 $('#result').html('연결 종료!!!');
 }
  
 webSocket.onmessage = function(msg){
  let str = "<div id='msg2' >" + "인절미 : " + msg.data + "</div>" + "<br/>";
  	$('#result').append(str);
	$('#result').scrollTop($('#result')[0].scrollHeight)
 }
  
 $('#msg').keyup(function(ev){
	  if(ev.keyCode==13){
		  sendFunc();
	  }
 });
 
 function sendFunc(){
	let sendbox = document.querySelector("#msg");
	let msg = $('#msg').val();
    webSocket.send( msg );
	console.log('msg : ' , msg)
	sendbox.value = "";
 }
  
 
</script>
</body>
</html>