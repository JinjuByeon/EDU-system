<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <style>
        *{
            margin: 0;padding: 0;box-sizing: border-box;

            font-family: 'NanumSquareLight';
            font-family: 'NanumSquare';
            font-family: 'NanumSquareBold';
            font-family: 'NanumSquareExtraBold';
            font-family: 'NanumSquareAcb';
            font-family: 'NanumSquareAceb';
            font-family: 'NanumSquareAcl';
            font-family: 'NanumSquareAcr';
		}
		#loginWrap{
			width: 1130px;
			margin: 0 auto;
			background-color: white;
			height: 900px;
			padding-top: 100px;
		}
        fieldset{
            width: 400px;
            margin: 0 auto;
            border: 5px solid #eee;
            border-radius: 20px;
            padding: 30px;
            padding-left: 50px;
        }
        legend{
            font-weight:bold;
            font-size:40px;
            color: #6a329f
        }
        input[type=text], input[type=password]{
            padding: 6px 15px;
            margin: 2px;
            display: inline-block;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            margin-bottom: 15px;
            width: 200px;
            height: 35px;
        }
        input[type=submit], input[type=button]{
            background-color:#555555;
            color: white;
            border: 2px solid #555555;
            padding: 5px 10px;
            width: 80px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 20px;
            margin-top: 25px;
            float: right;
        }
        input[type=submit]:hover, input[type=button]:hover{
            background-color: white;
  	        color: black;
        }
    </style>
</head>
<body>
	<%@ include file="header.jsp" %>
    <div id="loginWrap">
        <form name="loginFrm" method="post" action="loginProc.jsp">
            <fieldset>
                <legend>LOG IN</legend>
                <label for="id">아이디</label><br>
                <input type="text" id="id" name="id" placeholder="아이디를 입력해주세요" required><br>
                <label for="pw">비밀번호</label><br>
                <input type="password" id="ps" name="pwd" placeholder="비밀번호를 입력해주세요" required><br><br>
                <input type="submit" value="로그인"><input type="button" value="회원가입" onclick="location.href='member.jsp'">
            </fieldset>
        </form>
    </div>
</body>
</html>