<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="study.*, java.util.*" %>
<jsp:useBean id="sMgr" class="study.StudyMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");

	int totalRecord = 0;
	int numPerPage = 5;
	int pagePerBlock = 5;
	
	int totalPage = 0;
	int totalBlock = 0;
	
	int nowPage = 1;
	int nowBlock = 1;
	
	int start = 0;
	int end = 0;		
	int listSize = 0;
	
	String keyField = "";
	String keyWord = "";
	/* [처음으로]를 누르면 맨 하단의 hidden의 reload */
	if(request.getParameter("reload") != null){
		if(request.getParameter("reload").equals("true")){			
			keyField = "";
			keyWord = "";
		}
	}
	if(request.getParameter("nowPage") != null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	ArrayList<StudyBean> alist = null;
	if(request.getParameter("keyWord") != null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	start = (nowPage * numPerPage)-numPerPage+1;				 // 각 페이지당 시작번호
	end = nowPage * numPerPage;									 // 각 페이지의 끝번호
	totalRecord = sMgr.getTotalCount(keyField, keyWord);   		 // 전체 레코드 수
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);	 // 전체 페이지 수
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);	 // 현재 블록
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); // 전페 블록 수
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=i, initial-scale=1.0">
    <title>Document</title>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
	<link rel="stylesheet" href="studyListStyle.css?v=<%=System.currentTimeMillis() %>">
	<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
	<script type="text/javascript">
	function read(num){
		<% if(user_name != null){ %>
		readFrm.num.value = num;
		readFrm.action = "studyRead.jsp";
		readFrm.submit();
		<% }else{ %>		
			alert("로그인 후 이용 가능합니다");
			location.href="../member/login.jsp";
		<% } %>
	}
	
	function post(){
		<% if(user_name != null){ %>
			location.href="studyPost.jsp";
		<% }else{ %>		
			alert("로그인 후 이용 가능합니다");
			location.href="../member/login.jsp";
		<% } %>
	}
	
	function pageing(page) {
		readFrm.nowPage.value = page;
		readFrm.submit();
	}
	function block(value) {
		readFrm.nowPage.value = <%= pagePerBlock%> * (value-1)+1;
		readFrm.submit();
	}
	function list() {
		listFrm.action = "studyList.jsp";
		listFrm.submit();
	}
	</script>
	
    <div id="sWrap">
        <div id="wrapping">
        <img class="studyIcon" src="img/img4.png" alt="스터디아이콘">
        <h2>스터디 리스트</h2>
        <div id="list_container">
            <div class="study_content">
            <form name="searchFrm" method="get" action="studyList.jsp">
                <table>
             <%
             	alist = sMgr.getStudyList(keyField, keyWord, start, end);
                listSize = alist.size();
                if(alist.isEmpty()){
                	out.print("<tr align='center' ><td colspan='5'>등록된 게시물이 없습니다</td></tr>");
                }else{
                	for(int i = 0; i<end; i++){
                		if(i == listSize){
        					break;
        				}
                		StudyBean bean = alist.get(i);
                		int num = bean.getNum();
                		String title = bean.getTitle();
                		String name = bean.getName();
                		String regdate = bean.getRegdate().substring(0,10);
                		String edate = bean.getEdate().substring(0,10);
                		int person = bean.getPerson();
                		String filename = bean.getFilename();
               %>
                    <tr class="first_row">
                        <td  class="first_row" rowspan="3" width="200px">
                        <%if(filename == null){%>
                        	<img class="study_img" src="img/img11.png" alt="스터디사진">
                       <%}else{%>                        
                            <img class="study_img" src="fileUpload/<%=filename %>" alt="스터디사진">
                       <% } %>
                        </td>
                        <td width="300px"><h3><a href="javascript:read('<%=num%>')"><%=title %></a></h3></td>
                        <td colspan="2"><p>작성자 | <%=name %></p></td>
                        <td><p><%=regdate %></p></td>
                    </tr>
                    <tr>
                        <td colspan="">모집기간 | <%=regdate %>~<%=edate %></td>
                    <%
                    	if(sMgr.getRegCnt(num) >= person){%>
                    		<td colspan="3"><font color="red">모집마감</font></td>
                    <%  }else{ %>
                        	<td colspan="3"><font color="red">모집중</font></td>                    		
                    <%	} %>
                    </tr>
                    <tr>
                        <td colspan="" height="30px">모집인원 | <%=person %> 명</td>
                        <td colspan="3">현재인원 | <%=sMgr.getRegCnt(num) %> 명</td>
                    </tr>
                    <tr class="last_row">
                        <td height="20px"></td>
                    </tr>
               <% }
                } %>
                    
                    <tr class="bdrHbn">
                        <td colspan="6" class="bdrHbn">
                      <%
                      	int pageStart = (nowBlock-1) * pagePerBlock+1;
	      				int pageEnd = (pageStart + pagePerBlock <= totalPage) ? (pageStart + pagePerBlock) : totalPage+1;
	      				
	      				if(totalPage != 0){
      					if(nowBlock > 1){ %>
      						<a href="javascript:block('<%=nowBlock-1%>')">prev...</a>
                      <%
      					}
    					out.print("&nbsp;");
    					for(;pageStart < pageEnd; pageStart++){ %>
    						<a href="javascript:pageing('<%=pageStart%>')">
    				  <%if(pageStart == nowPage){ %>
    				  		<font color="#555">
    				  		<%} %>
						[<%=pageStart %>]
						<%if(pageStart == nowPage){ %>						
							</font>
						<%} %>
						</a>
				<%		}
    					out.print("&nbsp;");
    					if(totalBlock > nowBlock){ %>
    						<a href="javascript:block('<%=nowBlock+1%>')">...next</a>
    				<%		}
	      				}
                      %>
   
                        </td>
                    </tr>
                </table>
                <div class="search">
                <select name="keyField">
                    <option value="title">제목
                    <option value="name">작성자
                    <option value="content">내용
                </select>
                
                    <input type="text" name="keyWord" required>
                    <input type="submit" value="찾기">
                    <input type="hidden" name="nowPage" value="1">
                </div>
                <form name="listFrm" method="post">
					<input type="hidden" name="reload" value="true">
					<input type="hidden" name="nowPage" value="1">
				</form>
                </form>
                <!-- 처음으로 누르면 화면을 reload하기 -->
				<form name="listFrm" method="post">
					<input type="hidden" name="reload" value="true">
					<input type="hidden" name="nowPage" value="1">
				</form>
                <form name="readFrm" method="get" action="studyList.jsp">
					<input type="hidden" name="num">
					<input type="hidden" name="nowPage" value="1">
					<input type="hidden" name="keyField" value="<%= keyField%>">
					<input type="hidden" name="keyWord" value="<%= keyWord%>">
				</form>
                <div class="buttons">
                    <input type="button" value="글쓰기" onclick="post();">
                    <input type="button" value="처음으로">
                </div>
            </div>
        </div>
       </div>
    </div>
</body>
</html>