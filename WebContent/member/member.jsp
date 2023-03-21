<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="member.css?v=<%=System.currentTimeMillis() %>">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="member.js?v=<%=System.currentTimeMillis() %>"></script>

</head>
<body>
	<%@ include file="header.jsp" %>
<div id="memWrap">
    <form id="regFrm" name="regFrm" method="post" action="memberProc.jsp">
        <h2>회원가입</h2>
        <table>
            <tr>
                <td>이름</td>
                <td><input type="text" name="name" required>
                </td>
                <td>성별</td>
                <td class="radio">
                    <input name="gender" type="radio" value="m"> 남 &emsp;
                    <input name="gender" type="radio" value="f"> 여
                </td>
            </tr>
            <tr>
                <td>학번/교직원번호</td>
                <td  class="radio">
                    <input type="text" name="num" size="8" maxlength="8">&emsp;
                    <input type="radio" name="part" value="1"> 학생&emsp;
                    <input type="radio" name="part" value="2"> 교직원
                </td>
                <td>전공</td>
                <td>
                    <select name="major" id="">
                        <option value="select">선택</option>
                        <option value="국어국문학과">국어국문학과</option>
                        <option value="독어독문학과">독어독문학과</option>
                        <option value="영어영문학과">영어영문학과</option>
                        <option value="철학과">철학과</option>
                        <option value="교육학과">교육학과</option>
                        <option value="수학과">수학과</option>
                        <option value="컴퓨터공학과">컴퓨터공학과</option>
                        <option value="경영학과">경영학과</option>
                        <option value="경제학과">경제학과</option>
                        <option value="기계공학과">기계공학과</option>
                        <option value="법학과">법학과</option>
                        <option value="사회학과">사회학과</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>생년월일</td>
                <td><input type="date" name="birthday" required></td>
            </tr>
            <tr>
                <td>전화번호</td>
                <td colspan="3">
                    <input type="text" size="3" placeholder="010" readonly> -
                    <input type="text" size="7" name="tel1" maxlength="4" required> -
                    <input type="text" size="7" name="tel2" maxlength="4" required>
                </td>
            </tr>
            <tr>
                <td>이메일</td>
                <td colspan="3">
                    <input type="text" name="email"> @
                    <select name="eAddr" id="">
                        <option value="naver.com">naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="nate.com">nate.com</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>우편번호</td>
                <td><input type="text" name="zipcode" id="postcode" readonly></td>
                <td colspan="2"><input type="button" value="우편번호찾기" onclick="findAddr();"></td>
            </tr>
            <tr>
                <td>주소</td>
                <td colspan="3">
                    <input type="text" name="addr" id="addr" size="40" readonly required><br>
                    <input type="text" name="detailAddress" placeholder="상세주소">
                </td>
            </tr>
            <tr>
                <td>아이디</td>
                <td>
                	<input type="text" id="id" name="user_id" onkeyup="inputIdchk();" required>
                	<input type="hidden" id="idchk" name="idchk" value="1">
                </td>
                <td colspan="2" id="idcheck"></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="password" required></td>
            </tr>
            <tr>
                <td>비밀번호 확인</td>
                <td><input type="password" name="repass" required></td>
            </tr>
            <tr>
                <td class="submit" colspan="4">
                    <input type="button" value="회원가입" onclick="inputCheck();">
                    <input type="button" value="홈으로" onclick="location.href=''">
                </td>
            </tr>

        </table>
    </form>
</div>
</body>
</html>