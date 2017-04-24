<%-- 
    Document   : session_timeout
    Created on : 2017/04/21, 20:20:42
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>セッションエラー</title>
    </head>
    <body>
       　セッションがタイムアウトしました。<BR>
        登録、消去、更新の処理は行われていません<BR>
        <BR>
        現在サーバーで設定されているタイムアウトのインターバルは
        <%=session.getMaxInactiveInterval()/60%>分です。<BR>
        
    </body>
</html>
