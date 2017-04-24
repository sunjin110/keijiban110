<%-- 
    Document   : context-param_test
    Created on : 2017/04/23, 1:03:23
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>てすと</title>
    </head>
    <body>
        admin email:<%=application.getInitParameter("adminEmailAddress")%><BR>
        admin name:<%=application.getInitParameter("adminName")%><BR>
    </body>
</html>
