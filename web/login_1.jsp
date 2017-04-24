<%-- 
    Document   : login_1
    Created on : 2017/04/23, 3:56:12
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD><TITLE>ログイン</TITLE></HEAD>
<BODY>
<FORM ACTION="login_2.jsp" METHOD="post">
【ログイン】<BR>
<TABLE>
<TR>
	<TD>ログイン名</TD>
	<TD><INPUT TYPE="text" NAME="login_name" SIZE="30" MAXLENGTH="20"></TD>
</TR>
<TR>
	<TD>パスワード</TD>
	<TD><INPUT TYPE="password" NAME="password" SIZE="30"  MAXLENGTH="20"></TD>
</TR>
</TABLE>
<INPUT TYPE="submit" VALUE="ログイン">
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>
