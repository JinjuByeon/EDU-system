<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
	<link rel="stylesheet" href="studyPostStyle.css?v=<%=System.currentTimeMillis() %>">
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
    <div id="sWrap">
        <img class="studyIcon" src="img/img4.png" alt="스터디아이콘">
        <h2>스터디 등록하기</h2>
        <form name="sPostFrm" method="post" enctype="multipart/form-data" action="studyPost">
            <div class="border">
                <table>
                    <tr>
                        <th colspan="4" align="center"><h3>글 작성하기</h3></th>
                    </tr>
                    <tr>
                        <th>성명</th>
                        <td><input type="text" name="name" value="<%=user.getName() %>" size="10" readonly></td>
                        <th>
                            스터디 명
                        </th>
                        <td><input type="text" name="gname" size="27" maxlength="15"></td>
                    </tr>
                    <tr>
                        <th>모집인원</th>
                        <td><input type="number" name="person"></td>
                        <th>모집기간</th>
                        <td><input type="date" name="edate" required></td>
                    </tr>
                    <tr>
                        <th>제목</th>
                        <td colspan="3"><input type="text" name="title" size="60"></td>
                    </tr>
                    <tr>
                        <th>내용</th>
                        <td colspan="3"><textarea name="content" id="" cols="30" rows="10"></textarea></td>
                    </tr>
                    <tr>
                        <th>프로필사진</th>
                        <td colspan="3"><input type="file" name="filename"></td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4" class="buttons">
                        	<input type="hidden" name="student_id" value="<%=user.getNum()%>">
                            <input type="submit" value="등록">
                            <input type="button" value="목록" onclick="location.href='studyList.jsp'">
                        </td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>