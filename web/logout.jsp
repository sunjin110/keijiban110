<%-- 
    Document   : logout
    Created on : 2017/04/23, 4:54:36
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    
    <%
    session.invalidate();
    %>
    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ログアウト</title>
    </head>
    <body>
        ログアウトしました。<A HREF="index.jsp">掲示板へ</A>
    </body>
</html>
