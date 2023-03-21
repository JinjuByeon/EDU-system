<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.*, java.util.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link rel="stylesheet" href="homestyle.css">
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
    <script src="home.js"></script>
</head>
<%
	MemberBean user = new MemberBean();
	String user_name = null;
	String part = "";
	
	Enumeration<String> e = session.getAttributeNames();
	while(e.hasMoreElements()){
		if(e.nextElement().equals("userInfo")){
			user = (MemberBean)session.getAttribute("userInfo");	
			user_name = user.getName();
			if(user.getPart().equals("s")){
				part = "학생";
			}else if(user.getPart().equals("t")){
				part = "선생님";
			}
		}
	}
	
%>
<body>
    <div id="wrap">
        <header id="header">
            <div id="header_top">
                <h1 id="logo"><a href="../index.jsp">logo</a></h1>
                <ul class="login">
                
			<% if(user_name != null && request.isRequestedSessionIdValid()){ %>
			
                    <li><a href=""><%=user_name%> <%=part%></a></li>
                    <li><a href="logout.jsp">로그아웃</a></li>

			<% }else{ %>	
						
					<li><a href="login.jsp">로그인</a></li>
                    <li><a href="member.jsp">회원가입</a></li>
				
			<% } %>

                </ul>
            </div>
            <nav>
                <ul class="gnb">
                    <li><a href="">교육</a>
                        <ul class="submenu_list depth1">
                            <li><a href="">개설과목</a></li>
                            <li><a href="">학사일정</a></li>
                        </ul>
                    </li>
                    <li><a href="">커뮤니티</a>
                        <ul class="submenu_list depth2">
                            <li><a href="../board_global/list.jsp">자유게시판</a></li>
                            <li><a href="../study/studyList.jsp">스터디그룹</a></li>
                        </ul>
                    </li>
                    <li><a href="">공지</a>
                        <ul class="submenu_list depth3">
                            <li><a href="">공지사항</a></li>
                            <li><a href="">FAQ</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </header>
    </div>
</body>
</html>