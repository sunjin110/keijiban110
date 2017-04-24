<%-- 
    Document   : mail_test_1
    Created on : 2017/04/22, 20:21:59
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<HTML>
<HEAD><TITLE>メールテスト</TITLE></HEAD>
<BODY>
<FORM ACTION="mail_test_2.jsp" METHOD="post">
送信元<INPUT TYPE="text" NAME="from" size="30"><BR>
宛先<INPUT TYPE="text" NAME="to" size="30"><BR>
件名<INPUT TYPE="text" NAME="subject" size="30"><BR>
本文<BR>
<TEXTAREA NAME="body" cols="60" rows="5"></TEXTAREA><BR>
<INPUT TYPE="submit" VALUE="送信">
</FORM>
</BODY>
</HTML>
