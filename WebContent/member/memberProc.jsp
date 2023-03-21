<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="member.MemberMgr"></jsp:useBean>
<jsp:useBean id="memberBean" class="member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="memberBean"/>
<%
	int part= Integer.parseInt(request.getParameter("part"));
	boolean result = false;
	String msg = "회원가입에 실패하였습니다";
	String url = "member.jsp";
	
	String tel = "010-"+request.getParameter("tel1") + "-" + request.getParameter("tel2");
	memberBean.setTel(tel);
	
	String addr = request.getParameter("addr") + " " + request.getParameter("detailAddress");
	memberBean.setAddr(addr);
	
	String email = request.getParameter("email") +"@"+ request.getParameter("eAddr");
	memberBean.setEmail(email);
	
	result = mMgr.insertStudent(memberBean);
	

	if(result){
		msg = "회원가입이 완료되었습니다";
		url = "login.jsp";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	alert("<%=msg%>");
	location.href= "<%= url%>";
</script>
</body>
</html>