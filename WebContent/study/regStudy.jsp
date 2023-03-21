<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="sbean" class="study.RegStudyBean"></jsp:useBean>
<jsp:useBean id="sMgr" class="study.StudyMgr"></jsp:useBean>
<jsp:setProperty property="*" name="sbean"/>
<%
	String msg = "신청에 실패하였습니다";
	String url = "studyRead.jsp?num="+sbean.getNum();
	
	int result = sMgr.regStudyInsert(sbean);
	
	if(result >= 1){
		msg = "신청이 완료되었습니다";
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