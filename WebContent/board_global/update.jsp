<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	String nowPage = request.getParameter("nowPage");
	BoardBean bean = (BoardBean)session.getAttribute("bean");
	String name = bean.getName();
	String title = bean.getTitle();
	String content = bean.getContent();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link rel="stylesheet" href="postStyle.css?v=<%=System.currentTimeMillis() %>">
</head>
<body>
<%@ include file="header.jsp" %>
   <div id="bWrap">
    	<div id="wrapping">
	        <img src="img/img01.png" alt="게시판아이콘">
	        <h2>자유게시판</h2>
	        <form name="updateFrm" method="post" action="boardUpdate">
	            <div class="border">
	                <table>
	                    <tr>
	                        <th colspan="3" align="center"><h3>글 수정하기</h3></th>
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
	                        <td colspan="2"><input type="text" name="title" size="60" value="<%=title %>" required></td>
	                    </tr>
	                    <tr>
	                        <th>내용</th>
	                        <td colspan="2"><textarea name="content" id="" cols="30" rows="10" value="<%=content %>" required></textarea></td>
	                    </tr>
	                   
	                    <tr>
	                        <td align="center" colspan="3" class="buttons">
	                        <input type="hidden" name="nowPage" value="<%=nowPage%>">
							<input type="hidden" name="bnum" value="<%=bnum%>">
	                            <input type="submit" value="수정">
	                            <input type="button" value="목록" onclick="location.href='list.jsp'">
	                        </td>
	                    </tr>
	                </table>
	            </div>
	        </form>
        </div>
    </div>
</body>
</html>