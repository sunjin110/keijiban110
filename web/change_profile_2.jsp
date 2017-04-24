<%-- 
    Document   : change_profile_2
    Created on : 2017/04/23, 4:42:57
    Author     : yunsunjin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@page import="jamyto2.*"%>
<jsp:useBean class="jamyto2.BbsUser" id="user" scope="session"/>
<HTML>
<HEAD><TITLE>掲示板</TITLE></HEAD>
<BODY>
<%
request.setCharacterEncoding("UTF-8");
String strEmail = request.getParameter("email");
String strNickName = request.getParameter("nick_name");
user.setEmail(strEmail);
user.setNickName(strNickName);
boolean blResult = user.updateProfile();
if(blResult){%>
	設定を変更しました。<BR>
	ニックネーム：<%=TextConv.beforeHtml(user.getNickName())%><BR>
	メールアドレス：<%=TextConv.beforeHtml(user.getEmail())%><BR>
<%}else{%>
	指定されたメールアドレスは既に使われています。<BR>
<A HREF="javascript:history.back()">戻る</A><BR>
<%}%>
<A HREF="index.jsp">掲示板へ</A><BR>
</BODY>
</HTML>