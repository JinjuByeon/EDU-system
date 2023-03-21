<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*, java.util.*" %>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<jsp:useBean id="cMgr" class="board.CommentMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	
	int totalRecord = 0;
	int numPerPage = 10;
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
	ArrayList<BoardBean> alist = null;
	if(request.getParameter("keyWord") != null){
		keyWord = request.getParameter("keyWord");
		keyField = request.getParameter("keyField");
	}
	
	start = (nowPage * numPerPage)-numPerPage+1;				 // 각 페이지당 시작번호
	end = nowPage * numPerPage;									 // 각 페이지의 끝번호
	totalRecord = bMgr.getTotalCount(keyField, keyWord);   		 // 전체 레코드 수
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);	 // 전체 페이지 수
	nowBlock = (int)Math.ceil((double)nowPage / pagePerBlock);	 // 현재 블록
	totalBlock = (int)Math.ceil((double)totalPage / pagePerBlock); // 전페 블록 수
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <link rel="stylesheet" href="listStyle.css?v=<%=System.currentTimeMillis() %>">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
</head>
<body>
<%@ include file="header.jsp" %>
	<script>
		function read(bnum){
		<% if(user_name != null){ %>
			readFrm.bnum.value = bnum;
			readFrm.action = "read.jsp";
			readFrm.submit();
		<% }else{ %>		
			alert("로그인 후 이용 가능합니다");
			location.href="../member/login.jsp";
		<% } %>
		}
		
		function post(){
			<% if(user_name != null){ %>
				location.href="post.jsp";
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
			listFrm.action = "list.jsp";
			listFrm.submit();
		}
		
	</script>
    <div id="bWrap">
    <div id="wrapping">
        <img src="img/img01.png" alt="게시판아이콘">
        <h2>자유게시판</h2>
        <div class="list_container">
        <h3>게시글 목록</h3>
            <form name="searchFrm" method="get" action="list.jsp">
                <p>Total : <%= totalRecord%>Articles(<font color="blue"><%=nowPage %>/<%=totalPage %>Page</font>)</p>
                <table>
                    <tr class="thead">
                        <td width="5%">번호</td>
                        <td colspan="3" width="50%">제목</td>
                        <td width="12%">작성자</td>
                        <td width="16%">게시일</td>
                        <td width="6%">조회수</td>
                    </tr>
             <%
           		alist = bMgr.getBoardList(keyField, keyWord, start, end);
           		listSize = alist.size();
           		if(alist.isEmpty()){
           			out.print("<tr align='center' ><td colspan='7'>등록된 게시물이 없습니다</td></tr>");
           		}else{
           			for(int i = 0; i<end; i++){
           				if(i == listSize){
        					break;
        				}
           				BoardBean bean = alist.get(i);
           				int bnum = bean.getBnum();
           				String title = bean.getTitle();
           				String name = bean.getName();
           				String regdate = bean.getRegdate();
           				int count = bean.getCount();
           				int likes = bean.getLikes();
             %>				
               		<tr>
                        <td align="center"><%= i+1 %></td>
                        <td class="title"><a href="javascript:read('<%=bnum%>')"><%=title %></a></td>
                        <td class="likes"><img class="icon1" src="img/img09.png" alt="댓글아이콘"><%=cMgr.getComment(bnum) %></td>
                        <td class="likes"><img class="icon2" src="img/img03.png" alt="공감아이콘"><%=likes %></td>
                  <% if(bean.getAnon() == 2){ %>
                  		<td align="center">익명</td>
                  <% }else{ %>
                        <td align="center"><%= name%></td>                  
                  <% } %>
                        <td align="center"><%= regdate.substring(0, 16)%></td>
                        <td align="center"><%= count%></td>
                    </tr>				
             <%		}
             	}
             %>
                    
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
                <hr>
                <div class="search">
                <select name="keyField">
                    <option value="name">이름
                    <option value="title">제목
                    <option value="content">내용
                </select>
                
                    <input type="text" name="keyWord" required>
                    <input type="submit" value="찾기">
                    <input type="hidden" name="nowPage" value="1">
                </div>
            </form>
            
            <form name="listFrm" method="post">
				<input type="hidden" name="reload" value="true">
				<input type="hidden" name="nowPage" value="1">
			</form>
			
			<div class="buttons">
                <input type="button" value="글쓰기" onclick="post();">
                <input type="button" value="처음으로" onclick="list()">
            </div>
            <!-- 처음으로 누르면 화면을 reload하기 -->
			<form name="listFrm" method="post">
				<input type="hidden" name="reload" value="true">
				<input type="hidden" name="nowPage" value="1">
			</form>
			<!-- 제목을 누르면 상세보기 페이지 보기 -->
            <form name="readFrm" method="get" action="list.jsp">
				<input type="hidden" name="bnum">
				<input type="hidden" name="nowPage" value="1">
				<input type="hidden" name="keyField" value="<%= keyField%>">
				<input type="hidden" name="keyWord" value="<%= keyWord%>">
			</form>
        </div>
        </div>
     </div>
</body>
</html>