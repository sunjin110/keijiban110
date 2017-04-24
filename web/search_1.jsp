<%-- 
    Document   : search_1
    Created on : 2017/04/22, 2:56:02
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>検索</title>
    </head>
    <body>
        <FORM ACTION="search_2.jsp" METHOD="post">
            
            検索文字列<INPUT TYPE="text" NAME="search_string">
            <INPUT TYPE="submit" VALUE="検索">
            <INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
        </FORM>
    </body>
</html>
