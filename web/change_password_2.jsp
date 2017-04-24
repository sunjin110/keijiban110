<%-- 
    Document   : change_password_2
    Created on : 2017/04/23, 4:31:16
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<HTML>
<HEAD><TITLE>パスワードの変更</TITLE></HEAD>
<BODY>
<%
String strOldPassword = request.getParameter("old_password");
String strNewPassword = request.getParameter("new_password");
String strResult;
boolean blResult = user.changePassword(strOldPassword,strNewPassword);
if(blResult){
	strResult = "パスワードを変更しました"
			+ "<A HREF=\"index.jsp\">掲示板へ</A>";
}else{
	strResult = "パスワードが違います。"
			+ "<A HREF=\"javascript:history.back()\">戻る</A>";
}%>
<%=strResult%>
</BODY>
</HTML>
