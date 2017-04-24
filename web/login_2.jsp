<%-- 
    Document   : login_2
    Created on : 2017/04/23, 4:04:30
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<HTML>
<HEAD><TITLE><%=BbsSettings.strBbsName%></TITLE></HEAD>
<BODY>
<%
String strLoginName = request.getParameter("login_name");
String strPassword = request.getParameter("password");
StringBuffer sbResult = new StringBuffer();
boolean blResult = user.login(strLoginName,strPassword);
if(blResult){
	sbResult.append("ログインしました。<BR>こんにちは")
			.append(user.getNickName() + " さん<BR>");
	if(!user.getGoAfterLogin().equals("")){
		sbResult.append("<A HREF=\"")
			.append(user.getGoAfterLogin())
			.append("\">次へ</A><BR>");
	}else{
		sbResult.append("<A HREF=\"index.jsp\">掲示板へ</A>");
	}
}else{
	sbResult.append ("ログインまたはパスワードが違います。")
			.append("<A HREF=\"javascript:history.back()\">戻る</A>");
}%>
<%=sbResult.toString()%>
</BODY>
</HTML>
