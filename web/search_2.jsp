<%-- 
    Document   : search_2
    Created on : 2017/04/22, 2:59:05
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsArticleList" id="articleList" scope="page"/>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>掲示板</title>
    </head>
    <body>
        [検索結果]<BR>
<%
request.setCharacterEncoding("UTF-8");
String strSearchString = request.getParameter("search_string");
articleList.search(strSearchString);
while(articleList.next()){
    BbsArticle article = articleList.getArticle();

%>   
No.<%=article.getId()%>:
<A HREF="index.jsp?jump_to=<%=article.getId()%>#<%=article.getId()%>"><%=article.getSubject()%></A><BR>
<%}%>
<BR>
<A HREF="javascript:history.back()">戻る</A>
    </body>
</html>
