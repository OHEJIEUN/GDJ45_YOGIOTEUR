<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.ok {
		color: blue;
	}
	.dont {
		color: red;
	}
	.signIn {
		text-align: center;
		border-bottom: 1px solid black;
		width: 40%;
		margin: 30px auto;
		padding-bottom: 20px;
	}
	.signIn a {
 		text-decoration: none;
		color: #333;	
		font-size: 40px;
		font-family: 'MICEMyungjo';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
        font-weight: 500;
        font-style: normal;
    }
	.join_container {
		margin: 0 auto;
		width: 460px;
		box-sizing: border-box;
	}
	.input {
		margin: 22px 0 8px;
		font-size: 22px;
		font-weight: 600;
		font-family: 'MICEMyungjo';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
        font-weight: 600;
        font-style: normal;
	}
	label {
		cursor: pointer;
	}
	. InputAreaWrapper {
		margin-bottom: 10px;
	}
	.InputArea {
		display: block;
		position: relative;
		margin: 0;
		width: 100%;
		height: 60px;
		border: solid 1px #dadada;
		padding: 10px 110px 10px 14px;
		box-sizing: border-box;
		vertical-align: top;
		font-family: 'MICEMyungjo';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
	}
	.InputArea_con {
		display: block;
		position: relative;
		width: 100%;
		height: 90px;
		border: solid 1px #dadada;
		padding: 10px 110px 10px 14px;
		box-sizing: border-box;
		vertical-align: top;
	}
	.box {
		border: 0 none;
		display: block;
		width: 100%;
		height: 40px;
		outline: none;
		font-size: 20px;
		font-family: 'MICEMyungjo';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
	}
	.boxes {
		height: 30px;
		width: 60%;
		border: solid 1px #dadada;
		outline: none;
		font-size: 20px;
		font-family: 'MICEMyungjo';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
        font-weight: normal;
        font-style: normal;
	}
	.msg {
       font-size: 16px;
       font-family: 'MICEMyungjo';
       src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
       font-weight: 600;
       font-style: normal;
       padding: 2px 0 8px 0;
    }
	.BtnArea {
		text-align: center;
		display: block;
		line-height: 30px;
		margin: 20px 0;
	}
	.btn_signIn {
		font-size: 18px;
		font-family: 'MICEMyungjo';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
        font-weight: 600;
        font-style: normal;
		padding: 20px 40px;
		border: 1px solid #dadada;
		background-color: black;
		color: #fff;
		cursor: pointer;
	}
	.btn_send {
     	text-align: center;
     	font-size: 15px;
        font-family: 'MICEMyungjo';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2206-01@1.0/MICEMyungjo.woff2') format('woff2');
        font-weight: bold;
        font-style: normal;
        margin: 0 auto;
        padding: 5px;
        cursor: pointer;
     }
