<%-- 
    Document   : register_1
    Created on : 2017/04/23, 1:31:26
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ユーザー新規登録</title>
    </head>
    <body>
        <SCRIPT TYPE="text/javascript">
       function func_check(){
           if(document.form1.login_name.value==""){
               alert("ログイン名が空です");
               return false;
           }else if(document.form1.nick_name.value==""){
               alert("ニックネームが空です");
               return false;
           }else if(document.form1.password.value!=document.form1.password2.value){
               alert("確認用のパスワードが違います");
               return false;
           }
           
        else{
               return true;
           }
           
       }
        
    </SCRIPT>
    </body>
    <FORM NAME="form1" ACTION="register_2.jsp" METHOD="post" ONSUBMIT="return func_check();">
【ユーザ登録】<BR>
    <TABLE>
<TR>
	<TD>ログイン名</TD>
	<TD><INPUT TYPE="text" NAME="login_name" SIZE="30" MAXLENGTH="20"></TD>
</TR>
<TR>
	<TD>ニックネーム</TD>
	<TD><INPUT TYPE="text" NAME="nick_name" SIZE="30"  MAXLENGTH="20"></TD>
</TR>
<TR>
	<TD>メールアドレス</TD>
	<TD><INPUT TYPE="text" NAME="email" SIZE="30"  MAXLENGTH="64"></TD>
</TR>
<TR>
    <TD>パスワード</td>
    <TD><INPUT TYPE="password" NAME="password" SIZE="30"  MAXLENGTH="20"></TD>
    <TD>確認パスワード</TD>
    <TD><INPUT TYPE="password" NAME="password2" SIZE="30" MAXLENGTH="20"></TD>
    
</TR>

</TABLE>
パスワードを忘れるとログインできなくなります。<BR>
<INPUT TYPE="submit" VALUE="登録">
<INPUT TYPE="button" VALUE="戻る" ONCLICK="history.back()">
</FORM>
</BODY>
</HTML>
