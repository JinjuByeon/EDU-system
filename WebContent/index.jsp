<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, study.*, board.*, subject.*" %>
<%@page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="sMgr" class="study.StudyMgr"></jsp:useBean>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<jsp:useBean id="cMgr" class="board.CommentMgr"></jsp:useBean>
<jsp:useBean id="subMgr" class="subject.SubjectMgr"></jsp:useBean>
<% 
	Date now = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
	String today = sf.format(now);
	
	ArrayList<StudyBean> alist = null;
	ArrayList<BoardBean> alist2 = null;
	ArrayList<SubjectBean> alist3 = null;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
	<link rel="stylesheet" href="bodyStyle.css?v=<%=System.currentTimeMillis() %>">
</head>
<body>
<%@ include file="header.jsp" %>
<script type="text/javascript">
	function boardRead(bnum) {
		<% if(user_name != null){ %>
			location.href="board_global/read.jsp?bnum="+bnum;	
		<% }else{ %>		
			alert("로그인 후 이용 가능합니다");
			location.href="member/login.jsp";
		<% } %>
	}
	function studyRead(num) {
		<% if(user_name != null){ %>
			location.href="study/studyRead.jsp?num="+num;	
		<% }else{ %>		
			alert("로그인 후 이용 가능합니다");
			location.href="member/login.jsp";
		<% } %>
	}
</script>
<div id="container">
    <div id="wrapping">
	    <div id="iWrap">
	    <div class="box1">
	    	<div class="schedule left">
	            <img class="main_icon" src="img/img06.png" alt="시간표아이콘"><h2>오늘 시간표</h2>
	            <p><%=today %></p>
	            <table>
	                <tr>
	                    <th>강의시간</th>
	                    <th>과목</th>
	                    <th>강사</th>
	                    <th>강의실</th>
	                </tr>
	           <%
	           alist3 = subMgr.getTodaySchedule(user.getNum());
	           if(alist3.isEmpty()){
	        	   out.print("<tr><td colspan='4'>오늘은 수업이 없습니다</td></tr>");
	           }else{
	        	   for(int i = 0; i<alist3.size(); i++){
	        		   SubjectBean bean = alist3.get(i);
	        		   String time = bean.getTime();
	        		   String title = bean.getSubject_title();
	        		   String name = bean.getName();
	        		   String location = bean.getLocation();
	        		%>
	                <tr>
	                    <td><%=time %></td>
	                    <td><%=title %></td>
	                    <td><%=name %></td>
	                    <td><%=location %></td>
	                </tr>	        		
	        		<%   
	        	   }
	           }
	           %>
	            </table>
	        </div>
	        <div class="pop_post left">
	            <img class="main_icon" src="img/img07.png" alt=""><h2>인기 게시글</h2>
	            <table border="1">
	           <%
	           		alist2 = bMgr.getPopBoard();
	           		if(alist2.isEmpty()){
	       				out.print("<tr><td colspan='3'>인기 게시글이 없습니다</td></tr>");
	       			}else{
	       				for(int i = 0; i<alist2.size(); i++){
	       					BoardBean bean = alist2.get(i);
	       					String title = bean.getTitle();
	       					int likes = bean.getLikes();
	       					int bnum = bean.getBnum();
	       		%>		
	                <tr>
	                    <th class="thead" align="center" width="40px"><%=i+1 %></th>
	                    <td width="350px"><a href="javascript:boardRead(<%=bnum%>);"><%=title %></a></td>
	                    <td class="border_hdn" width="85px"><img class="icon1" src="img/img09.png" alt=""><%=cMgr.getComment(bnum) %></td>
	                    <td class="border_hdn" width="85px"><img class="icon2" src="img/img03.png" alt=""><%=likes %></td>
	                </tr>       					
	       		<%	
	       				}
	       			}
	           %>
	            </table>
	        </div>
	        <div class="info left">
	            <img class="main_icon" src="img/img08.png" alt=""><h2>공지사항</h2>
	            <table border="1">
	                <tr>
	                    <th>구분</th>
	                    <th width="300px">제목</th>
	                    <th>등록일</th>
	                </tr>
	                <tr>
	                    <td colspan="3" align="center">등록된 공지사항이 없습니다</td>
	                </tr>
	            </table>
	        </div>
	    </div>
	    <div class="box2">
	    	<div class="classroom right">
	            <img class="main_icon" src="img/img05.png" alt="클래스룸아이콘"><h2>클래스룸</h2>
	            <%
	            	alist3 = subMgr.getRegSubject(user.getNum());
	            	if(alist3.size() == 0){%>
	            		<div style="padding: 20px" class="classroom_box">
	            			<h4>클래스룸이 없습니다</h4>
	            		</div>
	             <% }else{ 
						for(int i = 0; i<alist3.size(); i++){
							SubjectBean bean = alist3.get(i);
							String title = bean.getSubject_title();
							String name = bean.getName();					
				 %>
		                <div class="classroom_box">
		                    <div>
		                        <h4><%=title %></h4>
		                    </div>
		                    <div><h4><%=name %></h4></div>
		                    <img class="door" src="img/img10.png"><a href="classroom/classroom.jsp?subject=<%=title %>" class="entry">클래스룸 입장</a>
		                </div>
							
					<%	}
	             
	                } %>
	        </div>
	        <div class="study_list right">
	            <img class="main_icon" src="img/img4.png" alt=""><h2>신규 스터디 그룹</h2>
	            <div class="study_table">
	                <table border="1">
	                <%
	                	int total = sMgr.getTotalCount(null, null);
	                	alist = sMgr.getStudyList(null, null, 1, total);
	                	if(total == 0){
	                		out.print("<tr><td colspan='3'>등록된 스터디가 없습니다</td></tr>");
	                	}else{
	                		for(int i = 0; i<5; i++){
	                			StudyBean bean = alist.get(i);
	                			String filename = bean.getFilename();
	                			String gname = bean.getGname();
								int person = bean.getPerson();
								int num = bean.getNum();
								
						%>	
	                    <tr>
	                        <th>
	                       <%if(filename == null){%>
	                    	   <img class="study_img" src="study/img/img11.png" alt="">
	                       <%}else{%>
	                    	   <img class="study_img" src="study/fileUpload/<%=filename %>" alt="">
	                       <%} %>
	                        </th>
	                        <td class="study_name" width="180px"><a href="javascript:studyRead('<%=num%>')"><%=gname %></a></td>
	                        <td class="font_size">모집인원 | <%=person %>명</td>
	                    </tr>
						<%
	                		}
	                	}
	                %>
	                </table>
	            </div>
	        </div>
	    	</div>
	    </div>
    </div>
</div>

</body>
</html>