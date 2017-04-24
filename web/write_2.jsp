<%-- 
    Document   : write_2
    Created on : 2017/04/20, 19:01:25
    Author     : yunsunjin
--%>

<%@page import="jamyto2.TextConv"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*,javax.sql.*,javax.naming.*,java.util.Date"%>
<%@page import="jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsArticle" id="article" scope="session"/>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=BbsSettings.strBbsName%></title>
    </head>
    
    <%
    
     
        /*
        request.setCharacterEncoding("UTF-8");
        
        String strAuthor = request.getParameter("author");
        String strSubject = request.getParameter("subject");
        String strBody = request.getParameter("body");
        String strPassword = request.getParameter("password");
        article.setAuthor(strAuthor);
        article.setSubject(strSubject);
        article.setBody(strBody);
        
        
        
        
        article.add(strPassword);
        
        String strAuthorEncoded = 
                java.net.URLEncoder.encode(article.getAuthor(), "UTF-8");
        
        Cookie coo =
            new Cookie("auther",java.net.URLEncoder.encode(strAuthor, "UTF-8"));
        coo.setMaxAge(60*60*24*30);
        response.addCookie(coo);
        
    */
    
    request.setCharacterEncoding("UTF-8");
String strPassword="";
if(user.getId()!=0){
	article.setAuthorId(user.getId());
}else{
	String strAuthor = request.getParameter("author");
	strPassword = request.getParameter("password");
	String strEmail = request.getParameter("email");
	article.setAuthor(strAuthor);
	article.setEmail(strEmail);
}
String strSubject = request.getParameter("subject");
String strBody = request.getParameter("body");
article.setSubject(strSubject);
article.setBody(strBody);
try{
	article.add(strPassword);
}catch(SessionTimeoutException e){
	%><jsp:forward page="/error/session_timeout.jsp"/><%
}
if(user.getId()==0){	//クッキーの書き込み
	String strAuthorEncoded
		 = java.net.URLEncoder.encode(article.getAuthor(),"UTF-8");
	Cookie coo = new Cookie("auther",strAuthorEncoded);
	coo.setMaxAge(60*60*24*30);
	response.addCookie(coo);
	Cookie coo2 = new Cookie("email",request.getParameter("email"));
	coo2.setMaxAge(60*60*24*30);
	response.addCookie(coo2);
}
    
    %>
    
    
    
    <body>
        書き込みを完了しました<BR>
        <A HREF="index.jsp?jump_to=<%=article.getId()%>#<%=article.getId()%>">戻る</A>
    </body>
</html>
