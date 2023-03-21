<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="study.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	StudyBean bean = (StudyBean)session.getAttribute("sBean");
	String name = bean.getName();
	String gname = bean.getGname();
	int person = bean.getPerson();
	String title = bean.getTitle();
	String content = bean.getContent();
	String edate = bean.getEdate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<link rel="stylesheet" href="studyPostStyle.css?v=<%=System.currentTimeMillis() %>">
</head>
<body>
<%@ include file="header.jsp" %>
<div id="sWrap">
        <img class="studyIcon" src="img/img4.png" alt="스터디아이콘">
        <h2>스터디 등록하기</h2>
        <form name="sPostFrm" method="post" action="studyUpdate">
            <div class="border">
                <table>
                    <tr>
                        <th colspan="4" align="center"><h3>글 수정하기</h3></th>
                    </tr>
                    <tr>
                        <th>성명</th>
                        <td><input type="text" name="name" value="<%= name%>" size="10" readonly></td>
                        <th>
                            스터디 명
                        </th>
                        <td><input type="text" name="gname" size="27" maxlength="15" value="<%=gname %>"></td>
                    </tr>
                    <tr>
                        <th>모집인원</th>
                        <td><input type="number" name="person" value="<%=person %>" required></td>
                        <th>모집기간</th>
                        <td><input type="date" name="edate" required></td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td colspan="3"><input type="text" name="title" size="60" value="<%=title%>"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td colspan="3"><textarea name="content" id="" cols="30" rows="10"><%=content %></textarea></td>
                    </tr>
                    
                    <tr>
                        <td align="center" colspan="4" class="buttons">
                        	<input type="hidden" name="student_id" value="<%=user.getNum()%>">
                            <input type="submit" value="수정">
                            <input type="button" value="목록" onclick="location.href='studyList.jsp'">
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="nowPage" value="<%=nowPage%>">
				<input type="hidden" name="num" value="<%=num%>">
            </div>
        </form>
    </div>


</body>
</html>