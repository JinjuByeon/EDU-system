<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="study.*, java.util.*" %>
<jsp:useBean id="sMgr" class="study.StudyMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	
	String nowPage = request.getParameter("nowPage");
	String keyField = request.getParameter("keyField");
	String keyWord = request.getParameter("keyWord");
	
	StudyBean bean = sMgr.getStudy(num);
	session.setAttribute("sBean", bean);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
	<link rel="stylesheet" href="studyReadStyle.css?v=<%=System.currentTimeMillis() %>">
</head>
<script type="text/javascript">
	function list() {
	<%	if(nowPage == null){
			%>listFrm.nowPage.value = "1";<%
		}%>
		listFrm.submit();
	}
	
</script>
<script>
      function wrapWindowByMask(){
     
     //화면의 높이와 너비를 구한다.
     var maskHeight = $(document).height();  
     var maskWidth = $(window).width();  

     //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
     $("#mask").css({"width":maskWidth,"height":maskHeight});  

     //애니메이션 효과 - 일단 0초동안 까맣게 됐다가 60% 불투명도로 간다.

     $("#mask").fadeIn(0);      
     $("#mask").fadeTo("slow",0.6);    

     //윈도우 같은 거 띄운다.
     $(".window").show();
	 
     }
        
     function wrapWindowByMask2(){
         
         var maskHeight = $(document).height();  
         var maskWidth = $(window).width();  

         $("#mask").css({"width":maskWidth,"height":maskHeight});  

         $("#mask").fadeIn(0);      
         $("#mask").fadeTo("slow",0.6);    

         $(".window2").show();

     }
     
     
 $(document).ready(function(){
     //검은 막 띄우기
     $(".openMask").click(function(e){
         e.preventDefault();
       <%if(bean.getPerson() <= sMgr.getRegCnt(num)){
    		%> alert("모집이 마감되었습니다"); <%   
       }else{
    	   %> wrapWindowByMask();<%
       }
       %>
     });
	 
     $(".openMask2").click(function(e){
         e.preventDefault();
         wrapWindowByMask2();
     });
     
     //닫기 버튼을 눌렀을 때
     $(".window .close").click(function (e) {  
         //링크 기본동작은 작동하지 않도록 한다.
         e.preventDefault();  
         $("#mask, .window").hide();  
     });
     
     $(".window2 .close").click(function (e) {  
         //링크 기본동작은 작동하지 않도록 한다.
         e.preventDefault();  
         $("#mask, .window2").hide();  
     }); 

     //검은 막을 눌렀을 때
     $("#mask").click(function () {  
         $(this).hide();  
         $(".window").hide();  

     });
     
 });
    </script>
<body>
<%@ include file="header.jsp" %>
    <div id="sWrap">
    	<div id="wrapping">
        <img class="studyIcon" src="img/img4.png" alt="스터디아이콘">
        <h2>스터디 상세</h2>
	        <div class="border">
	            <div class="read_container">
	                <table border="1">
	                    <tr>
	                        <td class="thead" width="80px">모임장</td>
	                        <td width="220px"><%=bean.getName() %></td>
	                        <td class="thead" width="90px">스터디 명</td>
	                        <td><%=bean.getGname() %></td>
	                    </tr>
	                    <tr>
	                        <td class="thead">모집인원</td>
	                        <td><%=bean.getPerson() %></td>
	                        <td class="thead">모집기간</td>
	                        <td><%= bean.getRegdate().substring(0,10)%>~<%=bean.getEdate().substring(0,10) %></td>
	                    </tr>
	                    <tr>
	                        <td class="thead">작성일</td>
	                        <td colspan="3"><%= bean.getRegdate().substring(0,10)%></td>
	                    </tr>
	                    <tr>
	                        <td class="thead">제목</td>
	                        <td colspan="3"><%=bean.getTitle() %></td>
	                    </tr>
	                    <tr>
	                        <td height="100px" colspan="4"><pre><%=bean.getContent() %></pre></td>
	                    </tr>
	                </table>
	                
	                <div class="apply">
	                <%
	                if(user.getNum().equals(bean.getStudent_id())){
	                	%><input type="button" class="openMask2" value="스터디원"><%
	                }else{
	                	%><input type="button" class="openMask" value="신청하기"><%
	                }
	                %>
                    <div id="mask"></div>
                    <div class="window2">
                    	<div id="container2">
                    		<h3 class="subj">스터디 신청자 명단</h3>
						        <table border="1">
						            <tr>
						                <th width="70px">이름</th>
						                <th>연락처</th>
						                <th width="290px">메모</th>
						            </tr>
                <%
                	ArrayList<RegStudyBean> alist =  sMgr.getRegList(num);
                	if(alist.size() == 0){%>
                		<tr>
			                <td colspan="3">아직 신청자가 없습니다</td>
						</tr>
                <%  }else{	
                		for(int i = 0; i<alist.size(); i++){
                			RegStudyBean rbean = alist.get(i);
                			String name = rbean.getName();
                			String tel = rbean.getTel();
                			String content = rbean.getContent();
                			if(content == null){
                				content = "";
                			}
                %>
                		<tr>
			                <td><%=name %></td>
			                <td><%=tel %></td>
			                <td><%=content %></td>
						</tr>                		
                			
                	<%	}
           			}  %>   
						        </table>
						        <div class="buttons">
						            <button class="close">닫기</button>
						        </div>
                    	</div>
                    </div>
                    
                    <div class="window">
                        <div id="container">
                            <h3 class="subj">스터디 신청하기</h3>
                            <form name="regFrm" method="post" action="regStudy.jsp">
                            <table border="1">
                                <tr>
                                    <th width="55px">이름</th>
                                    <td><%=user.getName() %></td>
                                </tr>
                                <tr>
                                    <th>학번</th>
                                    <td><%=user.getNum() %></td>
                                </tr>
                                <tr>
                                    <th>연락처</th>
                                    <td><%=user.getTel() %></td>
                                </tr>
                                <tr>
                                    <th>메모</th>
                                    <td><textarea name="content" id="" cols="30" rows="8"></textarea></td>
                                </tr>
                            </table>
                            <input type="hidden" name="name" value="<%=user.getName() %>">
                            <input type="hidden" name="student_id" value="<%=user.getNum() %>">
                            <input type="hidden" name="tel" value="<%=user.getTel() %>">
                            <input type="hidden" name="num" value="<%=num%>">
                            <p>위 내용은 스터디장에게 전달됩니다</p>
                            <div class="buttons">
                                <input type="submit" value="신청">
                                <button class="close">닫기</button>
                            </div>
                            </form>
                        </div>
                    </div>
	                </div>
	                <div class="buttons">
	                <%
	                if(user.getNum().equals(bean.getStudent_id())){ %>
	                    <a href="javascript:list()">목록 </a>
	                    <a href="studyUpdate.jsp?nowPage=<%=nowPage%>&num=<%=num%>">| 수정 |</a>
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
								location.href="studyDelete.jsp?nowPage=<%=nowPage%>&num=<%=num%>";
							}
							
						}
	                </script>
	                <form name="listFrm" method="post" action="studyList.jsp">
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
	            </div>
	        </div>
        </div>
    </div>
</body>
</html>