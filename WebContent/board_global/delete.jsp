<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>  
<%
	request.setCharacterEncoding("UTF-8");
	boolean result;
	String nowPage = request.getParameter("nowPage");
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	
	String msg = "삭제에 실패하였습니다";
	String url = "read.jsp?bnum="+bnum;
	
	result = bMgr.deleteBoard(bnum);
	if(result){
		msg = "삭제되었습니다";
		url = "list.jsp";
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