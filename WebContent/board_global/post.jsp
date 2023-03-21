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
    <link rel="stylesheet" href="postStyle.css?v=<%=System.currentTimeMillis() %>">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <scrip src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>

    <div id="bWrap">
    	<div id="wrapping">
	        <img src="img/img01.png" alt="게시판아이콘">
	        <h2>자유게시판</h2>
	        <form name="postFrm" method="post" enctype="multipart/form-data" action="boardPost">
	            <div class="border">
	                <table>
	                    <tr>
	                        <th colspan="3" align="center"><h3>글 작성하기</h3></th>
	                    </tr>
	                    <tr>
	                        <th>성명</th>
	                        <td><input type="text" name="name" value="<%=user_name %>" readonly></td>
	                        <th>공개 <input type="radio" name="anon" value="1" checked>&emsp;
	                            비공개 <input type="radio" name="anon" value="2">
	                        </th>
	                    </tr>
	                    <tr>
	                        <th>제목</th>
	                        <td colspan="2"><input type="text" name="title" size="60" required></td>
	                    </tr>
	                    <tr>
	                        <th>내용</th>
	                        <td colspan="2"><textarea name="content" id="" cols="30" rows="10" required></textarea></td>
	                    </tr>
	                    <tr>
	                        <th>파일찾기</th>
	                        <td colspan="2"><input type="file" name="filename"></td>
	                    </tr>
	                    <tr>
	                        <td align="center" colspan="3" class="buttons">
	                            <input type="submit" value="등록">
	                            <input type="button" value="목록" onclick="location.href='list.jsp'">
	                        </td>
	                    </tr>
	                </table>
	                <input type="hidden" name="num" value="<%=user.getNum()%>">
	            </div>
	        </form>
        </div>
    </div>
</body>
</html>