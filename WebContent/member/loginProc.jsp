<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*" %>
<jsp:useBean id="mMgr" class="member.MemberMgr"></jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String msg = "로그인에 실패하였습니다";
	String url = "login.jsp";
	
	MemberBean bean = new MemberBean();
	boolean result = mMgr.loginMember(id, pwd);
	if(result){
		bean = mMgr.getMember(id);
		session.setAttribute("userInfo", bean);

		msg = "로그인 하였습니다";
		url = "../index.jsp";
	}
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
</head>
<body>

</body>
</html>