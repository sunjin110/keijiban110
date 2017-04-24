<%-- 
    Document   : change_password_1
    Created on : 2017/04/23, 4:30:06
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTML>
<HEAD><TITLE>パスワードの変更</TITLE>
<SCRIPT TYPE="text/javascript">
function func_check(){
	if(document.form1.new_password.value==""){
		alert("パスワードが空です");
		return false;
	}else if(document.form1.new_password.value!=document.form1.new_password2.value){
		alert("確認用のパスワードが違います");
		return false;
	}else{
		return true;
	}
}
</SCRIPT>
</HEAD>
<BODY>
<FORM NAME="form1" ACTION="change_password_2.jsp" METHOD="post" 
	ONSUBMIT="return func_check()">
【パスワードの変更】<BR>
<TABLE>
<TR>
	<TD>現在のパスワード</TD>
	<TD><INPUT TYPE="password" NAME="old_password" SIZE="30" MAXLENGTH="20"></TD>
</TR>
<TR>
	<TD>新しいパスワード</TD>
	<TD><INPUT TYPE="password" NAME="new_password" SIZE="30"  MAXLENGTH="20"></TD>
</TR>
<TR>
	<TD>新しいパスワード(確認用)</TD>
	<TD><INPUT TYPE="password" NAME="new_password2" SIZE="30"  MAXLENGTH="20"></TD>
</TR>
</TABLE>
<INPUT TYPE="submit" VALUE="送信">
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>

