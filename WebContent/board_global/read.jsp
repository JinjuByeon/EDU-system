<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="board.*, java.util.*" %>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	int bnum = Integer.parseInt(request.getParameter("bnum"));
	
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	bMgr.upCount(bnum);
	BoardBean bean = bMgr.getBoard(bnum);
	session.setAttribute("bean", bean);
	
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <link rel="stylesheet" href="readStyle.css?v=<%=System.currentTimeMillis() %>">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
	function down(filename) {
		downFrm.filename.value = filename;
		downFrm.submit();
	}
	function list() {
<%		if(nowPage == null){
			%>listFrm.nowPage.value = "1";<%
}%>
		listFrm.submit();
	}
	
</script>
<%@ include file="header.jsp" %>

    <div id="bWrap">
	    <div id="wrapping">
	        <img src="img/img01.png" alt="게시판아이콘">
	        <h2>자유게시판</h2>
	        <div class="border">
	            <div class="read_container">
	                <table border="1">
	                    <tr>
	                        <td class="thead" width="80px" align="center">이름</td>
	                     <% if(bean.getAnon() == 2){ %>
	                     		<td width="220px">익명</td>
	                     <% }else{ %>
	                        	<td width="220px"><%=bean.getName() %></td>                     
	                     <% } %>
	                        <td class="thead" align="center" width="90px">작성일</td>
	                        <td><%=bean.getRegdate().substring(0, 16)%></td>
	                    </tr>
	                    <tr>
	                        <td class="thead" align="center">제목</td>
	                        <td colspan="3"><%=bean.getTitle() %></td>
	                    </tr>
	                    <tr>
	                        <td class="thead" align="center">첨부파일</td>
	                    <%
	                    String filename = bean.getFilename();
	                    if(filename == null){
	                    %>	
	                    	<td colspan="3">첨부 없음</td>
	                    <%	
	                    }else{
	                    %>	
	                    	<td colspan="3"><a href="javascript:down('<%=filename%>')"><%= filename%></a>
	                    	/ <font color="blue"><%= bean.getFilesize() %>byte</font>
	                    	</td>
	
	                    <%
	                    }
	                    %>
	                    </tr>
	                    <tr>
	                    <%
	                    if(filename != null && (filename.substring(filename.length()-3).equals("jpg")||filename.substring(filename.length()-3).equals("png"))){ %>
	                    	<td colspan="4">
	                    		<img class="content_img" alt="첨부이미지" src="fileUpload/<%=filename%>">
	                        	<pre><%= bean.getContent()%></pre>
	                        </td>
	                    <%}else{ %>
	                        <td height="100px" colspan="4">
	                        	<pre><%= bean.getContent()%></pre>
	                        </td>
	                   	<%} %>
	                    </tr>
	                </table>
	                <div class="count">
	                    <p>조회수 <%=bean.getCount() %></p>&emsp;
	                    <p><a href="javascript:likes();">공감<img class="like" src="img/img03.png" alt="좋아요아이콘"></a></p>
	                    <p id="likeCnt"><%=bean.getLikes() %></p>
	                </div>
	                <div class="buttons">
	                <%
	                if(user.getNum().equals(bean.getNum())){ %>
	                    <a href="javascript:list()">목록 </a>
	                    <a href="update.jsp?nowPage=<%=nowPage%>&bnum=<%=bnum%>">| 수정 |</a>
	                    <a href="javascript:onDelete();">삭제</a>	                	
	              <%}else{%>
	                	<a href="javascript:list()">목록 </a>
	              <%} %>
	                </div>
	        		<script type="text/javascript">
	        			function onDelete() {
							if(!confirm("삭제하시겠습니까?")){
								return;
							}else{
								location.href="delete.jsp?nowPage=<%=nowPage%>&bnum=<%=bnum%>";
							}
							
						}
	        		</script>
	                <form name="downFrm" method="post" action="download.jsp">
						<input type="hidden" name="filename">
					</form>
					<form name="listFrm" method="post" action="list.jsp">
						<input type="hidden" name="nowPage" value="<%=nowPage%>">
						<%
						if(!(keyWord==null || keyWord.equals(""))){
						%>
							<input type="hidden" name="keyField" value="<%=keyField%>">
							<input type="hidden" name="keyWord" value="<%=keyWord%>">
						<%	
						}
						%>
					</form>
	                <hr>
	                
		                <p>댓글</p>
		                <img class="icon" src="img/img02.png" alt="댓글아이콘">
		                	익명 <input type="checkbox" id="anon" name="anon" value="1">
		                	<input type="hidden" id="user_name" value="<%=user_name%>">
		                	<input type="hidden" id="user_id" value="<%=user.getUser_id()%>">
	                       <textarea name="content" id="comment" cols="90" rows="5"></textarea>
	                       <input type="button" value="댓글달기" class="sumit_bnt" onclick="insertComment();">
	                <div class="comment_area">
					</div>
	                <script type="text/javascript">
		                $(function () {
		        			commentList();
		        			setInterval(commentList, 1000);
		        		});
		                
		                function commentList() {
							$.ajax({
								url:"comentList.do",
								data:{bnum:<%=bnum%>},
								success:function(list){
									let result = "";
									for(let i = 0; i<list.length; i++){
										result += "<p>&ensp;";
										
										if(list[i].anon == 2){
											result += "익명 </p>&emsp;";
										}else{
											result += list[i].name +"</p>&emsp;";
										}
										result += list[i].regdate  + "<br>"
												+"<div class='comment_border'><pre>"
												+ list[i].content + "</pre></div><hr color='#eee'>";
									}
									$(".comment_area").html(result);
								},
								error:function(){
									console.log("ajax 통신실패");
								}
							});
						};
		                
	               		$(function(){
	               		    $("#anon").change(function(){
	               		        if($("#anon").is(":checked")){
	               		        	$("#anon").val("2");
	               		        }
	               		        else{
	               		        	$("#anon").val("1");
	               		        }
	               		    });
	               		});
	
	               		function insertComment() {
	               			if($("#comment").val() == ""){
	               				alert("댓글을 입력해주세요");
	               				reutrn;
	               			}
							$.ajax({
								url:"insert.do",
								data:{
									bnum:<%=bnum%>,
									name:$("#user_name").val(),
									content:$("#comment").val(),
									anon:$("#anon").val(),
									nowPage:<%=nowPage%>
								},
								type:"post",
								success:function(result){
									if(result > 0){
										/* commentList(); */
										$("#comment").val("");
										console.log("실행");
									}
								},
								error:function(){
									console.log("ajax 통신실패");
								}
							});
						};
						
						function likes() {
							$.ajax({
								url:"likes.do",
								data:{
									cnum:"0",
									bnum:<%=bnum%>,
									user_id:$("#user_id").val()
								},
								success:function(result){
									if(result != 0){
										$("#likeCnt").html(result);
									}else{
										alert("이미 공감한 게시글입니다");
									}
									
								},
								error:function(){
									console.log("ajax 통신실패");
								}
							})
						}
	                </script>
	                
	            </div>
	        </div>
        </div>
    </div>
</body>
</html>