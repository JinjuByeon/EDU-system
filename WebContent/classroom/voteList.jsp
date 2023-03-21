<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String title = request.getParameter("subject");
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
        html,body,div,span{
	        margin: 0;padding: 0;
        }
        ul,ol,li{
            list-style: none;
        }
        a:link{
            color: #555;	
        }
        a:hover{
            color: #555;
            color: black;
        }
        a{
            text-decoration: none;
            color: #555;
        }
        .display_none{
            display: none;
        }
        #container{
            width: 100%;
            margin: 0px auto;
            padding: 30px;
            background-color: #E3F2FD;
        }
        #wrapping{
            width: 1100px;
            margin: 0 auto;
        }
        .nev{
            width: 130px;
            position: absolute; top: 430px; left: 440px;
        }
        .nev li{
            display: inline-block;
            font-size: 18px;
            margin-bottom: 5px;
        }
        .nev li a{
            display: block;
            color: #555;
            width: 130px;
            text-align: center;
            line-height: 3.6;
            font-weight: bold;
        }
        .border{
            width: 850px;
            height: 700px;
            margin: 70px auto;
            background-color: #fff;
            border-radius: 2px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24);
            transition: all 0.3s cubic-bezier(.25,.8,.25,1);
        }
        .postit{
            position: absolute;top: 350px;left: 200px;
        }
        h2{
            display: inline-block;
            font-size: 22px;
        }
        .cIcon{
            width: 40px;
            vertical-align: middle;
            margin-right: 20px;
            margin-left: 70px;
        }
    </style>
</head>
<body>
<%@ include file="header.jsp" %>
    <div id="container">
        <div id="wrapping">
            <img class="postit" src="../img/postit.png" alt="">
            <ul class="nev">
                <li><a href="">강의계획서</a></li>
                <li><a href="">토론</a></li>
                <li><a href="voteList.jsp?subject=<%=title %>">투표</a></li>
                <li><a href="">과제</a></li>
                <li><a href="qnaList.jsp?subject=<%=title %>">질의응답</a></li>
                <li><a href="">열린게시판</a></li>
            </ul>
            <img class="cIcon" src="../img/img05.png" alt=""><h2><%=title %></h2>
            <div class="border">
                
            </div>
        </div>
    </div>
</body>
</html>