</style>
<script src="../resources/js/jquery-3.6.0.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	$(function(){
		fnSignIn();
		fnIdCheck();
		fnPwCheck();
		fnPwConfirm();
		fnEmailAuth();
		fnPhoneCheck();
		fnBirthCheck();
	})
	// 가입
	function fnSignIn(){
		$('#SignInform').on('submit', function(event){
			if(idPass == false){
				alert('아이디를 확인하세요.');
				event.preventDefault();
				return false;
			}
			if(pwPass == false || rePwPass == false){
				alert('비밀번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			if(authCodePass == false){
				alert('이메일 인증을 받아야 합니다.');
				event.preventDefault();
				return false;
			}
			if(phonePass == false){
				alert('전화번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			if(birthPass == false){
				alert('생년월일을 확인하세요.');
				event.preventDefault();
				return false;
			}
			if($('#memberPostcode').val() == ''){
				alert('우편번호를 확인하세요.');
				event.preventDefault();
				return false;
			}
			if($('#memberRoadAddress').val() == ''){
				alert('주소를 확인하세요.');
				event.preventDefault();
				return false;
			}
			if($('#memberName').val() == ''){
				alert('이름을 확인하세요.');
				event.preventDefault();
				return false;
			}
			return true;
		})
	}
	
	
	// 생년월일 정규식
	let birthPass = false;
	function fnBirthCheck(){
		$('#memberBirth').on('keyup', function(){
			let regBirth = /^\d{6}$/;
			if(regBirth.test($('#memberBirth').val())==false){
				$('#memberBirthMsg').text('생년월일은 주민번호 앞자리만 입력해주세요.').addClass('dont').removeClass('ok');
				birthPass = false;
			} else {
				$('#memberBirthMsg').text('');
				birthPass = true;
			}
		})
	}
	
	
	// 연락처 정규식
	let phonePass = false;
	function fnPhoneCheck(){
		$('#memberPhone').on('keyup', function(e){
			let regPhone = /^\d{2,3}-\d{3,4}-\d{4}$/;
			if(regPhone.test($('#memberPhone').val())==false){
				$('#memberPhoneMsg').text('전화번호는 -(하이픈)포함 입력해주세요.').addClass('dont').removeClass('ok');
				phonePass = false;
			} else {
				$('#memberPhoneMsg').text('');
				phonePass = true;
			}
		})
	}
	
	
	// 이메일 확인
	function fnEmailCheck(){
		return new Promise(function(resolve, reject) {
			// 정규식 
			let regEmail = /^[a-zA-Z0-9-_]+@[a-zA-Z0-9]+(\.[a-zA-Z]{2,}){1,2}$/; 
			if(regEmail.test($('#memberEmail').val())==false){
				reject(1000);      
				return;
			}
			// 중복 
			$.ajax({
				url: '/member/emailCheck',
				type: 'get',
				data: 'memberEmail=' + $('#memberEmail').val(),
				dataType: 'json',
				success: function(obj){
					if(obj.res == null){
						resolve();     
					} else {
						reject(2000); 
					}
				}
			})
		});
	}
	
	// 이메일 인증
	let authCodePass = false;
	function fnVerifyAuthCode(authCode){  
		$('#btnVerifyAuthCode').on('click', function(){
			if($('#authCode').val() == authCode){
				alert('인증되었습니다.');
				authCodePass = true;
			} else {
				alert('인증에 실패했습니다.');
				authCodePass = false;
			}
		})
	}
	
	// 이메일 인증발송
	function fnEmailAuth(){
		$('#btnGetAuthCode').on('click', function(){
			fnEmailCheck().then(
				function(){
					$.ajax({
						url: '/member/sendAuthCode',
						type: 'get',
						data: 'memberEmail=' + $('#memberEmail').val(),
						dataType: 'json',
						success: function(obj){  
							$('#memberEmailMsg').text('사용 가능한 이메일입니다.').addClass('ok').removeClass('dont');;
							alert('인증코드를 발송했습니다. 이메일을 확인해주세요.');
							fnVerifyAuthCode(obj.authCode);  
						},
						error: function(jqXHR){
							alert('인증코드 발송이 실패했습니다.');
						}
					})
				}
			).catch(
				function(code){
					if(code == 1000){
						$('#memberEmailMsg').text('이메일 형식이 올바르지 않습니다.').addClass('dont').removeClass('ok');
						$('#authCode').prop('readonly', true);
					} else if(code == 2000){
						$('#memberEmailMsg').text('이미 사용 중인 이메일입니다.').addClass('dont').removeClass('ok');
						$('#authCode').prop('readonly', true);
					}
				}
			)
		})
	}
	
	// 비밀번호 재확인
	let rePwPass = false;
	function fnPwConfirm(){
		$('#memberPwConfirm').on('keyup', function(){
			if($('#memberPwConfirm').val() != '' && $('#memberPw').val() != $('#memberPwConfirm').val()){
				$('#memberPwConfirmMsg').text('비밀번호를 확인해주세요.').addClass('dont').removeClass('ok');
				rePwPass = false;
			} else {
				$('#memberPwConfirmMsg').text('');
				rePwPass = true;
			}
		})
	}
	
	
	// 비밀번호 정규식
	let pwPass = false;
	function fnPwCheck(){
		$('#memberPw').on('keyup', function(){
			let regPw = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,12}$/; 
			if(regPw.test($('#memberPw').val())==false){
				$('#memberPwMsg').text('8~12자리 영문, 숫자, 특수문자 모두포함으로만 가능합니다.').addClass('dont').removeClass('ok');
				pwPass = false;
			} else {
				$('#memberPwMsg').text('사용 가능한 비밀번호입니다.').addClass('ok').removeClass('dont');
				pwPass = true;
			}
		})
	}
	
	
	// 아이디(중복&정규식)
	let idPass = false;
	function fnIdCheck(){
		$('#memberId').on('keyup', function(){
			// 정규식 
			let regId = /^(?=.*[0-9]+)[a-zA-Z][a-zA-Z0-9]{5,11}$/; 
			if(regId.test($('#memberId').val())==false){
				$('#memberIdMsg').text('6~12자리 영문,숫자만 사용가능합니다.').addClass('dont').removeClass('ok');
				idPass = false;
				return;
			}
			// 아이디 중복 체크
			$.ajax({
				url: '/member/idCheck',
				type: 'get',
				data: 'memberId=' + $('#memberId').val(),
				dataType: 'json',
				success: function(obj){
					if(obj.res == null){
						$('#memberIdMsg').text('사용 가능한 아이디입니다.').addClass('ok').removeClass('dont');
						idPass = true;
					} else {
						$('#memberIdMsg').text('이미 사용중이거나 탈퇴한 아이디입니다.').addClass('dont').removeClass('ok');
						idPass = false;
					}
				},
				error: function(jqXHR){
					$('#memberIdMsg').text(jqXHR.responseText).addClass('dont').removeClass('ok');
					idPass = false;
				}
			})
		})
	}
	
	function fnPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var roadAddr = data.roadAddress; 
	                $('#memberPostcode').val(data.zonecode);
	                $('#memberRoadAddress').val(roadAddr);
            }
        }).open();
    }
