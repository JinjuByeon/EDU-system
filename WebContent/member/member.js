function inputIdchk(){
	$.ajax({
		url:"idcheck.do",
		data:{user_id:$("#id").val()},
		success:function(result){
			if(result == "y"){
				$("#idcheck").html("이미 사용중인 아이디 입니다");
				$("#idcheck").css("color", "red");
				$("#idcheck").css("font-size", "15px");
				$("input[name=idchk]").val("2");
			}else{
				$("#idcheck").html("사용가능");
				$("#idcheck").css("color", "#333");
				$("#idcheck").css("font-size", "15px");
				$("input[name=idchk]").val("1");
			}
		},
		error:function(){
			console.log("ajax 통신실패");
		}
	})
}


function findAddr() {
    new daum.Postcode({
        oncomplete: function(data) {
        	document.getElementById("postcode").value = data.zonecode;
            roadAddr = data.roadAddress;
            jibunAddr = data.jibunAddress;
            extraAddr = '';
            if(roadAddr != ''){
         	   if(data.bname != ''){
         		   extraAddr += data.bname;
         	   }
         	   if(data.buildingName != ''){
         		   extraAddr += (extraAddr != '')? ', '+ data.buildingName : data.buildingName;
         	   }
         	   roadAddr += (extraAddr != '')? ' ('+extraAddr + ')' : '';
         	   document.getElementById('addr').value = roadAddr;
            }else if(jibunAddr != ''){
         	   document.getElementById('addr').value = jibunAddr;
            }
            regFrm.detailAddress.focus();
        }
    }).open();
}

function inputCheck(){
    if(regFrm.name.value == ""){
        alert("이름을 입력하세요");
        regFrm.name.focus();
        return;
    }
	
	if(regFrm.gender.value == ""){
        alert("성별을 체크해주세요");
        regFrm.gender.focus();
        return;
    }

	if(regFrm.num.value == ""){
        alert("학번/교직원번호를 입력해주세요");
        regFrm.num.focus();
        return;
    }
	
	if(regFrm.part.value == ""){
        alert("학생 / 교직원을 선택해주세요");
        regFrm.part.focus();
        return;
    }

	if(regFrm.major.value == "select"){
        alert("전공을 선택해주세요");
        regFrm.major.focus();
        return;
    }

	if(regFrm.birthday.value == ""){
        alert("생일을 입력해주세요");
        regFrm.birthday.focus();
        return;
    }
	
	if(regFrm.tel1.value == ""){
        alert("전화번호를 입력해주세요");
        regFrm.tel1.focus();
        return;
    }
	if(regFrm.tel2.value == ""){
        alert("전화번호를 입력해주세요");
        regFrm.tel2.focus();
        return;
    }
	
	if(regFrm.email.value == ""){
        alert("이메일을 입력해주세요");
        regFrm.email.focus();
        return;
    }

	if(regFrm.addr.value == ""){
        alert("주소를 입력해주세요");
        regFrm.addr.focus();
        return;
    }

	if(regFrm.user_id.value == ""){
        alert("아이디을 입력해주세요");
        regFrm.user_id.focus();
        return;
    }

	if(regFrm.idchk.value == "2"){
        alert("중복되는 아이디 입니다");
        regFrm.user_id.focus();
        return;
    }

	if(regFrm.password.value == ""){
        alert("비밀번호를 입력해주세요");
        regFrm.password.focus();
        return;
    }

	if(regFrm.password.value != regFrm.repass.value){
		alert("비밀번호가 일치하지 않습니다");
		regFrm.repass.focus();
        return;
	}
	regFrm.submit();
}


