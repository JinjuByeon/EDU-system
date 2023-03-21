<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="study.StudyBean" %>
<jsp:useBean id="sMgr" class="study.StudyMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	boolean result;
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	
	String msg = "삭제에 실패하였습니다";
	String url = "studyRead.jsp?num="+num;
	
	result = sMgr.deleteStudy(num);
	if(result){
		msg = "삭제되었습니다";
		url = "studyList.jsp";
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
</body>
</html>