</script>
</head>
<body>

	<jsp:include page="../layout/header.jsp"></jsp:include>
	
	<div class="signInWapper">
		<div class="signIn" >
			<a href="/member/agreePage">회원가입</a>
		</div>
		
		<div class="join_container">
			<form id="SignInform" action="/member/signIn" method="post">
			
				<input type="hidden" name="info" value="${agreements[0]}">
				<input type="hidden" name="event" value="${agreements[1]}">
				<div class="group">
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberId">아이디</label>
						</div>
							<div class="InputArea">
								<input type="text" name="memberId" id="memberId" class="box" placeholder="6~12자 영문,숫자">
							</div>
							<div id="memberIdMsg" class="msg"></div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberPw">비밀번호</label>
						</div>
							<div class="InputArea">
								<input type="password" name="memberPw" id="memberPw" class="box" placeholder="영문, 숫자, 특수문자 모두포함 8~12자">
							</div>
							<div id="memberPwMsg" class="msg"></div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberPwConfirm">비밀번호 재확인</label>
						</div>
							<div class="InputArea">
								<input type="password" id="memberPwConfirm" class="box" placeholder="영문, 숫자, 특수문자 모두포함 8~12자">
							</div>
							<div id="memberPwConfirmMsg" class="msg"></div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberName">이름</label>
						</div>
							<div class="InputArea">
								<input type="text" name="memberName" id="memberName" class="box" placeholder="이름">
							</div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberPhone">연락처</label>
						</div>	
							<div class="InputArea">
								<input type="text" name="memberPhone" id="memberPhone" class="box" placeholder="하이픈(-)을 포함 입력" maxlength="13">
							</div>
							<div id="memberPhoneMsg" class="msg"></div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberBirth">생년월일</label>
						</div>	
							<div class="InputArea">
								<input type="text" name="memberBirth" id="memberBirth" class="box" placeholder="생년월일(6자)" maxlength="6">
							</div>
							<div id="memberBirthMsg" class="msg"></div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberGender">성별</label>
						</div>	
							<div class="InputArea">
								<input type="radio" name="memberGender" id="male" value="male" checked="checked">
								<label for="male" >Male</label>
								<input type="radio" name="memberGender" id="female" value="female">
								<label for="female" >Female</label>
							</div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							주소
						</div>	
							<div class="InputArea_con">
								<input type="text" name="memberPostCode" id="memberPostcode" class="boxes" placeholder="우편번호">
								<input type="button" class="btn_send" onclick="fnPostcode()" value="우편번호 찾기">
								<input type="text" name="memberRoadAddr" id="memberRoadAddress" class="boxes"  placeholder="도로명주소">
							</div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberEmail">이메일 확인</label>
						</div>	
							<div class="InputArea">
								<input type="text" name="memberEmail" id="memberEmail" class="boxes" placeholder="이메일">
								<input type="button" class="btn_send" id="btnGetAuthCode" value="인증번호받기"><br>
								<div id="memberEmailMsg" class="msg"></div>
							</div>
					</div>
					<div class="InputAreaWapper">
						<div class="input">
							<label for="authCode">이메일 인증</label>
						</div>
							<div class="InputArea">	
								<input type="text" name="authCode" id="authCode" class="boxes" placeholder="인증코드를 입력하세요">
								<input type="button" class="btn_send" value="인증하기" id="btnVerifyAuthCode">
							</div>
					</div>
					
					<div class="InputAreaWapper">
						<div class="input">
							<label for="memberPromoAdd">이메일 수신여부</label>
						</div>	
							<div class="InputArea">
								<input type="radio" name="memberPromoAdd" id="agree_yes" value="yes" checked="checked">
								<label for="agree_yes">동의함</label>
								<input type="radio" name="memberPromoAdd" id="agree_no" value="no">
								<label for="agree_no">동의안함</label>
							</div>
					</div>
				</div>
				
				<div class="BtnArea">
					<input type="button" class="btn_signIn" value="취소" onclick="location.href='${contextPath}/'"> 
					<button class="btn_signIn">확인</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
