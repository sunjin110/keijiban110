<%-- 
    Document   : edit_3
    Created on : 2017/04/21, 12:55:28
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*, javax.sql.*, javax.naming.*, java.util.Date, jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsArticle" id="article" scope="session"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>掲示板</title>
    </head>
    
    <%
        
        request.setCharacterEncoding("UTF-8");
        String strSubject = request.getParameter("subject");
        String strBody=request.getParameter("body");
        article.setSubject(strSubject);
        article.setBody(strBody);
        
        article.update();
        
        
       
    %>
    <body>
        
        更新を完了しました。<BR>
       
        
        <A HREF="index.jsp?jump_to=<%=article.getId()%>#<%=article.getId()%>">戻る</A><BR><!--あやしめ？-->
    </body>
</html>
