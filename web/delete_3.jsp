<%-- 
    Document   : delete_3
    Created on : 2017/04/21, 9:12:26
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*, javax.sql.*, javax.naming.*, java.util.Date, jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsArticle" id="article" scope="session"/>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>掲示板</title>
    </head>
    
    <%
      try{
	if(user.getId()==article.getAuthorId()){
		article.delete();
	}else if(user.isAdmin()){
		article.hide();
	}else{
		throw new Exception("権限エラーです。");
	}
}catch(SessionTimeoutException e){
	%><jsp:forward page="/error/session_timeout.jsp"/><%
}
    %>
    <body>
       
        消去を完了しました。<BR>
       
        <A HREF="index.jsp?jump_to=<%=article.getId()%>#<%=article.getId()%>">戻る</A><BR><!--あやしめ？-->
    </body>
</html>
