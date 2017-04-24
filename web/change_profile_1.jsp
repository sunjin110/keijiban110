<%-- 
    Document   : change_profile_1
    Created on : 2017/04/23, 4:40:09
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<HTML>
<HEAD><TITLE>ユーザ設定の変更</TITLE>
<SCRIPT TYPE="text/javascript">
function func_check(){
	if(document.form1.nick_name.value==""){
		alert("ニックネームが空です");
		return false;
	}else{
		return true;
	}
}
</SCRIPT>
</HEAD>
<BODY>
<FORM NAME="form1" ACTION="change_profile_2.jsp" METHOD="post" ONSUBMIT="return func_check()">
【ユーザ設定の変更】<BR>
<TABLE>
<TR>
	<TD>ニックネーム</TD>
	<TD><INPUT TYPE="text" NAME="nick_name" SIZE="30" 
		MAXLENGTH="20" VALUE="<%=user.getNickName()%>"></TD>
</TR>
<TR>
	<TD>メールアドレス</TD>
	<TD><INPUT TYPE="text" NAME="email" SIZE="30" MAXLENGTH="60" 
		VALUE="<%=user.getEmail()%>"></TD>
</TR>
</TABLE>
<INPUT TYPE="submit" VALUE="送信">
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>
