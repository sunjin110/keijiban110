<%-- 
    Document   : edit_2
    Created on : 2017/04/21, 12:28:59
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsArticle" id="article" scope="session"/>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<HTML>
<HEAD>
<TITLE>掲示板</TITLE>
<SCRIPT TYPE="text/javascript">
function func_check(){
	if(document.form1.subject.value==""){
		alert("件名を入力してください");
		return false;
	}
}
</SCRIPT>
</HEAD>
<BODY>
【掲示板】<BR>
<%
int intId = Integer.parseInt(request.getParameter("id"));
boolean blResult;
if(user.getId()==0){
	String strPassword=request.getParameter("password");
	blResult = article.load(intId,strPassword);
}else{
	blResult = article.loadWithUserId(intId,user.getId());
}
if(blResult){%>



	<FORM NAME="form1" ACTION="edit_3.jsp" METHOD="post" ONSUBMIT="return func_check()">
            
            
	件名:<INPUT TYPE="text" NAME="subject" SIZE="80" VALUE="<%=article.getSubject()%>"><BR>
	本文:<TEXTAREA COLS="60" ROWS="5" NAME="body"><%=article.getBody()%></TEXTAREA><BR>
	<INPUT TYPE="submit" VALUE="送信">


	</FORM>
        
        
        
        
<%}else if(user.getId()==0){%>
	パスワードが違います。<BR>
<%}else{%>
	異なるユーザの記事は編集できません。<BR>
<%}%>
<INPUT TYPE="button" VALUE="戻る" onclick="history.back()">
</BODY>
</HTML>
